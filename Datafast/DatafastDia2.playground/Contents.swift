import Foundation
import UIKit

// Colecciones: Arrays, Sets y Diccionarios

// 1. Arrays - ordenado, con valores que pueden repetirse
// si el orden me importa y los elementos puede repetirse -> Array

var nombres = ["Andrea", "Kevin", "Luis"]
// O(n) n -> tamaño del array
nombres.append("Dario")

// O(n) n -> tamaño del array
// nombres.remove(at: 2)

// [] se llama subscript
print(nombres[3])

// 2. Sets - no ordenado, valores unicos
// si no me importa el orden y los elementos son unicos -> Set

// <> denota un generico
var numerosUnicos = Set<Int>()
// O(k)
numerosUnicos.insert(5)
print(numerosUnicos)
numerosUnicos.insert(5)
numerosUnicos.insert(5)
numerosUnicos.insert(5)
print(numerosUnicos)

// O(k)
numerosUnicos.remove(5)

// Hash - (sha - md5 - checksum)
// funcion especial, que obtiene un identificador (huella digital)
// que trata de ser unico
// insertar
// 5 -> hash -> uycgdsufewoihjec [5]
// 5 -> hash -> uycgdsufewoihjec [5] - sobreescribe
// eliminar
// 5 -> hash -> uycgdsufewoihjec [nil]

// 3. Diccionarios
// asociaciones clave valor
// clave -> Hash -> valor

var capitales = ["Ecuador": "Quito", "Francia": "Paris"]
capitales["Japon"] = "Tokyo"
print(capitales["Ecuador"])
print(capitales["Argentina"])

// O(k)
// Ecuador -> Hash -> ahjgdjhfho2398723 -> Quito

// me importa el orden? - necesito duplicados?
// si - si -> Array
// no - no -> Set o Diccionario
// necesito asociacion clave valor? si -> diccionario, no -> set

// O(k)
// capitales["Ecuador"] = nil

// *******
// Controles de flujo
// bucles for-in, while y repeat-while



// 1. bucle for-in
let nombres2 = ["Andrea", "Kevin", "Dario"]

// el numero de iteraciones se conoce
// O(n)
for nombre in nombres2 {
    print("Soy el mejor desarrollador y me llamo: \(nombre)")
}

// 2. bucle while

var numero = 5

// no sabemos cuantas veces se ejecutará
// O(n)
while numero > 0 {
    print(numero)
    numero = Int.random(in: -10 ... 10)
}

// 3. bucle repeat-while
var contador = 10

// no sabemos cuantas veces se ejecutará
// pero al menos se ejecutará una vez
repeat {
    print("Contador \(contador)")
    contador += 1
} while contador <= 5

// control de bucles con break - continue
// break para salir del bucle
// continue para terminar la iteracion actual y continuar con la siguiente

let numeros = [1,2,3,4,5,6,7,8,9,10]

for numero in numeros {
    if numero == 5 {
        break // salimos del bucle al encontrar el 5
    }
    if numero % 2 != 0 {
        continue // saltando los numeros impares
    }
    print("numero par: \(numero)")
}

// control de bucles con etiquetas
// O(n*m) -> prueba de performance, oportunidad de mejora
bucleImpar: for impar in [1,3,5,7,9] {

    buclePar: for par in [2,4,6,8,10] {
        if par == 4 {
            continue bucleImpar
        }
    }

    bucleAleatorio: for numeroAleatorio in [3,13,43,2,346,423,32] {
        print(impar, numeroAleatorio)
    }
}

// funciones avanzadas

// 1. funciones de múltiples parámetros

func crearEmail(to: String, asunto: String, body: String) {
    print("email enviado a \(to) con el asunto \(asunto): body es \(body)")
}

crearEmail(to: "dario@ejemplo.com",
           asunto: "Aumento de sueldo",
           body: "Estimado Dario nos complace informar desde RR.HH. de Datafast que su solicitud de aumento de sueldo ha sido aprobada. Quedo a su entera disposicion")

// 2. funciones con parámetros por defecto

func enviarMemo(a: String = "Andrea", motivo: String = "por resabiada") {
    print("memo enviado a \(a) con motivo: \(motivo)")
}

enviarMemo()
enviarMemo(a: "Enrique", motivo: "Grosero")
enviarMemo(motivo: "Borracho")

// 3. parametros Variadic
// permite adaptar el numero de parametros, aceptando los que sean enviados
func sum(numeros: Int...) -> Int {
    // numeros ahora es una coleccion
//    for numero in numeros {
//
//    }
    return numeros.reduce(0, +)
}

print("la suma es \(sum(numeros: 1,2,3,4,5))")

// 4. sobrecarga de funciones
// utilizar el mismo nombre de funcion con distintos parametros o tipos de parametros

// firma de funcion - func signature
// (Int...) -> (Int)
// (String, String) -> ()
// podemos sobrecargar (tener el mismo nombre) siempre y cuando las firmas no sean iguales

// (Double, Double) -> (Double)
// guion bajo es un parametro mudo
func multiplicar(_ a: Double, _ b: Double) -> Double {
    return a * b
}

// (Int, Int) -> (Int)
func multiplicar(_ a: Int, _ b: Int) -> Int {
    return a * b
}

multiplicar(5, 8)
multiplicar(5.61, 9834.5)

// 5. funciones q devuelven multiples valores
func obtenerGoles() -> (argentina: Int, ecuador: Int) {
    let golesArgentinos = 3
    let golesEnner = 0
    return (golesArgentinos, golesEnner)
}

let resultado = obtenerGoles()
print("Jugamos como nunca y perdimos como siempre, ya nada, quedamos \(resultado.argentina)-\(resultado.ecuador)")

// 6. parametros inout
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let aTemporal = a
    a = b
    b = aTemporal
}

var unEntero = 3
var otroEntero = 76
swapTwoInts(&unEntero, &otroEntero)

print("un entero ahora es: \(unEntero) y otroEntero ahora es: \(otroEntero)")

// Las funciones en Swift son Ciudadanos de Primera Clase
[1,2,3,4,5].count.magnitude.hashValue.codingKey

// firma es: (Int, Int) -> Int
func sumaDosEnteros(_ a: Int, _ b: Int) -> Int {
    return a + b
}

// firma es: (Int, Int) -> Int
func multiplicacionDosEnteros(_ a: Int, _ b: Int) -> Int {
    return a * b
}

func imprimirResultado(_ funcionMatematica: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("resultado \(funcionMatematica(a, b))")
}

imprimirResultado(sumaDosEnteros, 99, 11)
imprimirResultado(multiplicacionDosEnteros, 99, 11)
// las funciones son un caso especial de closure
imprimirResultado({ primerNumero, SegundoNumero in
    primerNumero + SegundoNumero
}, 99, 11)


func dividir(esteNumero numerador: Double, por denominador: Double) -> Double {
    // para chequear una precondicion
    // voy a continuar con la funcion siempre y cuando el denominador sea diferente de 0
    // el guard siempre va al inicio de la funcion xq su tarea es chequear precondiciones
    // y siempre en el else va a tener un return/break/continue
    guard denominador != 0 else { return 0 }
    return numerador / denominador
}

dividir(esteNumero: 8, por: 4)


// Closures en Swift
// bloques de codigo autocontenido que puede ser pasado por nuestro programa

let names = ["Chris", "Alex", "eva", "Daniel"]

func miOrdenamiento(cadena1: String, cadena2: String) -> Bool {
    return cadena1 > cadena2
}

// firma del closure es:
var reversedNames = names.sorted { (s1: String, s2: String) in
    return s1 > s2
}

var reversedNames2 = names.sorted(by: miOrdenamiento)

// los tiposde datos son inferidos, aqui ya sabemos q son cadenas
// cuando el cuerpo de la funcion solo tiene una linea, podemos ignorar el return
var reversedNames3 = names.sorted { s1, s2 in
    s1 > s2
}

// parametros anonimos
var reversedNames4 = names.sorted { $0 > $1 }

print(reversedNames)
print(reversedNames2)
print(reversedNames3)
print(reversedNames4)

// la firma es (String, String) -> Bool
// names.sorted(by:)

// sintaxis simplificada

// captura de valores

// (Int) -> (() -> Int)
func incrementar(por cantidad: Int) -> () -> Int {
    var total = 0
    let incrementador = {
        total += cantidad
        return total
    }
    return incrementador
}

let incrementadorPorDiez = incrementar(por: 10)
print(incrementadorPorDiez())

// ejemplo en animaciones de UIView
//UIView.animate(withDuration: 0.5) {
//    view.alpha = 0
//}, finished { finished in
//    view.removeFromSuperview()
//}

//DispatchQueue.main.async {
//    label.text = "He terminado de descargar"
//}

let primeraClosure = {
    print("hola")
}

// Valor o referencia? closure son de tipo referencia
let segundaClosure = primeraClosure
