import Foundation

// Definición de la estructura Tarea.
struct Tarea {
    var titulo: String
    var descripcion: String
    var estaCompletada: Bool
}

// Definición del protocolo Gestor.
protocol Gestor {
    func añadir(tarea: Tarea)
    func eliminar(indice: Int)
    func editar(indice: Int, nuevaTarea: Tarea)
    func listarTodas()
    func completarTarea(indice: Int)
}

// Implementación final de la clase GestorDeTareas que conforma al protocolo Gestor.
final class GestorDeTareas: Gestor {
    // Lista para almacenar las tareas.
    var tareas = [Tarea]()

    // Método para añadir una tarea a la lista.
    func añadir(tarea: Tarea) {
        tareas.append(tarea)
    }

    // Método para eliminar una tarea por índice.
    func eliminar(indice: Int) {
        guard indice < tareas.count else {
            print("Índice fuera de rango.")
            return
        }
        tareas.remove(at: indice)
    }

    // Método para editar una tarea existente.
    func editar(indice: Int, nuevaTarea: Tarea) {
        guard indice < tareas.count else {
            print("Índice fuera de rango.")
            return
        }
        tareas[indice] = nuevaTarea
    }

    // Método para listar todas las tareas y mostrar su estado.
    func listarTodas() {
        for tarea in tareas {
            print("Título: \(tarea.titulo), Descripción: \(tarea.descripcion), Completada: \(tarea.estaCompletada)")
        }
    }

    // Método para marcar una tarea como completada.
    func completarTarea(indice: Int) {
        guard indice < tareas.count else {
            print("Índice fuera de rango.")
            return
        }
        var tarea = tareas[indice]
        tarea.estaCompletada = true
        tareas[indice] = tarea
    }
}

// Ejemplo de uso de GestorDeTareas.
let gestor = GestorDeTareas()

// Añadir tareas.
gestor.añadir(tarea: Tarea(titulo: "Organizar fiesta sorpresa para Andrea",
                           descripcion: "Comprar globos, pastel de helado de menta con chocolate sin que se entere.",
                           estaCompletada: false))
gestor.añadir(tarea: Tarea(titulo: "Preparar disfraz para Hugo",
                           descripcion: "Hugo necesita un disfraz de Iron Man para la fiesta de disfraces de Datafast.",
                           estaCompletada: false))

// Listar todas las tareas.
gestor.listarTodas()
