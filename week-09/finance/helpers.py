import requests

from enum import Enum
from dataclasses import dataclass
from datetime import datetime
from functools import wraps
from sqlite3 import Connection, IntegrityError
from flask import redirect, render_template, session, Request
from flask_session import base as session_base
from werkzeug.security import generate_password_hash, check_password_hash

class Order(Enum):
    Buy = 'buy'
    Sell = 'sell'

@dataclass
class User:
    id: int
    username: str
    hash: str
    cash: float

@dataclass
class UserBalance:
    available: float
    all_assets: float

@dataclass
class Stock:
    symbol: str
    company_name: str
    price: float

@dataclass
class OwnedStock:
    id: int
    owner_id: int
    symbol: str
    shares: int

@dataclass
class UserStock:
    id: int
    user_id: int
    symbol: str
    price: float
    shares: int
    total: float

@dataclass
class Transaction:
    id: int
    user_id: int
    order: Order
    symbol: str
    price: float
    shares: int
    timestamp: datetime

@dataclass
class CreateTransactionDTO:
    user_id: int
    order: Order
    symbol: str
    price: float
    shares: int
    timestamp: datetime

@dataclass
class ShareTrxDTO:
    symbol: str
    shares: int


def apology(message, code=400):
    """Render message as an apology to user."""

    def escape(s):
        """
        Escape special characters.

        https://github.com/jacebrowning/memegen#special-characters
        """
        for old, new in [
            ("-", "--"),
            (" ", "-"),
            ("_", "__"),
            ("?", "~q"),
            ("%", "~p"),
            ("#", "~h"),
            ("/", "~s"),
            ('"', "''"),
        ]:
            s = s.replace(old, new)
        return s

    return render_template("apology.html", top=code, bottom=escape(message)), code


def login_required(f):
    """
    Decorate routes to require login.

    https://flask.palletsprojects.com/en/latest/patterns/viewdecorators/
    """

    @wraps(f)
    def decorated_function(*args, **kwargs):
        if session.get("user_id") is None:
            return redirect("/login")
        return f(*args, **kwargs)

    return decorated_function


def lookup(symbol: str) -> Stock | None:
    """Look up quote for symbol."""
    url = f"https://finance.cs50.io/quote?symbol={symbol.upper()}"
    try:
        response = requests.get(url)
        response.raise_for_status()  # Raise an error for HTTP error responses
        quote_data = response.json()
        return Stock(symbol=symbol.upper(), company_name=quote_data["companyName"], price=quote_data["latestPrice"])
    except requests.RequestException as e:
        print(f"Request error: {e}")
    except (KeyError, ValueError) as e:
        print(f"Data parsing error: {e}")
    return None


def usd(value: float) -> str:
    """Format value as USD."""
    return f"${value:,.2f}"


def make_user_stock(stock: OwnedStock) -> UserStock:
    stock_info = lookup(stock.symbol)
    total = stock.shares * stock_info.price
    return UserStock(id=stock.id, user_id=stock.owner_id, symbol=stock.symbol, price=stock_info.price, shares=stock.shares, total=total)


def calc_all_user_assets(user: User, stocks: list[UserStock]) -> float:
    all_assets: float = user.cash
    for stock in stocks:
        all_assets += stock.total
    
    return all_assets


def calc_user_balance(user: User, stocks: list[UserStock]) -> UserBalance:
    all_assets = calc_all_user_assets(user, stocks)
    return UserBalance(available=user.cash, all_assets=all_assets)


def get_timestamp_milli(dt: datetime) -> int:
    """Returns the transaction unix timestamp in milliseconds"""
    return int(dt.timestamp() * 1000)


def datetime_from_timestamp_milli(timestamp: int) -> datetime:
    return datetime.fromtimestamp(timestamp / 1000.0)


def make_buy_transaction(user_id: int, order: ShareTrxDTO, price: float) -> CreateTransactionDTO:
    return CreateTransactionDTO(user_id=user_id, order=Order.Buy, symbol=order.symbol, price=price, shares=order.shares, timestamp=datetime.now())


def make_sell_transaction(user_id: int, order: ShareTrxDTO, price: float) -> CreateTransactionDTO:
    return CreateTransactionDTO(user_id=user_id, order=Order.Sell, symbol=order.symbol, price=price, shares=order.shares, timestamp=datetime.now())


def load_user(db: Connection, id: int) -> User | None:
    try:
        cursor = db.cursor()
        users = cursor.execute("SELECT * FROM users WHERE id = ? LIMIT 1", (str(id))).fetchall()
        user = users[0]
        return User(id=user[0], username=user[1], hash=user[2], cash=user[3])
    except ValueError:
        return None


def load_user_by_username(db: Connection, username: str) -> User | None:
    try:
        cursor = db.cursor()
        users = cursor.execute("SELECT * FROM users WHERE username = ? LIMIT 1", (username,)).fetchall()
        user = users[0]
        return User(id=user[0], username=user[1], hash=user[2], cash=user[3])
    except ValueError:
        return None


def update_user_cash(db: Connection, id: int, cash: float):
    db.cursor().execute("UPDATE users SET cash = ? WHERE id = ?", (str(cash), str(id)))


def update_user_shares(db: Connection, user_id: int, order: Order, symbol: str, shares: int) -> OwnedStock:
    sqlcmd = "INSERT INTO user_stocks (user_id, symbol, shares) VALUES (?, ?, ?)" \
        " ON CONFLICT DO UPDATE SET shares = shares "
    sqlcmd += "+" if order == Order.Buy else "-"
    sqlcmd += " ? RETURNING *"
    cursor = db.cursor()
    rows = cursor.execute(sqlcmd, (str(user_id), symbol, str(shares), str(shares))).fetchall()
    row = rows[0]
    return OwnedStock(id=row[0], owner_id=row[1], symbol=row[2], shares=row[3])


def load_user_stocks(db: Connection, user_id: int) -> list[OwnedStock]:
    try:
        user_stocks = []
        cursor = db.cursor()
        stocks = cursor.execute("SELECT * FROM user_stocks WHERE user_id = ?", (str(user_id))).fetchall()

        for stock in stocks:
            user_stocks.append(OwnedStock(id=stock[0], owner_id=stock[1], symbol=stock[2], shares=stock[3]))
        
        return user_stocks
    except ValueError:
        return []


def load_user_stock_symbols(db: Connection, user_id: int) -> list[str]:
    try:
        symbols = []
        cursor = db.cursor()
        stocks = cursor.execute("SELECT symbol FROM user_stocks WHERE user_id = ?", (str(user_id))).fetchall()

        for stock in stocks:
            symbols.append(str(stock[0]))
        
        return symbols
    except ValueError:
        return []


def load_user_stock(db: Connection, user_id: int, symbol: str) -> OwnedStock | None:
    try:
        cursor = db.cursor()
        stocks = cursor.execute("SELECT * FROM user_stocks WHERE user_id = ? AND symbol = ? LIMIT 1", (str(user_id), symbol)).fetchall()
        if len(stocks) != 1:
            return None

        stock = stocks[0]
        return (OwnedStock(id=stock[0], owner_id=stock[1], symbol=stock[2], shares=stock[3]))
    except ValueError:
        return None


def load_transaction(db: Connection, id: int) -> Transaction | None:
    cursor = db.cursor()
    rows = cursor.execute("SELECT * FROM user_transactions WHERE id = ? LIMIT 1", (str(id))).fetchall()
    if len(rows) != 1:
        return None
    
    row = rows[0]
    return Transaction(
        id=row[0],
        user_id=row[1],
        order=Order(row[2]),
        symbol=row[3],
        price=row[4],
        shares=row[5],
        timestamp=datetime_from_timestamp_milli(row[6])
    )


def load_user_transactions(db: Connection, user_id: int) -> list[Transaction]:
    cursor = db.cursor()
    try:
        trxs = []
        rows = cursor.execute("SELECT * FROM user_transactions WHERE user_id = ?", (str(user_id))).fetchall()

        for row in rows:
            trxs.append(
                Transaction(
                    id=row[0],
                    user_id=row[1],
                    order=Order(row[2]),
                    symbol=row[3],
                    price=row[4],
                    shares=row[5],
                    timestamp=datetime_from_timestamp_milli(row[6])
                )
            )
        
        return trxs
    except ValueError:
        return []


def insert_transaction(db: Connection, trx: CreateTransactionDTO):
    db.cursor().execute(
        "INSERT INTO user_transactions (user_id, direction, symbol, price, shares, timestamp)" \
            " VALUES (?, ?, ?, ?, ?, ?)",
        (
            str(trx.user_id),
            trx.order.value,
            trx.symbol,
            str(trx.price),
            str(trx.shares),
            str(get_timestamp_milli(trx.timestamp))
        )
    )


def get_authenticated_user(db: Connection, session: session_base.ServerSideSession) -> User | None:
    user_id = session["user_id"]
    if not user_id:
        return None
    return load_user(db, user_id)


def register_user(db: Connection, request: Request):
    username = request.form.get("username")
    if not username:
        return apology("username is invalid")
    password = request.form.get("password")
    if not password:
        return apology("password is invalid")
    confirm = request.form.get("confirmation")
    if not confirm or password != confirm:
        return apology("password confirmation is invalid")
    
    password_hash = generate_password_hash(password)

    try:
        db.cursor().execute("INSERT INTO users (username, hash) VALUES (?, ?)", (username, password_hash))
    except IntegrityError:
        return apology("username already exists")

    return redirect("/")


def authenticate_user(db: Connection, request: Request):
    # Ensure username was submitted
    if not request.form.get("username"):
        return apology("must provide username", 403)

    # Ensure password was submitted
    if not request.form.get("password"):
        return apology("must provide password", 403)

    # Query database for username
    user = load_user_by_username(db, request.form.get("username"))

    # Ensure username exists and password is correct
    if not user or not check_password_hash(user.hash, request.form.get("password")):
        return apology("invalid username and/or password", 403)

    # Remember which user has logged in
    session["user_id"] = user.id

    # Redirect user to home page
    return redirect("/")


def render_main_page(user: User, balance: UserBalance, stocks: list[UserStock]):
    fmt_balance = { "available": usd(balance.available), "all_assets": usd(balance.all_assets) }
    fmt_stocks = []
    for stock in stocks:
        fmt_stocks.append({ "symbol": stock.symbol, "price": usd(stock.price), "shares": stock.shares, "total": usd(stock.total) })
    
    return render_template("index.html", username=user.username, balance=fmt_balance, stocks=fmt_stocks)


def render_history_page(transactions: list[Transaction]):
    fmt_trxs = []
    for trx in transactions:
        fmt_trxs.append({
            "symbol": trx.symbol,
            "order": trx.order.value,
            "price": usd(trx.price),
            "shares": trx.shares,
            "timestamp": trx.timestamp
        })
    
    return render_template("history.html", transactions=fmt_trxs)


def render_unauthenticated_error():
    return apology("not authenticated - return to login", 401)


def parse_transaction_shares(request: Request) -> ShareTrxDTO | None:
    symbol = request.form.get("symbol")
    shares = request.form.get("shares")
    
    if not symbol or not shares:
        return None
    
    try:
        shares = int(shares)
        if shares <= 0:
            return None
        
        symbol = str(symbol)
        if len(symbol) <= 2:
            return None
        
        return ShareTrxDTO(symbol=symbol, shares=shares)
    except ValueError:
        return None
