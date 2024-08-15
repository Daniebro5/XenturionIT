import UIKit

print("*** === PATRONES DE DISEÑO ESTRUCTURALES === ***")
// estos patrones se enfocan en como organizar y estructurar clases y objetos en general para formar sistemas mas complejos

print("=== ADAPTER ===")
// actua como un traductor que permite que dos clases con interfaces incompatibles, trabajen juntas
// como un cargador que funciona en ECU pero necesita un ADAPTADOR para funcionar en otro pais

protocol EnchufeEuropeo {
    func cargarMiCelEnEuropa()
}

final class CargadorEuropeo: EnchufeEuropeo {
    func cargarMiCelEnEuropa() {
        print("Estoy cargando este celular en europa, conectado a un enchufe europeo")
    }
}

protocol EnchufeAmericano {
    func cargarMiCelEnEcu()
}

final class AdaptadorAmericanoAEuropeo: EnchufeAmericano {
    private var enchufeEuropeo: EnchufeEuropeo

    init(enchufeEuropeo: EnchufeEuropeo) {
        self.enchufeEuropeo = enchufeEuropeo
    }

    func cargarMiCelEnEcu() {
        enchufeEuropeo.cargarMiCelEnEuropa()
        print("Adaptador: cargando el cel en europa")
    }
}

let cargadorEuropeo = CargadorEuropeo()
let adaptador = AdaptadorAmericanoAEuropeo(enchufeEuropeo: cargadorEuropeo)
adaptador.cargarMiCelEnEcu()

/* cuando usarlo?
lo usamos para conectar dos clases incompatibles entre si

 casos comunes de uso: al utilizar librerías externas (especialmente de APIs) estas generalmente no coinciden con la estructura de nuestro codigo, por lo q utilizaremos un adapter, incluso al manejar diferentes lenguajes de programacion

 tips:
 1. utilizar cuando no puedas (librerias externas) o no quieras (codigo legacy) modificar codigo existente
 2. cuando necesitas usar una clase q fue diseñada para un contexto diferente y no quieres duplicar codigo
*/

print("=== COMPOSITE ===")
// construccion de objetos complejos a partir de objetos simples, organizando sus partes en una estructura de arbol los cuales son tratados de manera uniforme
// un arbol puede surgir de la raiz o podemos ver a cualquier rama como un subarbol
// un restaurante puede contener platos individuales, o combos que son una combinacion de platos individuales, o familiares que son combinacion de combos

protocol MenuItem {
    func mostrarDetalles()
}

final class PlatoIndividual: MenuItem {
    private var nombre: String

    init(nombre: String) {
        self.nombre = nombre
    }

    func mostrarDetalles() {
        print("Plato: \(nombre)")
    }
}

final class Combo: MenuItem {
    private var nombre: String
    private var items: [MenuItem] = []

    init(nombre: String) {
        self.nombre = nombre
    }

    func agregarItem(item: MenuItem) {
        items.append(item)
    }

    func mostrarDetalles() {
        print("Combo: \(nombre)")
        for item in items {
            item.mostrarDetalles()
        }
    }
}

let anvorguesa = PlatoIndividual(nombre: "anvorguesa")
let papas = PlatoIndividual(nombre: "papitas")
let bebida = PlatoIndividual(nombre: "coca helada")

let comboFamiliar = Combo(nombre: "Combo Familiar")
comboFamiliar.agregarItem(item: anvorguesa)
comboFamiliar.agregarItem(item: papas)
comboFamiliar.agregarItem(item: bebida)
comboFamiliar.mostrarDetalles()

/* cuando usarlo?
aplicamos composite cuando identificados una estructura de datos jerarquica donde los componentes individuales y agrupados se tratan de igual manera

 casos comunes de uso: SwiftUI cada una de las subvistas puede ser tratada como unica o agruparse en vistas grandes que tambien son tratadas como unicas

 tips:
 1. si identificamos alguna estructura jerarquica es un buen lugar para composite (como las interfaces de usuario)
 2. si necesitamos facilitar las iteraciones recursivas
 3. si mi jerarquia no es tan profunda (no tiene tantos niveles) posiblemente sea un overkill
*/

print("=== DECORATOR ===")
// añadir nueva funcionalidad de forma dinamica sin alterar la estructura base
// un arbol de navidad tiene su estructura base, y puede ser decorado con luces, esferas, guirnaldas, musgos, nieve, etc... o ninguno, estas "funcionalidades" extra puede ser agregadas o quitadas dinamicamente

protocol ArbolDeNavidad {
    func decorar() -> String
}

// definimos mi estado base
final class ArbolDeNavidadSimple: ArbolDeNavidad {
    func decorar() -> String {
        return "Arbol de navidad"
    }
}

class Decoracion: ArbolDeNavidad {
    private let arbol: ArbolDeNavidad

    init(arbol: ArbolDeNavidad) {
        self.arbol = arbol
    }

    func decorar() -> String {
        arbol.decorar()
    }
}

// utilizamos herencia
final class Luces: Decoracion {
    override func decorar() -> String {
        return super.decorar() + " con luces"
    }
}

final class Bombillos: Decoracion {
    override func decorar() -> String {
        return super.decorar() + " con bombillos"
    }
}

var arbol: ArbolDeNavidad = ArbolDeNavidadSimple()
// añado funcionalidad
arbol = Luces(arbol: arbol)
arbol = Bombillos(arbol: arbol)

print(arbol.decorar())

/* cuando usarlo?
cuando queremos añadir responsabilidades extra a un objeto sin alterar su estructura base

 casos comunes de uso: agregar Roles a los usuarios, añadir analytics o manejo de sesion a la capa de networking

 tips:
 1. usar decorador cuando identificamos pequeñas y muchas piezas de funcionalidad extra en las clases
 2. asegurarnos de no cambiar el comportamiento base (unit test)
 3. con composite podemos decorar jerarquias enteras de objetos
*/
