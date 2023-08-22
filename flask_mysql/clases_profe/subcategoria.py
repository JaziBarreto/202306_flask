from hola_flask.config.mysqlconnections import connectToMySQL
from categoria import Categoria

class Subcategoria:
    def __init__(self, data) -> None:
        self.id = data['id']
        self.nombre = data['nombre']
        self.categoria = None

    def __str__(self) -> str:
        return f"Instancia de Subcategoria {self.nombre} con ID {self.id}"

    @classmethod
    def get_all(cls):
        resultados_instancias = []
        query = "SELECT * FROM subcategorias JOIN categorias ON subcategorias.categoria_id = categorias.id"
        resultados = connectToMySQL('base_datos_productos').query_db(query)
        for resultado in resultados:
            
            instancia = cls(resultado)
            datos_categoria = {
                'id': resultado['categorias.id'],
                'nombre': resultado['categorias.nombre'],
            }
            instancia_categoria = Categoria(datos_categoria)
            instancia.categoria = instancia_categoria

            resultados_instancias.append(instancia)

        return resultados_instancias

    @classmethod
    def save(cls, data ):
        query = "INSERT INTO subcategorias (nombre, categoria_id) VALUES (%(nombre)s, %(categoria_id)s);"
        return connectToMySQL('base_datos_productos').query_db( query, data )