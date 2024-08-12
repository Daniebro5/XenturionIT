import UIKit

print("=== *** PROTOCOLOS *** ===")
// son como algo asi como un contrato, nos deja definir que funcionalidad ESPERAMOS que un tipo de dato soporte, haciendo que el compilador nos asegure que el codigo siga estas reglas

// definimos un protocolo con la palabra reservada protocol, seguido de su nombre
// especifica el minimo de requerimiento
protocol Vehiculo {
    // get significa constante, o una variable computada
    var name: String { get }
    // significa que será una variable
    var numeroDePasajeros: Int { get set }
    func estimarTiempoDeLlegada(for distance: Int) -> Int
    func travel(distancia: Int)
}

// se puede conformar a tantos protocolos como queramos, solo listandolos despues del tipo
struct Car: Vehiculo {
    let name: String = "Carro"

    var numeroDePasajeros = 5

    func estimarTiempoDeLlegada(for distance: Int) -> Int {
        distance / 50
    }
    
    func travel(distancia: Int) {
        print("estoy conduciendo \(distancia) km")
    }

    func abrirLasVentanas() {
        print("Hace mucho calor")
    }
}

struct Bicicleta: Vehiculo {
    var name: String {
        return "Bicicleta"
    }

    var numeroDePasajeros = 1

    func estimarTiempoDeLlegada(for distance: Int) -> Int {
        distance / 10
    }
    
    func travel(distancia: Int) {
        print("Estoy cicleando \(distancia)km")
    }
}

func viajar(distance: Int, using vehicule: Vehiculo) {
    if vehicule.estimarTiempoDeLlegada(for: distance) > 100 {
        print("Es demasiado lento, intentaré con otro medio")
    } else {
        vehicule.travel(distancia: distance)
    }
}

func obtenerEstimados(usando vehiculos: [Vehiculo], distancia: Int) {
    for vehiculo in vehiculos {
        let estimado = vehiculo.estimarTiempoDeLlegada(for: distancia)
        print("\(vehiculo.name): \(estimado) horas para viajar \(distancia)km")
    }
}

let car = Car()
let bike = Bicicleta()

viajar(distance: 50, using: car)
viajar(distance: 50, using: bike)

obtenerEstimados(usando: [car, bike], distancia: 150)
