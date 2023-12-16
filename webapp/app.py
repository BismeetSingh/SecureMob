from flask import Flask, render_template, request, jsonify
import json

app = Flask(__name__)

with open("commands.json", "r") as file:
    commands_data = json.load(file)


@app.route("/")
def index():
    return render_template("index.html", commands=commands_data)


@app.route("/export", methods=["POST"])
def export():
    selected_commands = request.get_json()
    print(selected_commands)
    with open("selected_commands.json", "w") as file:
        json.dump(selected_commands, file, indent=2)
    return jsonify(success=True)


if __name__ == "__main__":
    app.run(debug=True)
