import sqlite3
from flask import Flask, redirect, render_template, request, session
from flask_session import Session

from helpers import (
    UserStock, apology, login_required, lookup, usd, register_user, authenticate_user,
    get_authenticated_user, calc_user_balance, load_user_stocks, parse_transaction_shares,
    render_main_page, render_history_page, render_unauthenticated_error, make_user_stock,
    make_buy_transaction, load_user_stock, make_sell_transaction, update_user_cash,
    update_user_shares, insert_transaction, load_user_stock_symbols, load_user_transactions
)

# Configure application
app = Flask(__name__)

# Custom filter
app.jinja_env.filters["usd"] = usd

# Configure session to use filesystem (instead of signed cookies)
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)

db = sqlite3.connect("finance.db", check_same_thread=False, autocommit=True)


@app.after_request
def after_request(response):
    """Ensure responses aren't cached"""
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Expires"] = 0
    response.headers["Pragma"] = "no-cache"
    return response


@app.route("/")
@login_required
def index():
    """Show portfolio of stocks"""
    
    user = get_authenticated_user(db, session)
    if not user:
        return render_unauthenticated_error()
    
    stocks = load_user_stocks(db, user.id)

    user_stocks: list[UserStock] = []
    for stock in stocks:
        user_stocks.append(make_user_stock(stock))

    balance = calc_user_balance(user, user_stocks)

    return render_main_page(user, balance, user_stocks)


@app.route("/login", methods=["GET", "POST"])
def login():
    """Log user in"""

    # Forget any user_id
    session.clear()

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":
        return authenticate_user(db, request)
    # User reached route via GET (as by clicking a link or via redirect)
    else:
        return render_template("login.html")


@app.route("/logout")
def logout():
    """Log user out"""

    # Forget any user_id
    session.clear()

    # Redirect user to login form
    return redirect("/login")


@app.route("/register", methods=["GET", "POST"])
def register():
    """Register user"""

    if request.method == "GET":
        return render_template("register.html")
    else:
        return register_user(db, request)


@app.route("/quote", methods=["GET", "POST"])
@login_required
def quote():
    """Get stock quote."""

    if request.method == "POST":
        symbol = request.form.get("symbol")
        if not symbol:
            return apology("invalid stock symbol")
        
        stock = lookup(symbol)
        if not stock:
            return apology("invalid stock symbol")
        return render_template("quoted.html", name=stock.company_name, price=usd(stock.price), symbol=stock.symbol)
    else:
        return render_template("quote.html")


@app.route("/buy", methods=["GET", "POST"])
@login_required
def buy():
    """Buy shares of stock"""
    if request.method == "POST":
        order_dto = parse_transaction_shares(request)
        if not order_dto:
            return apology("invalid buy order")
        
        stock = lookup(order_dto.symbol)
        if not stock:
            return apology("symbol not found")
        
        user = get_authenticated_user(db, session)
        if not user:
            return render_unauthenticated_error()
        
        total_price = stock.price * order_dto.shares
        if user.cash < total_price:
            return apology("not enough funds")
        
        user.cash = user.cash - total_price
        trx = make_buy_transaction(user.id, order_dto, stock.price)

        update_user_cash(db, user.id, user.cash)
        update_user_shares(db, user.id, trx.order, trx.symbol, trx.shares)
        insert_transaction(db, trx)

        return redirect("/")
    else:
        return render_template("buy.html")


@app.route("/sell", methods=["GET", "POST"])
@login_required
def sell():
    """Sell shares of stock"""
    if request.method == "POST":
        order_dto = parse_transaction_shares(request)
        if not order_dto:
            return apology("invalid sell order")
        
        user = get_authenticated_user(db, session)
        if not user:
            return render_unauthenticated_error()
        
        user_stock = load_user_stock(db, user.id, order_dto.symbol)
        if not user_stock or user_stock.shares < order_dto.shares:
            return apology("user does not have enough stock")

        stock = lookup(order_dto.symbol)
        if not stock:
            return apology("symbol not found")
        
        total_value = stock.price * order_dto.shares
        
        user.cash = user.cash + total_value
        trx = make_sell_transaction(user.id, order_dto, stock.price)

        update_user_cash(db, user.id, user.cash)
        update_user_shares(db, user.id, trx.order, trx.symbol, trx.shares)
        insert_transaction(db, trx)

        return redirect("/")
    else:
        user = get_authenticated_user(db, session)
        if not user:
            return render_unauthenticated_error()
        
        symbols = load_user_stock_symbols(db, user.id)
        return render_template("sell.html", symbols=symbols)


@app.route("/history")
@login_required
def history():
    """Show history of transactions"""
    user = get_authenticated_user(db, session)
    if not user:
        return render_unauthenticated_error()
    
    trxs = load_user_transactions(db, user.id)
    return render_history_page(trxs)
