from flask import render_template, request, redirect, session, flash
from bodega import Bodega
from categoria import Categoria
from subcategoria import Subcategoria
from flask_app import app



@app.route('/ejemplo')
def ejemplo():
    return render_template(
        'ejemplo.html',
        bodegas=Bodega.get_all(),
        categorias=Categoria.get_all(),
        subcategorias=Subcategoria.get_all(),
    )

@app.route('/crear_bodega', methods=["POST"])
def crear_bodega():
    print("DATOS:", request.form)
    data = {
        'nombre': request.form['nombre']
    }
    id = Bodega.save(data)

    flash(f"la bodega fue agregada exitosamente con el ID {id}", "success")
    return redirect("/ejemplo")


@app.route('/eliminar_bodega/<id>')
def eliminar_bodega(id):
    print("Bodega a eliminar", id)
    bodega_a_eliminar = Bodega.get(id)

    if bodega_a_eliminar:
        bodega_a_eliminar.delete()
        flash(f"la bodega con el ID {id} fue eliminada exitosamente", "success")
    else:
        flash(f"la bodega con el ID {id} no fue encontrada", "error")

    return redirect("/ejemplo")

@app.route('/editar_bodega/<id>')
def editar_bodega(id):
    print("Bodega a editar", id)
    bodega = Bodega.get(id)

    return render_template(
        "editar_bodega.html",
        bodega= bodega
    )

@app.route('/procesar_editar_bodega/<id>', methods=["POST"])
def procesar_editar_bodega(id):
    print("DATOS:", request.form)

    bodega = Bodega.get(id)
    bodega.nombre = request.form['nombre']
    bodega.update()

    flash(f"la bodega con el ID {id} fue editada exitosamente", "success")
    return redirect("/ejemplo")

@app.route('/crear_categoria', methods=["POST"])
def crear_categoria():
    print("DATOS:", request.form)
    data = {
        'nombre': request.form['nombre']
    }
    id = Categoria.save(data)

    flash(f"la categoria fue agregada exitosamente con el ID {id}", "success")
    return redirect("/ejemplo")

@app.route('/crear_subcategoria', methods=["POST"])
def crear_subcategoria():
    print("DATOS:", request.form)

    id = Subcategoria.save(request.form)

    flash(f"la subcategoria fue agregada exitosamente con el ID {id}", "success")
    return redirect("/ejemplo")


if __name__=="__main__":
    app.run(debug=True)

