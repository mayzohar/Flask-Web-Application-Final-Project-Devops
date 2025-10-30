from flask import Flask, render_template, request, jsonify

app = Flask(__name__)

@app.route("/")
def hello():
    return render_template('hello.html')

@app.route("/next")
def next_page():
    return render_template("next.html")

if __name__ == "__main__":
    app.run(debug=True)
