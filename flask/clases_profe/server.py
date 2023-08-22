import random
from flask import Flask, render_template, request, redirect, session, flash
app = Flask(__name__)
app.secret_key = 'cualquier cosa'
@app.route('/')          
def hola_mundo():
    return """
        <h1>Hola Mundo!</h1>
        <p>Esto es un parrafo</p>
    """

@app.route('/pancho')          
def pancho():
    return 'Hola Mundo desde PANCHO!'

@app.route('/success')
def success():
    return "success"

@app.route('/hola/<name>') # para una ruta '/hola /____' cualquier cosa después de que '/hola/' se pase como una variable 'name'
def hola(name):
    print("funcion hola:", name)
    return "Hola, " + name

@app.route('/hola/francisco')
def francisco():
    return "HOLA ESPECIAL A FRANCISCO!!!!"


@app.route('/pacientes/<id>/eliminar')
def pacientes_eliminar(id):
    return "eliminando a paciente " + id



# http://127.0.0.1:5000/m/351/11267/77235
#                       m/351/11267/77234
@app.route('/m/<track>/<unidad>/<pagina>')
def coding_dojo(track, unidad, pagina):
    return f"Estas en el track {track} en la unidad {unidad} en la página {pagina}"


@app.route('/render/inicio')
def render_inicio():

    usuario_id = 10
    usuario_nombre = "Francisco"

    usuario_dict = {
        'usuario': usuario_id,
        'nombre': usuario_nombre,
        'edad': 90,
        'pasatiempos': [
            {'nombre': 'programar', 'tiempo': 8}, 
            {'nombre': 'musica', 'tiempo': 1 }, 
            {'nombre': 'videojuegos', 'tiempo': 0}, 
        ]
    }
    
    return render_template('inicial.html', usuario=usuario_id, nombre=usuario_nombre, usuario_dict=usuario_dict)

@app.route('/persona')
def persona():
    return render_template('persona.html', nombre="Francisco")

@app.route('/ejemplo')
def ejemplo():
    return render_template('ejemplo.html')

@app.route('/formulario')
def formulario():
    nombre = ""
    email = ""
    if 'nombre' in session:
        nombre = session['nombre']
    if 'email' in session:
        email = session['email']

    return render_template("formulario.html", nombre=nombre, email=email)

@app.route('/formulario/<nombre>/<email>')
def formulario_dos(nombre, email):
    return render_template("formulario.html", nombre=nombre, email=email)

@app.route('/proceso_formulario', methods=['POST'])
def proceso_formulario():
    print(request.form)
    print(request.form['nombre'])

    session['nombre'] = request.form['nombre']
    session['email'] = request.form['email']

    if request.form['tipo'] == "casa":
        flash(f"Que linda casa", "info" )
    else:
        flash(f"Que gran edificio", "error" )

    #return redirect(f"/formulario/{request.form['nombre']}/{request.form['email']}")
    flash(f"Ejecutaste correctamente el formulario con estos datos NOMBRE: {request.form['nombre']} y el correo: {request.form['email']}", "info" )
    return redirect("/formulario")

@app.route('/limpiar')
def limpiar():

    if 'nombre' in session:
        del session['nombre']
    if 'email' in session:
        del session['email']

    session.clear()

    flash("Esto es como se veria un error", "error")
    flash("Acabamos de limpiar tus variables de sesión!", "success")
    flash("Asi se ve info", "info")
    flash("Asi se ve warning", "warning")
    return redirect("/formulario")


@app.route('/casino')
def casino():
    return render_template("casino.html", oro=1000)


@app.route('/process_money', methods=['POST'])
def process_money():
    print(request.form)
    print(request.form["opcion"])

    numero_aleatorio = random.randint(5, 10)

    if 'oro' not in session:
        session['oro'] = 0
    if 'lista' not in session:    
        session['lista'] = []

    session['oro'] = session['oro'] + numero_aleatorio

    session['lista'].append(f"Agregaste {numero_aleatorio}  de oro!")


    return redirect("/casino")

if __name__=="__main__":
    app.run(debug=True)
