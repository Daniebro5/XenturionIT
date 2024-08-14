import Foundation
import MapKit

extension ContentView {

    // @Observable
    // yo lo uso en extensiones para evitar recordar cientos de nombres y solo usar viewModel en la vista
    final class ViewModel: ObservableObject {
        // este approach esta deprecado, con el uso de @Observable, solo tendriamos que declarar las variables, y todas aquellas que no sean privadas, automaticamente se vuelven published

        // con private(set) nos ayudamos a identificar las partes de nuestro codigo que estan escribiendo en esta variable, algo que queremos evitar, xq solo este propio viewmodel debe ser capaz de modificar sus variables
        // leerlas está bien para actualizar la vista, por lo que el GET sigue siendo publico
        @Published private(set) var locations = [Location]()
        @Published var selectedPlace: Location?

        // Sintaxis Swifty
        // siempre pensemos en como se va a llamar la funcion para ser lo mas declarativos posible.... .addLocation(at: )
        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(),
                                       name: "New Location",
                                       description: "",
                                       latitude: point.latitude,
                                       longitude: point.longitude)
            locations.append(newLocation)
        }

        // siempre pensemos en como se va a llamar la funcion para ser lo mas declarativos posible.... .update(location: )
        func update(location: Location) {
            guard let selectedPlace else { return }

            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
            }
        }

        // .fantasma(10)
//        func fantasma(_ numero: Int) {}
    }
}
