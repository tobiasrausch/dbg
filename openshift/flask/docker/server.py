import os
from flask import Flask
app = Flask(__name__)

@app.route("/")
def main():
    return "Hello from the pod universe"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug=True, threaded=True)
