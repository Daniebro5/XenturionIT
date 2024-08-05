import UIKit

var greeting = "Hello, playground"

// swift es un lenguaje altamente tipado

// todo en swift se corresponde a un tipo

var cadena: String = "cadena"
var numero: Int = 35
var decimal: Double = 876.7823
var bandera: Bool = false
// ...

// opcional (?)

// es una cajita que no se si tiene o no tiene un valor
var banderaDeServidor: Bool? = nil

// llamando al servidor pero la conexion fallo
print(banderaDeServidor)

// llamado al servidor y me responde true
banderaDeServidor = true


print(banderaDeServidor)


// unwrappping o desempaquetado

// manera segura (hacerlo así siempre)
// si existe bandera de servidor
if let banderaDeServidor {
    print("La bandera existe y es: \(banderaDeServidor)")
} else {
    print("La bandera no existe, el regalo esta vacio")
}

// manera insegura (evitarlo a toda costa, se usa principalmente en pruebas)
print(banderaDeServidor!)

// desempaquetado seguro
if let fileURL = Bundle.main.url(forResource: "Algun-archivo", withExtension: "txt") {
    // hemos encontrado este archivo
    print("Encontrado")
} else {
    // no se ha encontrado el archivo
    print("No Encontrado")
}

// a los opcionales le puedo dar un valor por defecto
let banderaLocal = banderaDeServidor ?? false


// ****** CADENAS-STRINGS

let input = "a b c"
let letras = input.components(separatedBy: " ")

//  salto de linea - \n

let inputMultilinea = """
a
b
c
"""

let letters = input.components(separatedBy: "\n")
let letra = letters.randomElement()

// trimming - recortar
// cortar ciertos caracteres al inicio y final de la cadena
let recortado = letra?.trimmingCharacters(in: .whitespacesAndNewlines)

// chequear si algo está bien escrito
let palabra = "swift"
let checker = UITextChecker()

let range = NSRange(location: 0, length: palabra.utf16.count)

let mispelledRange = checker.rangeOfMisspelledWord(in: palabra, range: range, startingAt: 0, wrap: false, language: "en")

let bienEscrita = mispelledRange.location == NSNotFound


// clase vs estructura
// clase de tipo referencia, tiene herencia, sobrecarga
// las clases se crean en el HEAP (espacio dedicado de memoria para almacenar referencia)

// la estructura es de tipo valor por lo que no guarda referencias
// las structs se creat en el STACK (FILO, First In, Last Out) - super rapido

// creacion y destruccion de estructuras sea muy eficiente
