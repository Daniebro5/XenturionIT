import SwiftData
import SwiftUI

enum FilterType {
    case none, contacted, uncontacted
}

struct ProspectsView: View {
    let filter: FilterType

    @Query(sort: \Prospect.name) var prospects: [Prospect]
    @Environment(\.modelContext) var modelContext

    var body: some View {
        NavigationStack {
            Text("People:\(prospects.count)")
                .navigationTitle(title)
                .toolbar {
                    Button("Scan", 
                           systemImage: "qrcode.viewfinder") {
                        let prospect = Prospect(
                            name: "Danni Brito",
                            emailAddress: "consultor1@xenturionit.com",
                            isContacted: false
                        )
                        modelContext.insert(prospect)
                    }
                }
        }
    }

    var title: String {
        switch filter {
        case .none:
            "Everyone"
        case .contacted:
            "Contacted People"
        case .uncontacted:
            "Uncontacted People"
        }
    }
}
