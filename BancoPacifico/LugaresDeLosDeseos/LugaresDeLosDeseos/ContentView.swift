import MapKit
import SwiftUI

struct ContentView: View {

    var body: some View {
        MapReader { proxy in
            Map()
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, to: .local) {
                        print(coordinate)
                    }
                }
        }

    }
}

struct Location: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

#Preview {
    ContentView()
}
