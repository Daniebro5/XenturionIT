import UIKit

print("=== *** PROTOCOLOS *** ===")
// son como algo asi como un contrato, nos deja definir que funcionalidad ESPERAMOS que un tipo de dato soporte, haciendo que el compilador nos asegure que el codigo siga estas reglas

// definimos un protocolo con la palabra reservada protocol, seguido de su nombre
// especifica el minimo de requerimiento
protocol Vehiculo {
    func estimarTiempoDeLlegada(for distance: Int) -> Int
    func travel(distancia: Int)
}

struct Car: Vehiculo {
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

let car = Car()
let bike = Bicicleta()

viajar(distance: 50, using: car)
viajar(distance: 50, using: bike)
