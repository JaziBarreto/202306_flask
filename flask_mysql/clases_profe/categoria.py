from hola_flask.config.mysqlconnections import connectToMySQL

class Categoria:
    def __init__(self, data) -> None:
        self.id = data['id']
        self.nombre = data['nombre']

    def __str__(self) -> str:
        return f"Instancia de Categoria {self.nombre} con ID {self.id}"

    @classmethod
    def get_all(cls):
        resultados_instancias = []
        query = "SELECT * FROM categorias"
        resultados = connectToMySQL('base_datos_productos').query_db(query)
        for resultado in resultados:
            instancia = cls(resultado)
            resultados_instancias.append(instancia)

        return resultados_instancias

    @classmethod
    def save(cls, data ):
        query = "INSERT INTO categorias (nombre) VALUES (%(nombre)s);"
        return connectToMySQL('base_datos_productos').query_db( query, data )