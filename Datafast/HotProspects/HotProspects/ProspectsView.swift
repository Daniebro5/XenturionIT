import SwiftUI

struct ProspectsView: View {

  enum FilterType {
    case none, contacted, uncontacted
  }

  let filter: FilterType

  var body: some View {
    NavigationStack {
      Text("Hola")
        .navigationTitle(title)
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
