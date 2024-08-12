import SwiftUI

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


print("=== *** OPAQUE RETURN TYPES *** ===")

func getRandomNumber() -> some Equatable {
    Int.random(in: 1 ... 6)
}

func getRandomBool() -> some Equatable {
    Bool.random()
}

// ambos Bool e Int se conforman a EQUATABLE (protocolo que nos deja saber si pueden ser comparados dos tipos iguales para saber si son los mismos),
struct Danni: Equatable {
    static func == (lhs: Danni, rhs: Danni) -> Bool {
        lhs.id == rhs.id
    }
    
    var id = "1715748693"
    var name = "Danni"
    var apellido = "Brito"
}

let a = Danni()
var b = Danni()
b.name = "André"

if a == b {
    print("El mismo Danni André")
}

getRandomNumber() == getRandomNumber()

getRandomBool() == getRandomBool()

// ejemplo de swiftUI
// hay una pantalla con un toolbar arriba, un tabBar abajo, en el medio hay una grilla de iconos, cada uno tiene un label diciendo que icono es escrito en negrilla y cuando tocas una imagen, un mensaje aparece en pantalla
// -> some View
