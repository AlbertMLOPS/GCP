from flask import Flask
import os
 
app = Flask(__name__)
 
@app.route("/")
def hello_world():
    return "<p>Hola desde mi Flask simple!</p>"