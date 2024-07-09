import Foundation

struct Tarea {
    var titulo: String
    var descripcion: String
    var estaCompletada: Bool
}

// Array
// var listaDeTareas: [Tarea] = []
var listaDeTareas = [Tarea]()

protocol Gestor {
    func añadir(tarea: Tarea)
    func eliminar(indice: Int)
    func editar(indice: Int, nuevaTarea: Tarea)
    func listarTodas()
    func completarTarea(indice: Int)
}

final class GestorDeTareas: Gestor {
    let tareas = [Tarea]()

    func añadir(tarea: Tarea) {
        // [a,b] append(c) [a,b,c]
        tareas.append(tarea)
    }

    func eliminar(indice: Int) {
        // el indice en Swift empieza en 0
        tareas.remove(at: indice)
    }

    func editar(indice: Int, nuevaTarea: Tarea) {
        listaDeTareas[indice] = nuevaTarea
    }

    func listarTodas() {
        tareas.forEach { tarea in
            print(tarea.descripcion, tarea.estaCompletada, "\n")
        }
    }

    func completarTarea(indice: Int) {
        let tarea = listaDeTareas.remove(at: indice)
        tarea.estaCompletada = true
        listaDeTareas.insert(tarea, at: indice)
    }
}

let gestor = GestorDeTareas()

gestor.añadir(tarea: Tarea(titulo: "Luiggi organizar fiesta sorpresa para Andrea",
                           descripcion: "comprar globos, pastel de helado de menta con chocolate sin que se entere",
                           estaCompletada: false))
gestor.añadir(tarea: Tarea(titulo: "Hugo preparar su disfraz",
                           descripcion: "hugo necesita un difraz de ironman para la fiesta de disfraces de Datafast",
                           estaCompletada: false))

gestor.listarTodas()
