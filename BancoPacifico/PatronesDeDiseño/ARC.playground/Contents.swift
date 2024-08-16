import UIKit

print("=== *** Automatic Reference Counting *** ===")
// es el sistema de gestion de memoria que siwft usa para optimizar la memoria en uso
// lo hace mediante el conteo de cuantas referencias activas existen

// REFERENCIAS FUERTES (STRONG)
// cada vez que un objeto haga referencia a otro objeto el ARC aumenta en 1 y el objeto referenciado entra en memoria

// LIBERACION DE MEMORIA
// cuando una referencia fuerte se elimina (se vuelve nil) ARC disminuye el contador en 1, y cuando llega a 0 el objeto es destruido (deasignado) de memoria

final class Persona {
    var nombre: String

    init(nombre: String) {
        self.nombre = nombre
        print("\(nombre) ha sido creado")
    }

    // esta funcion se ejecuta antes de la eliminacion del objeto
    deinit {
        print("\(nombre) ha sido liberado de memoria")
    }
}

// ARC = 0

// referencia strong
var persona1: Persona? = Persona(nombre: "Danni")

// ARC = 1

// referencia strong
var persona2: Persona? = Persona(nombre: "Amparito")

// ARC = 2

// referencia strong
var persona3: Persona? = Persona(nombre: "André")

// ARC = 3

persona1 = nil

// ARC = 2

// la referencia weak no aumenta el ARC pero me devuelve un opcional
weak var persona4 = Persona(nombre: "Danni Debil")

// ARC = 2

// la referencia unowned no aumenta el ARC y me devuelve un objeto no nil
// sirve cuando estoy completamente seguro que el objeto esta en memoria
unowned var persona5 = Persona(nombre: "Danni Debil")

// ARC = 2
