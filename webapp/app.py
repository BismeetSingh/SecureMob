import requests
import json
from datetime import datetime
from cs50 import SQL
from flask import (
    Flask,
    flash,
    redirect,
    render_template,
    request,
    session,
    jsonify,
)
from flask_session import Session
from werkzeug.security import check_password_hash
from functools import wraps
import json


# Configure application
app = Flask(__name__)

with open("commands.json", "r") as file:
    commands_data = json.load(file)


# Ensure templates are auto-reloaded
app.config["TEMPLATES_AUTO_RELOAD"] = True

# Configure session to use filesystem (instead of signed cookies)
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)

db = SQL("sqlite:///sqlite.db")


@app.after_request
def after_request(response):
    """Ensure responses aren't cached"""
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Expires"] = 0
    response.headers["Pragma"] = "no-cache"
    return response


def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if session.get("user_id") is None:
            return redirect("/login")
        return f(*args, **kwargs)

    return decorated_function


# JSON Exporter


def generate_commands(commands_list, commands_json):
    output = {}
    for command in commands_list:
        command = command.strip()
        for category, category_commands in commands_json.items():
            if command in category_commands:
                output[command] = category_commands[command]

    return output


@app.route("/", methods=["GET", "POST"])
@login_required
def home():
    return redirect("/members")


# Members


# Members Page
@app.route("/members", methods=["GET", "POST"])
@login_required
def members():
    if request.method == "POST":
        search_term = request.form.get("query")
        query = f"""
            SELECT *
            FROM members
            WHERE id LIKE '%{search_term}%'
                OR name LIKE '%{search_term}%'
                OR email LIKE '%{search_term}%'

        """
        members = db.execute(query)
        title = "Search Results"

    else:
        members = db.execute("SELECT * FROM members ORDER BY doj DESC LIMIT 10")
        search_term = ""
        title = "Recent Members"
    try:
        mem_num = db.execute("SELECT * FROM members ORDER BY id DESC LIMIT 1")[0]["id"]
        mem_num = int(mem_num) + 1
    except:
        mem_num = 1

    return render_template(
        "members.html",
        search_term=search_term,
        mem_num=mem_num,
        members=members,
        title=title,
        commands=commands_data,
    )


@app.route("/export", methods=["POST"])
def export():
    selected_commands = request.get_json()
    print(selected_commands)
    with open("selected_commands.json", "w") as file:
        json.dump(selected_commands, file, indent=2)
    return jsonify(success=True)


# Add A Member
@app.route("/add_member", methods=["POST"])
def add_member():
    name = request.form["name"]
    email = request.form["email"]
    options = []
    for i in request.form:
        if i not in ("name", "email", "member_id"):
            options.append(i)
    options = ",".join(options)
    date_of_joining = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    db.execute(
        "INSERT INTO members (name, email, doj,options) VALUES (?, ?,?,?)",
        name,
        email,
        date_of_joining,
        options,
    )
    return redirect("/members")


# Delete a member
@app.route("/delete_member", methods=["POST"])
def delete_member():
    member_id = int(request.form.get("member_id"))
    try:
        db.execute("DELETE FROM members WHERE id = ?", member_id)
    except:
        flash("Member has books to return.", "red")
    else:
        flash("Member deleted successfully.", "green")
    return redirect("/members")


# Edit Memeber
@app.route("/edit_member", methods=["POST"])
def edit_member():
    print(request.form)
    member_id = int(request.form["member_id"])
    name = request.form["name"]
    email = request.form["email"]
    options = []
    for i in request.form:
        if i not in ("name", "email", "member_id"):
            options.append(i)
    options = ",".join(options)
    db.execute(
        "UPDATE members SET name = ?, email = ?, options = ? WHERE id = ?",
        name,
        email,
        options,
        member_id,
    )

    return redirect("/members")


# Member Info
@app.route("/member_info/<id>", methods=["GET"])
@login_required
def member_info(id):
    info = db.execute("SELECT * from members WHERE id = ?", id)[0]
    x = info["options"]
    lst = x.split(",")
    result = generate_commands(lst, commands_data)
    with open("selected_commands.json", "w") as outfile:
        json.dump(result, outfile, indent=2)
    return render_template("member_info.html", info=info, lst=lst)


# Login


@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        if not request.form.get("username"):
            flash("Please Enter Username", "yellow")
            return redirect("/login")

        elif not request.form.get("password"):
            flash("Please Enter Password", "red")
            return redirect("/login")
        username = request.form.get("username").lower().strip()
        rows = db.execute("SELECT * FROM users WHERE username = ?", username)
        password = request.form.get("password")
        if len(rows) != 1 or not check_password_hash(rows[0]["hash"], password):
            flash("Invalid username and/or password", "red")
            return redirect("/login")
        session["user_id"] = rows[0]["id"]
        flash("Login Successful, Welcome.", "green")
        return redirect("/members")
    else:
        return render_template("login.html")


# Logout
@app.route("/logout")
def logout():
    # Forget any user_id
    session.clear()
    return redirect("/")


if __name__ == "__main__":
    app.run(debug=True)