import Foundation

print("=== SINGLETON ===")
// garantiza que exista una sola instancia en el ciclo de vida de la aplicacion
// como un presidente, siempre solo va a existir uno, no importa cuantas veces tratemos de crearlo, siempre hará referencia al mismo

final class Presidente {
    
    static let shared = Presidente()
    var montoDelRobo = 0

    // El constructor privado nos asegura q no vamos a crear mas presidentes
    private init() { }

    func robar() {
        print("Estoy haciendo la revolucion")
        montoDelRobo += 1_000_000
    }

    func ponerEnCero() {
        montoDelRobo = 0
    }
}

print(Presidente.shared.montoDelRobo)
let mashiCorrea = Presidente.shared
mashiCorrea.robar()
print(mashiCorrea.montoDelRobo)

let lasso = Presidente.shared

lasso.robar()
// tener cuidado con el problema, KeepState, mantener estados
print(lasso.montoDelRobo)

Presidente.shared.ponerEnCero()
print(lasso.montoDelRobo)

// cuando usarlo?
// cuando queremos asegurar una sola instancia por siempre

// casos de uso comunes
// capa de configuraciones (XCConfigs), gestores de acceso a BDD, Networking, Logging (autenticacion)

// TIPS:
// 1. aseguremonos que el init sea privado para evitar creacion de nuevas instancias
// 2. considerar problemas de sincronizacion (race conditions) xq multiples lugares puede estar accediendo a la misma instancia a la vez
// 3. no lo sobreutilicemos prefiramos inyeccion de dependencias

print("\n\n\n=== FACTORY METHOD ===")
// define la interfaz de creacion de objetos pero permite a las subclases que tipo instanciar
// una panaderia dependiendo de lo que pidamos nos dará un tipo diferente de pan, el user no necesita saber como se hacen solo pide y recibe

protocol Pan {
    func hornear()
}

// CGROSON
final class Croissant: Pan {
    func hornear() {
        print("horneando un CGROSON")
    }
}

final class Palanqueta: Pan {
    func hornear() {
        print("horneando palanqueta")
    }
}

final class Panaderia {
    func despacharPan(tipo: String) -> Pan? {
        switch tipo {
        case "CGROSON":
            return Croissant()
        case "Palanqueta":
            return Palanqueta()
        default:
            print("Ese pan no existe pelado, habla serio")
            return nil
        }
    }
}

let panaderia = Panaderia()
// delego a la panaderia la creacion del pan segun convenga, no creo el pan directamente
let pedido = panaderia.despacharPan(tipo: "CGROSON")
pedido?.hornear()

// cuando usarlo?
// cuando necesitamos delegar la creacion de clases a las subclases, cuando hay muchas subclases de un mismo tipo

// casos de uso comunes
// creacion de objetos que son determinados en tiempo de ejecucion, como por ejemplo los boxes del KFC

// TIPS:
// 1. es util cuando no podemos anticipar que clases o subclases vamos a crear
// 2. combinar esto con singleton cuando queremos controlar el numero de instancias (ejemplo: Al aplicar un cupon en una tienda)
// 3. facilitamos la expansion del sistema, por lo cual sirve cuando existen muchiiiiiiiiiisimas subclases de un mismo objeto
