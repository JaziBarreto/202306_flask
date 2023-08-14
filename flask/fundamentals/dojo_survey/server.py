from flask import Flask, render_template, request, redirect, session
app = Flask (__name__)
app.secret_key = 'keep it secret, keep it safe' 

@app.route('/')
def index():
    return render_template("index.html")

@app.route('/users', methods=['POST'])
def create_user():
    session['username'] = request.form['name']
    session['userlocation'] = request.form['location']
    session['userlanguage'] = request.form['language']
    session['usercomment'] = request.form['comment']
    return redirect('/result')

@app.route('/result')
def show_user():
    return render_template('result.html')

if __name__ == "__main__":
    app.run(debug=True)