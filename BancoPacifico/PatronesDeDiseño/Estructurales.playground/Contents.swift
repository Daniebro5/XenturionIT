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

print("=== FACADE (FACHADA) ===")
// proporciona una interfaz simplificada que oculta toda la complejidad
// un cajero automatico ejecuta accions muy complejas (verificar cedula, verificar cuenta, verificar fondos, verificar destinos, comprobar red.....) pero para el usuario solo hay una interfaz simple con digitos y un par de botones

final class SistemaBanco {
    func verificarCuenta(cuenta: String) -> Bool {
        print("verificando cuenta")
        return Bool.random()
    }

    func retirarDinero(monto: Int) {
        print("retirando \(Int.random(in: 10_000 ... 1_000_000))")
    }

    func depositarDinero(monto: Int) {
        print("depositar \(Int.random(in: 1 ... 10))")
    }
}

// esta es la fachada que oculta la complejidad de un banco
final class CajeroAutomatico {
    private let sistemaBanco = SistemaBanco()

    func realizarRetiro(cuenta: String, monto: Int) {
        if sistemaBanco.verificarCuenta(cuenta: cuenta) {
            sistemaBanco.retirarDinero(monto: monto)
        } else {
            print("cuenta invalida")
        }
    }

    func realizarDeposito(cuenta: String, monto: Int) {
        if sistemaBanco.verificarCuenta(cuenta: cuenta) {
            sistemaBanco.depositarDinero(monto: monto)
        } else {
            print("cuenta invalida")
        }
    }
}

let cajero = CajeroAutomatico()
cajero.realizarRetiro(cuenta: "12000305646546", monto: 5)
cajero.realizarDeposito(cuenta: "12000305646546", monto: 10)

/* cuando usarlo?
para simplificar una interfaz compleja o un sistema complejo para que sea mas facil de usar

 casos comunes de uso: print (una funcion super facil de usar, pero por dentro hace miles de parsings para poner ver los resultados en consola), graficos (construccion de imagenes), APIs complejas

 tips:
 1. si es complejo interactuar con algun sistema, puede ser un buen lugar para un Facade
 2. aseguremonos de simplificar las cosas, si no se simplifica lo suficiente, puede ser un overkill
 3. facade puede ser implementado por delante de los adapters para incluir un amplio rango de soluciones
*/

print("=== PROXY ===")
// un objeto que actua en representacion de otro (o lo sustituye), controla el acceso o proporciona funcionalidades adicionales
// un representante de una celebridad es quien habla con la celebridad y no las empresas directamente

protocol ServicioInternet {
    func conectarASitioWeb(url: String)
}

final class ServicioInternetNetlife: ServicioInternet {
    func conectarASitioWeb(url: String) {
        print("conectando a \(url)")
    }
}

final class Proxy: ServicioInternet {
    private var objetoMegaPesado: Int?
    private var servicioReal = ServicioInternetNetlife()
    private let sitiosBloqueados = ["tinder.com", "cuevana.com", "tarjetaroja.com"]

    func conectarASitioWeb(url: String) {
        if sitiosBloqueados.contains(url) {
            print("Acceso denegado a \(url)")
        } else {
            servicioReal.conectarASitioWeb(url: url)
        }
    }

    func usarObjetoPesado() {
        objetoMegaPesado = 10
    }
}

let internet = Proxy()
internet.conectarASitioWeb(url: "tarjetaroja.com")
internet.conectarASitioWeb(url: "disneyplus.com")

/* cuando usarlo?
cuando necesitamos un intermediario, ya sea para aplicar controles, mejorar rendimiento, o agragar capacidades adicionales

 casos comunes de uso: control de acceso, red, para reducir latencia, gestion de permisos

 tips:
 1. util, para el acceso diferido de un objeto (lazy initialization), si nuestro objeto real es muy pesado, al generar el proxy podriamos definir la regla que, solo se cree este objeto si es utilizado mediante el proxy
 2. controlamos el acceso a recurso pesados, como conexiones a bases de datos, o red
 3. es util para agregar logica adicional, como caching o analytics antes o despues de acceder al objeto
*/

print("=== BRIDGE ===")
// separa la abstraccion de la implementacion para permitir evoluciones en una linea de tiempo separada
// un representante de una celebridad es quien habla con la celebridad y no las empresas directamente

protocol Dispositivo {
    var volumen: Int { get set }
    func encender()
    func apagar()
}

final class TV: Dispositivo {
    func encender() {
        print("TV Encendida")
    }

    func apagar() {
        print("TV apagada y luego algo mas complejo")
    }

    var volumen: Int = 10
}

final class EquipoDeSonido: Dispositivo {
    func encender() {
        print("EquipoDeSonido Encendido")
    }

    func apagar() {
        print("EquipoDeSonido apagado")
    }

    var volumen: Int = 20
}

// creamos el bridge (puente)
final class ControlRemoto {
    private var dispositivo: Dispositivo

    init(dispositivo: Dispositivo) {
        self.dispositivo = dispositivo
    }

    func encender() {
        dispositivo.encender()
    }

    func apagar() {
        dispositivo.apagar()
    }

    func cambiarVolumen(a volumen: Int) {
        dispositivo.volumen = volumen
        print("Volumen cambiado a: \(volumen)")
    }
}

let tv = TV()
let controlTV = ControlRemoto(dispositivo: tv)
controlTV.encender()

/* cuando usarlo?
cuando necesitamos un intermediario, ya sea para aplicar controles, mejorar rendimiento, o agragar capacidades adicionales

 casos comunes de uso: control de acceso, red, para reducir latencia, gestion de permisos

 tips:
 1. util, para el acceso diferido de un objeto (lazy initialization), si nuestro objeto real es muy pesado, al generar el proxy podriamos definir la regla que, solo se cree este objeto si es utilizado mediante el proxy
 2. controlamos el acceso a recurso pesados, como conexiones a bases de datos, o red
 3. es util para agregar logica adicional, como caching o analytics antes o despues de acceder al objeto
*/

