from flask import Flask
import os
app= Flask(__name__)
app_secret_key= os.getenv("FLASK_SECRET_KEY")