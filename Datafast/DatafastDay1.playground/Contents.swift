import Foundation

// MARK: - Funciones

// Función simple para sumar dos enteros.
func suma(a: Int, b: Int) -> Int {
    return a + b
}

// Uso de interpolación de cadenas para mostrar el resultado de la suma.
print("La suma de 3 y 5 es \(suma(a: 3, b: 5))")

// MARK: - Tipos de Datos Compuestos

// Uso de tuplas para almacenar múltiples valores en una variable.
let detalleCelular = (nombre: "S23 Ultra Plus Pro Max", precio: 1099.99, año: 2023)
print("El modelo \(detalleCelular.nombre) del año \(detalleCelular.año) cuesta \(detalleCelular.precio) dólares.")

// Diccionario para asociar nombres de productos con sus precios.
var precios: [String: String] = [
    "coca-cola": "0.50",
    "camara sony": "1200",
    "teclado": "5"
]

// Uso de opcional para manejar valores que podrían no existir.
let precioCocaCola: String = precios["coca-cola"] ?? "no disponible"
print("La Coca-Cola cuesta: \(precioCocaCola)")

let precioPepsi: String = precios["pepsi"] ?? "no disponible"
print("La Pepsi cuesta: \(precioPepsi)")

// MARK: - Opcionales

// Ejemplo de cómo desempaquetar un opcional de manera segura con if let.
if let regaloDesenvuelto = precios["regalo"] {
    print("El regalo cuesta: \(regaloDesenvuelto)")
} else {
    print("El regalo no tiene precio asignado.")
}

// Ejemplo de coalescencia de nil para proporcionar un valor por defecto.
print("El precio del regalo es: \(precios["regalo"] ?? "0")")

// MARK: - Clases y Estructuras

// Clase Persona con métodos que pueden retornar valores opcionales.
class Persona {
    func obtenerUnNúmero() -> Int? {
        return 42
    }

    func obtenerUnPerro() -> Perro? {
        return Perro()
    }
}

struct Perro {
    func ladrar() -> String {
        return "ladrando"
    }
}

// Creación de una instancia de Persona y uso de métodos opcionales.
let hugo = Persona()
if let número = hugo.obtenerUnNúmero() {
    print("Hugo tiene el número \(número).")
}
if let perro = hugo.obtenerUnPerro() {
    print("El perro está \(perro.ladrar()).")
} else {
    print("Hugo no tiene perro.")
}

// MARK: - Estructuras de Control

// Ejemplo de switch para manejar múltiples casos con rangos.
let poblaciónGuayaquil = 500_000
switch poblaciónGuayaquil {
case 0:
    print("No hay habitantes.")
case 1..<100_000:
    print("Es una ciudad pequeña.")
case 100_000..<500_000:
    print("Es una ciudad mediana.")
default:
    print("Es una metrópoli.")
}

// MARK: - Manejo de Errores

enum ImpresoraError: Error {
    case sinPapel
    case sinTinta
    case enLlamas
}

// Función que puede lanzar un error al imprimir.
func imprimir(página: Int) throws {
    guard página > 0 else {
        throw ImpresoraError.enLlamas
    }
    print("Página impresa")
}

// Uso de do-catch para manejar errores.
do {
    try imprimir(página: 86)
} catch ImpresoraError.enLlamas {
    print("La impresora está en llamas.")
} catch {
    print("Ocurrió un error: \(error)")
}

// Ejemplo de gestión opcional y error con guard let.
func saludar(conNúmeroDe veces: Int?) {
    guard let veces = veces else {
        print("Saludar una vez.")
        return
    }
    print("Saludar \(veces) veces.")
}

saludar(conNúmeroDe: nil)

// MARK: - Protocolos y Delegación

// MARK: - Definición de la Estructura Tarea

// La estructura 'Tarea' representa una tarea individual con un título, descripción y un estado de completitud.
struct Tarea {
    var título: String
    var descripción: String
    var estaCompletada: Bool
}

// MARK: - Protocolo GestorDeTareas

// El protocolo 'GestorDeTareas' define los métodos que debe implementar cualquier gestor de tareas.
protocol GestorDeTareas {
    func añadir(tarea: Tarea)
    func eliminar(indice: Int)
    func editar(indice: Int, nuevaTarea: Tarea)
    func listarTodas()
}

// MARK: - Implementación del Gestor de Tareas

// 'GestorDeTareasImpl' es una clase que implementa el protocolo 'GestorDeTareas'.
// Gestiona una colección de tareas permitiendo añadir, eliminar, editar y listar tareas.
final class GestorDeTareasImpl: GestorDeTareas {
    private var tareas = [Tarea]()

    func añadir(tarea: Tarea) {
        tareas.append(tarea)
        print("Tarea añadida: \(tarea.título)")
    }

    func eliminar(indice: Int) {
        if indice < tareas.count {
            tareas.remove(at: indice)
            print("Tarea eliminada.")
        } else {
            print("Índice fuera de rango.")
        }
    }

    func editar(indice: Int, nuevaTarea: Tarea) {
        if indice < tareas.count {
            tareas[indice] = nuevaTarea
            print("Tarea editada: \(nuevaTarea.título)")
        } else {
            print("Índice fuera de rango.")
        }
    }

    func listarTodas() {
        print("Listando todas las tareas:")
        tareas.forEach { tarea in
            print("\(tarea.título): \(tarea.descripción) - Completada: \(tarea.estaCompletada)")
        }
    }
}

// Ejemplo de uso
let gestor = GestorDeTareasImpl()
gestor.añadir(tarea: Tarea(título: "Comprar Ingredientes", descripción: "Comprar ingredientes para la cena de mañana.", estaCompletada: false))
gestor.listarTodas()
