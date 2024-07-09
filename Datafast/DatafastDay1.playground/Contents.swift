import Foundation

// MARK: funciones

func suma(a: Int, b: Int) -> Int {
    return a + b
}

// String interpolation es inyectar valores en una cadena \(valor)
print("La suma de 3 y 5 es \( suma(a: 3, b: 5) )")

// MARK: tipos de datos compuestos
// tupla, varios datos en una sola variable (a,b,c,.....)

let productoCelular = (nombre: "S23 Ultra Plus Pro Max", precio: 1099.99, anio: 2023)
print(productoCelular.nombre)

// diccionario, asociaciones de clave-valor
var precios: [String: String] = [
    "coca-cola": "0.50",
    "camara sony": "1200",
    "teclado": "5"
]
let precioCocaCola: String = precios["coca-cola"] ?? "no existe"
print("La cocacola cuesta: \(precioCocaCola)")

let precioPepsi: String = precios["pepsi"] ?? "no existe"
print("La pepsi cuesta: \(precioPepsi)")

// Opcionales
let regaloEnteroDesenvuelto: Int = 10

// caja envuelta
let regaloEnteroEnvuelto: Int? = 10

// safe unwrap - desenvoltura segura
if let regaloDesenvuelto = regaloEnteroEnvuelto {
    print(regaloDesenvuelto)
} else {
    // mostrar el error
    print("el regalo estaba vacio")
}

// valor por defecto
print(regaloEnteroEnvuelto ?? 666)

// force unwrap - desenvoltura forzada
// EVITAR los force unwrap
print(regaloEnteroEnvuelto!)

// nil coalesing
class Persona {
    func dameUnNumero() -> Int? {
        return 42
    }

    func dameUnPerro() -> Perro? {
        return Perro()
    }
}

struct Perro {
    func ladrar() -> String? {
        return "ladrando"
    }
}

let hugo = Persona()
hugo.dameUnNumero()
hugo.dameUnPerro()?.ladrar() // si no existe akguna de sus partes todo retorna nil

if let perro = hugo.dameUnPerro() {
    perro.ladrar()
} else {
    print("no existe perro")
}


// MARK: Estructuras de control

let someCharacter: Character = "æ"

// permite el manejo de rangos
switch someCharacter {
case "a", "e", "i", "o", "u":
    print("\(someCharacter) es una vocal.")
case "b", "c", "d", "f":
    print("\(someCharacter) es una consonante.")
default:
    print("\(someCharacter) no es ni vocal ni consonante.")
}

enum Sexo {
    case masculino
    case femenino
    case noBinario
    case otro
}

let miSexo: Sexo = .otro

switch miSexo {
case .masculino, .femenino:
    print("Soy binario")
case .noBinario:
    print("Soy no binario")
case .otro:
    print("Soy otro")
}

let habitantesGuayaquil = 500_000
switch habitantesGuayaquil {
case 0:
    print("No hay habitantes")
case 1 ..< 100_000:
    print("Es una ciudad pequeña")
case 100_000 ..< 500_000:
    print("es una ciudad mediana")
default:
    print("es una metrópoli")
}


// MARK: manejo de errores
enum ImpresoraError: Error {
    case noHayPapel
    case noHayTinta
    case enLlamas
}

// la funcion imprimir puede retornar algun error
func imprimir(pagina: Int) throws {
    // guard para chequear que las entradas cumplan ciertos criterios
    guard pagina > 0 else {
        throw ImpresoraError.enLlamas
    }
    print( "Pagina impresa")
}

func imprimir2(pagina: Int) throws {
    // guard para chequear que las entradas cumplan ciertos criterios
    guard pagina > 0 else {
        throw ImpresoraError.enLlamas
    }
    print( "Pagina impresa")
}

do {
    try imprimir(pagina: 86)
    try imprimir2(pagina: 86)
} catch ImpresoraError.enLlamas {
    print("se quema la ofi")
} catch {
    print("ocurrio un error", error)
}

try? imprimir(pagina: 0)


let regaloEnvuelto: Int? = nil

if let regaloDesenvuelto = regaloEnvuelto {
    print(regaloDesenvuelto)
} else {
    print("lampara oe ctm no habia nada en el regalo")
}

func hola(saludar: Int?) {
    guard let numeroDeSaludos = saludar else {
        print("saludando 1 sola vez")
        return
    }
    print("saludando \(numeroDeSaludos)")
}

hola(saludar: nil)

//

var estoyFeliz: Bool = false
print(estoyFeliz)
estoyFeliz.toggle()
print(estoyFeliz)

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
    func añadir(tarea: Tarea) {
        // [a,b] append(c) [a,b,c]
        listaDeTareas.append(tarea)
    }

    func eliminar(indice: Int) {
        // el indice en Swift empieza en 0
        listaDeTareas.remove(at: indice)
    }

    func editar(indice: Int, nuevaTarea: Tarea) {
        listaDeTareas[indice] = nuevaTarea
    }

    func listarTodas() {
        print("********")
        listaDeTareas.forEach { tarea in
            print(tarea.titulo, tarea.descripcion, tarea.estaCompletada, "\n")
        }
    }

    func completarTarea(indice: Int) {
        var tarea = listaDeTareas.remove(at: indice)
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
gestor.eliminar(indice: 1)
gestor.listarTodas()

gestor.completarTarea(indice: 0)
gestor.listarTodas()
