import MapKit
import SwiftUI

struct ContentView: View {

    // aqui se ve xq es bueno poner el viewmodel en la extension, solo decimos ViewModel() y automaticamente obtenemos el correcto para nuestra vista

    @ObservedObject private var viewModel = ViewModel()

    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 56,
                longitude: -3),
            span: MKCoordinateSpan(
                latitudeDelta: 10,
                longitudeDelta: 10))
    )

    var body: some View {
        MapReader { proxy in
            Map(initialPosition: startPosition) {
                ForEach(viewModel.locations) { location in
                    Annotation(location.name,
                               coordinate: location.coordinate) {
                                    Image(systemName: "star.circle")
                                        .resizable()
                                        .foregroundStyle(.red)
                                    // apple recomienda este tamaño minimo para cosas que se pueda interactuar en pantalla
                                        .frame(width: 44, height: 44)
                                        .background(.white)
                                        .clipShape(.circle)
                                        .onLongPressGesture {
                                            viewModel.selectedPlace = location
                                        }
                                }
                }
            }
            .mapStyle(.hybrid)
            .onTapGesture { position in
                if let coordinate = proxy.convert(position,
                                                  from: .local) {
                    viewModel.addLocation(at: coordinate)
                }
            }
            // modificador que oculta el modal si no está seleccionado algo
            // pero muestra el model y pasa el objeto si se selecciona algo
            .sheet(item: $viewModel.selectedPlace) { place in
                EditView(location: place) {
                    viewModel.update(location: $0)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
