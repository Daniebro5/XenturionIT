import SwiftData
import SwiftUI

struct ProspectsView: View {

  enum FilterType {
    case none, contacted, uncontacted
  }

  let filter: FilterType

  @Environment(\.modelContext) var modelContext
  @Query(sort: \Prospect.name) var prospects: [Prospect]

  var body: some View {
    NavigationStack {
      Text("Personas: \(prospects.count)")
        .navigationTitle(title)
        .toolbar {
          Button("Scan", systemImage: "qrcode.viewfinder") {
            let prospect = Prospect(name: "Danni André",
                                    emailAddress: "danni.andre@icloud.com",
                                    isContacted: false)
            modelContext.insert(prospect)
          }
        }
    }
  }

  var title: String {
    switch filter {
    case .none:
      "Todos"
    case .contacted:
      "Gente Contactada"
    case .uncontacted:
      "Gente no Contactada"
    }
  }
}

#Preview {
  ProspectsView(filter: .none)
}
