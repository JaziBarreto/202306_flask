from flask import Flask, flash, redirect, render_template, session

# from flask_app.models.bodega import Bodega

from flask_app import app


@app.route('/')
def inicio():
    if "user" not in session: #es decir, si el usuario no esta en session
        flash("Usted no ha iniciado sesion", "error")
        return redirect("/index.html")
    flash("Bienvenido otra vez", "info")
    return render_template(
        'paintings.html')
        # bodegas=Bodega.get_all(), #de aca obtendria todos los datos