import Foundation
import MapKit

struct Location: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double

    var coordinate: CLLocationCoordinate2D {
        .init(latitude: latitude, longitude: longitude)
    }

    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }

    // tip: podemos rodear esto con los macros if debug para no enviar este codigo a produccion

    #if DEBUG
    static let example = Location(id: UUID(),
                                  name: "Buckingham Palace",
                                  description: "Iluminado por 40.000 bombillas",
                                  latitude: 51.501,
                                  longitude: -0.141)
    #endif
}
