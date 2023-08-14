from flask import Flask, render_template, request, redirect
app = Flask(__name__)  

@app.route('/')         
def index():
    return render_template("index.html")

@app.route('/checkout', methods=['POST'])         
def checkout():
    first_name = request.form.get('first_name', '')
    last_name = request.form.get('last_name', '')
    student_ID = request.form.get('student_ID', '')

    client = {
        'first_name': first_name,
        'last_name': last_name,
        'student_ID': student_ID
        }
    return render_template("checkout.html", client = client)

@app.route('/fruits')         
def fruits():
    return render_template("fruits.html")

if __name__=="__main__":   
    app.run(debug=True)    