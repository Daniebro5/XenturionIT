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
