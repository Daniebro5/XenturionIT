import SwiftData
import SwiftUI

struct ProspectsView: View {

  enum FilterType {
    case none, contacted, uncontacted
  }

  let filter: FilterType

  @Environment(\.modelContext) var modelContext
  @Query(sort: \Prospect.name) var prospects: [Prospect]

  init(filter: FilterType) {
    self.filter = filter

    if filter != .none {
      let showContactedOnly = filter == .contacted

      _prospects = Query(filter: #Predicate { $0.isContacted == showContactedOnly },
                         sort: [SortDescriptor(\Prospect.name)])
    }
  }

  var body: some View {
    NavigationStack {
      List(prospects) { prospect in
        VStack(alignment: .leading) {
          Text(prospect.name)
            .font(.headline)
          Text(prospect.emailAddress)
            .foregroundStyle(.secondary)
        }
      }
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

  // variable computada
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
