import os

from dataclasses import dataclass
from cs50 import SQL
from flask import Flask, redirect, render_template, request

# Configure application
app = Flask(__name__)

# Ensure templates are auto-reloaded
app.config["TEMPLATES_AUTO_RELOAD"] = True

# Configure CS50 Library to use SQLite database
db = SQL("sqlite:///birthdays.db")


@app.after_request
def after_request(response):
    """Ensure responses aren't cached"""
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Expires"] = 0
    response.headers["Pragma"] = "no-cache"
    return response


@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        entity = parse_user_birtday(request.form)
        if not entity:
            redirect("/")

        create_user_entry(entity)
        return redirect("/")
    else:
        birthdays = get_user_entries()
        return render_template("index.html", birthdays=birthdays)

@dataclass
class UserBirthday:
    name: str
    month: int
    day: int

def parse_user_birtday(form) -> UserBirthday | None:
    name = form.get("name")
    if not name:
        return None
    
    month = request.form.get("month")
    if not month:
        return None
    try:
        month = int(month)
    except ValueError:
        return None
    if month < 1 or month > 12:
        return None
    
    day = request.form.get("day")
    if not day:
        return None
    try:
        day = int(day)
    except ValueError:
        return None
    if day < 1 or day > 31:
        return None
    
    return UserBirthday(name=name, month=month, day=day)

def create_user_entry(dto: UserBirthday):
    db.execute("INSERT INTO birthdays (name, month, day) VALUES (?, ?, ?)", dto.name, dto.month, dto.day)

def get_user_entries() -> list[UserBirthday]:
    birthdays = db.execute("SELECT * FROM birthdays")
    return birthdays
