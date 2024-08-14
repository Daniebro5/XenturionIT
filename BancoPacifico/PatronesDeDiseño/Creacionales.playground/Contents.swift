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


