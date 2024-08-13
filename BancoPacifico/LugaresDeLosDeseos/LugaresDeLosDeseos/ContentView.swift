import MapKit
import SwiftUI

struct ContentView: View {

    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: -2.1891,
                longitude: -79.8899),
            // span es que tanto de su alrededor se ve del punto inicial
            span: MKCoordinateSpan(
                latitudeDelta: 0.01,
                longitudeDelta: 0.01))
    )

    var body: some View {
        // gestos
        // option nos da el gesto del pinch o dos dedos para hacer zoom
        // option + shift nos da el gesto de rotacion o inlcinacion de mapa con dos dedos
        // doble tap nos da el zoom
//        Map()
//        // style imaginery es satelite
//            .mapStyle(.imagery)
        // hybrid combina ambos
        // hybris con elevation nos da relieve

        // le decimos como el usuario puede interactuar
        // vacio significa que el mapa es estatico
//        Map(interactionModes: [])
//            .mapStyle(.hybrid(elevation: .realistic))

        VStack {
            Map(position: $position)
                .onMapCameraChange { context in
                    print(context.region)
                }


            HStack(spacing: 50) {
                Button("Paris") {
                    position = MapCameraPosition.region(
                        MKCoordinateRegion(
                            center: CLLocationCoordinate2D(
                                latitude: 48.8566,
                                longitude: 2.3522),
                            // span es que tanto de su alrededor se ve del punto inicial
                            span: MKCoordinateSpan(
                                latitudeDelta: 0.01,
                                longitudeDelta: 0.01))
                        )
                }

                Button("Tokio") {
                    position = MapCameraPosition.region(
                        MKCoordinateRegion(
                            center: CLLocationCoordinate2D(
                                latitude: 35.6897,
                                longitude: 139.6922),
                            // span es que tanto de su alrededor se ve del punto inicial
                            span: MKCoordinateSpan(
                                latitudeDelta: 0.01,
                                longitudeDelta: 0.01))
                        )
                }

                Button("Quito") {
                    position = MapCameraPosition.region(
                        MKCoordinateRegion(
                            center: CLLocationCoordinate2D(
                                latitude: 0.0,
                                longitude: -78.4810),
                            // span es que tanto de su alrededor se ve del punto inicial
                            span: MKCoordinateSpan(
                                latitudeDelta: 0.01,
                                longitudeDelta: 0.01))
                        )
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
