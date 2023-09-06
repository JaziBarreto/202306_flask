from flask_app import app
from flask_app.controllers import ninjas
from flask_app.controllers import dojos
from dotenv import load_dotenv

load_dotenv()

if __name__ == "__main__":
    app.run(debug=True)