import Foundation
import LocalAuthentication
import MapKit

extension ContentView {

    // @Observable
    // yo lo uso en extensiones para evitar recordar cientos de nombres y solo usar viewModel en la vista
    final class ViewModel: ObservableObject {
        // este approach esta deprecado, con el uso de @Observable, solo tendriamos que declarar las variables, y todas aquellas que no sean privadas, automaticamente se vuelven published

        // con private(set) nos ayudamos a identificar las partes de nuestro codigo que estan escribiendo en esta variable, algo que queremos evitar, xq solo este propio viewmodel debe ser capaz de modificar sus variables
        // leerlas está bien para actualizar la vista, por lo que el GET sigue siendo publico
        @Published private(set) var locations: [Location]
        @Published var selectedPlace: Location?
        @Published var isUnlocked = false

        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")

        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }

        // Sintaxis Swifty
        // siempre pensemos en como se va a llamar la funcion para ser lo mas declarativos posible.... .addLocation(at: )
        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(),
                                       name: "New Location",
                                       description: "",
                                       latitude: point.latitude,
                                       longitude: point.longitude)
            locations.append(newLocation)
            save()
        }

        // siempre pensemos en como se va a llamar la funcion para ser lo mas declarativos posible.... .update(location: )
        func update(location: Location) {
            guard let selectedPlace else { return }

            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
            }
            save()
        }

        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }

        // Firma () -> Void ó Void -> Void ó () -> ()
        func authenticate() {
            let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                // esta razon se usa para el touchID, la string en el archivo de propiedades del proyecto se usa para el FaceID
                let reason = "Please authenticate yourself to unlock your places."
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                    if success {
                        self.isUnlocked = true
                    } else {
                        // error
                    }
                }
            } else {
                // no biometrics
            }
        }

        // .fantasma(10)
//        func fantasma(_ numero: Int) {}
    }
}
