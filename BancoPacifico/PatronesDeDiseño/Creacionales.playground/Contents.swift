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

print("\n=== FACTORY METHOD ===")
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

print("\n=== ABSTRACT FACTORY ===")
// Proporciona una interfaz para crear familias de objetos relacionados o dependientes sin especificar clases concretas
// una compañia que crea carros (electricos y a gasolina), tenemos dos fabricas una de componentes para el carro electrico y otra para los componentes del carro a gasolina

protocol Motor {
    func crear()
}

protocol Carroceria {
    func crear()
}

final class MotorElectrico: Motor {
    func crear() {
        print("Creando motor electrico")
    }
}

final class MotorAGasolina: Motor {
    func crear() {
        print("Creando motor a gasolina")
    }
}

final class CarroceriaSUV: Carroceria {
    func crear() {
        print("Creando carroceria de SUV")
    }
}

final class CarroceriaCamioneta: Carroceria {
    func crear() {
        print("Creando carroceria de camioneta")
    }
}

protocol FabricaCarros {
    func crearMotor() -> Motor
    func crearCarroceria() -> Carroceria
}

final class FabricaCarrosElectricos: FabricaCarros {
    func crearMotor() -> Motor {
        return MotorElectrico()
    }

    func crearCarroceria() -> Carroceria {
        return CarroceriaSUV()
    }
}

final class FabricaCarrosAGasolina: FabricaCarros {
    func crearMotor() -> Motor {
        return MotorAGasolina()
    }

    func crearCarroceria() -> Carroceria {
        return CarroceriaCamioneta()
    }
}

let fabricaElectrica = FabricaCarrosElectricos()
let motorElectrica = fabricaElectrica.crearMotor()
let carroceriaSUV = fabricaElectrica.crearCarroceria()

motorElectrica.crear()
carroceriaSUV.crear()

// cuando usarlo?
// cuando trabajamos con muchas clases que se relacionan entre si, es decir pertenecen a una sola familia

// casos de uso comunes
// construccion de APIs, creacion de Productos

// TIPS:
// 1. es util cuando trabajamos con familias de objetos englobados en unas familias generales
// 2. mantener coherencia, es decir asegurarnos que las interfaces y clases concretas realmente se relacionen entre si


print("\n=== BUILDER ===")
// nos permite construir objetos complejos paso a paso con configuraciones especificas
// pensemos en un sandwich del Subway , podemos elegir diferentes tipos de pan, de proteinas vegetales, salsas, quesos, etc

final class Sanduche {
    var pan: String?
    var proteina: String?
    var vegetales: [String] = []
    var salsas: [String] = []

    func mostrar() {
        print("Sanduche con \(pan ?? "sin pan"), \(proteina ?? "Sin proteina"), vegetales: \(vegetales.joined(separator: ", ")), salsas: \(salsas.joined(separator: ", "))")
    }
}

final class SanducheBuilder {
    private var sanduche = Sanduche()

    // usamos una funcion para modificar cada uno de los parametros
    func seleccionarPan(tipo: String) -> SanducheBuilder {
        sanduche.pan = tipo
        return self
    }

    func seleccionarProteina(tipo: String) -> SanducheBuilder {
        sanduche.proteina = tipo
        return self
    }

    func agregarVegetales(vegetales: [String]) -> SanducheBuilder {
        sanduche.vegetales = vegetales
        // funciona bien para implementar analytics
        return self
    }

    func agregarSalsas(salsas: [String]) -> SanducheBuilder {
        sanduche.salsas = salsas
        return self
    }

    // la funcion build es la que me devuelve el objeto construido
    func build() -> Sanduche {
        return sanduche
    }
}

let miSanduche = SanducheBuilder()
    .seleccionarPan(tipo: "Integral")
    .seleccionarProteina(tipo: "Carne")
    .agregarVegetales(vegetales: ["Cebolla", "Lechuga", "Tomate"])
    .agregarSalsas(salsas: ["Agria", "Aji"])
    .build()

miSanduche.mostrar()

//....

// cuando usarlo?
// identificar cuando hay constructores (inicializadores) con muchisimos parametros
// cuando el objeto tiene muchisimos tipos de configuraciones

// casos de uso comunes
// construccion de objetos complejos pero sistematicos, construccion de PDFs, XMLs, archivos en general. Y en carritos de compras en construccion de productos

// TIPS:
// 1. cuando la clase tiene una gran cantidad de parametros o si algunos de estos parametros son opcionales
// 2. para crear objetos que no se pueden modificar
// 3. permite q el proceso de construccion sea flexible, añadidiendo o modificando los mismo parametros si se quiere

print("\n=== Prototype ===")
// nos ayuda a crear objetos a partir de una instancia existente, es decir nos dará un CLON de la instancia (no una copia)
// copia es una referencia a la instancia original, CLON se refiere a que "copie" los valores de la instancia original pero es un objeto independiente

let miSanducheOriginal = Sanduche()
let miSanducheCopia = miSanducheOriginal

// este protocolo me permite clonar objetos
final class Personaje: NSCopying {
    var tipo: String
    var habilidad: String
    var comidaFavorita: Sanduche?

    init(tipo: String, habilidad: String, comidaFavorita: Sanduche? = nil) {
        self.tipo = tipo
        self.habilidad = habilidad
        self.comidaFavorita = comidaFavorita
    }

    func copy(with zone: NSZone? = nil) -> Any {
        // Shadow Copy
        return Personaje(tipo: self.tipo,
                         habilidad: self.habilidad)
        // deep copy
        return Personaje(tipo: self.tipo,
                         habilidad: self.habilidad,
                         comidaFavorita: comidaFavorita
        )
    }

    func mostrar() {
        print("\(tipo) con habilidad \(habilidad)")
    }
}

let guerrero = Personaje(tipo: "Guerrero", habilidad: "Espada")
let clonGuerrero = guerrero.copy() as? Personaje
clonGuerrero?.habilidad = "Pistola"

guerrero.mostrar()
clonGuerrero?.mostrar()

//....

// cuando usarlo?
// aplicamos prototype al querer clonar una instancia en lugar de copiarla y hacer referencia a la original
// util cuando queremos crear "hijos" de la clase original con pequeñas modificaciones, asi no pasamos por el proceso entero de creacion

// casos de uso comunes
// construccion de documentos, objetos que toman muchos pasos (su flujo) es muy complejo y largo

// TIPS:
// 1. aseguremonos de incluir el protocolo NSCopying
// 2. util para reducir el costo de crear instancias super complejas de objetos
// 3. tener en cuenta si el objeto original tiene referencias a otros y si queremos mantebner esas referencias (deep copy) o queremos un nuevo objeto limpio de referencias (shadow copy)

