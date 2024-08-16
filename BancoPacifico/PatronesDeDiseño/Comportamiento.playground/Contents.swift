import UIKit

print("=== *** Patrones de Comportamiento *** ===")
// patrones definen como se comportan las clases entre si, y como actualizan su comunicacion
// las leyes de transito que definen como se comportan los automoviles, peatones, bicicletas, etc y como se comunican entre ellos en un sistema

print("=== Observer ===")
// define una relacion uno a muchos entre objetos, donde el cambio de estado de un objeto (Publicador) es notificado a los demas objetos (Observadores)
// seguir a alguien en instagram, van a notificar todos los seguidores cuando una persona publique una foto
// implementado por defecto en Swift mediante SwiftUI y Combine

protocol Observador {
    func actualizar(estado: String)
}

final class Publicador {
    private var observadores: [Observador] = []
    var estado: String = "" {
        didSet {
            notificarObservadores()
        }
    }

    func agregarObservador(_ observador: Observador) {
        observadores.append(observador)
    }

    func eliminarObservador(_ observador: Observador) {
        // conditional optional cast, nos devuelve nil, si no se pudo hacer
        if let observadorConcreto = observador as? ObservadorConcreto {
            observadores = observadores.filter {
                // *** EVITAR
                // observadorConcreto.nombre != ($0 as! ObservadorConcreto).nombre
                guard let observador = $0 as? ObservadorConcreto else { return true }
                return observadorConcreto.nombre != observador.nombre

            }
        }
    }

    private func notificarObservadores() {
        for observador in observadores {
            observador.actualizar(estado: estado)
        }
    }
}

final class ObservadorConcreto: Observador {
    let nombre: String

    init(nombre: String) {
        self.nombre = nombre
    }

    func actualizar(estado: String) {
        print("\(nombre), recibió la actualización \(estado)")
    }
}

let publicador = Publicador()

let sujeto = ObservadorConcreto(nombre: "Danni")
let sujeto2 = ObservadorConcreto(nombre: "Jessica")

publicador.agregarObservador(sujeto)
publicador.agregarObservador(sujeto2)

publicador.estado = "Subio nueva foto en instagram"

/*
        Cuando Usarlo?
 cuando una notificacion de un objeto requiere una "reaccion" en otros objetos
        Casos Comunes
 Actualizacion de UI, notificaciones o sistemas de suscripciones

        TIPS
 el objeto central es el unico que "habla"
 cuidado con las referencias ciclicas y el drenado de memoria
 */
