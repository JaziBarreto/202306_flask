from flask import Flask, render_template, request, redirect, session
app = Flask (__name__)

@app.route('/')
def index():
    return render_template("index.html")

@app.route('/users', methods=['POST'])
def create_user():
    print("Got Post Info")
    session['username'] = request.form['name'] #con estas dos prop ya tenemos acceso a esos datos de post
    session['useremail'] = request.form['email']
    return redirect('/show') #FUNDAMENTAL DIRECCIONAR A LA PAGINA DE ORIGEN

@app.route('/show')
def show_user():
    return render_template('show.html')


if __name__ == "__main__":
    app.run(debug=True)