import SwiftUI

enum FilterType {
    case none, contacted, uncontacted
}

struct ProspectsView: View {
    let filter: FilterType

    var body: some View {
        NavigationStack {
            Text("Hello World!")
                .navigationTitle(title)
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

#Preview {
    ProspectsView(filter: .none)
}
