from hola_flask.config.mysqlconnections import connectToMySQL
from flask import Flask, render_template, request, redirect, session, flash

class Base:
    modelo = ""

    @classmethod
    def get_all(cls):
        resultados_instancias = []
        query = "SELECT * FROM " + cls.modelo
        resultados = connectToMySQL('base_datos_productos').query_db(query)

        if resultados:
            for resultado in resultados:
                instancia = cls(resultado)
                resultados_instancias.append(instancia)

        return resultados_instancias  # Devuelve la lista incluso si está vacía

class Bodega(Base):

    modelo = "bodegas"

    def __init__(self, data):
        self.id = data['id']
        self.nombre = data['nombre']

    def __str__(self):
        return f"Instancia de BODEGA {self.nombre} con ID {self.id}"
    
    @classmethod #metodo de clase para guardar en la base de datos
    def save(cls, data ):
        query = "INSERT INTO bodegas (nombre) VALUES (%(nombre)s);" #just nombre porque el id es autoincrementable
        # data es un diccionario que se pasará al método de guardar desde server.py
        return connectToMySQL('base_datos_productos').query_db( query, data ) #esto retornara el id de mi bodega
    
    #debo obtener el dato para poder eliminarlo. Se lo entiende como una instancia
    @classmethod
    def get(cls, id):
        query = "SELECT * FROM bodegas WHERE id = %(id)s;"
        data= { 'id': id}
        resultados= connectToMySQL('base_datos_productos').query_db( query, data) #como yo solo necesito un dato y no el conjunto
        if resultados: #si existe resultados
            return cls(resultados[0]) #devolver el primer resultado y si no encuentra nada devolver none
        return None

    def delete(self):
        query = "DELETE FROM bodegas WHERE id = %(id)s;"
        data= { 'id': self.id}
        connectToMySQL('base_datos_productos').query_db( query, data) #no se crea una variable porque el delete o insert no devuelve nada, solo se ejecuta
        return True #si fue exitoso


    def update(self):
        query = "UPDATE bodegas SET nombre = %(nombre)s WHERE id = %(id)s;"
        data = { 
            'id': self.id,
            'nombre': self.nombre
        }
        connectToMySQL('base_datos_productos').query_db(query, data)
        return True