import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack(alignment: .trailing) {
      Text("Hello, World!")
        .alignmentGuide(.trailing) { d in d[.leading] }
        .background(.blue)
      Text("otra cadena")
        .alignmentGuide(.trailing) { d in d[.leading] }
        .background(.brown)
      Text("otra cadena 2")
        .alignmentGuide(.trailing) { d in d[.trailing] }
        .background(.cyan)
    }
    .background(.red)
  }
}

#Preview {
  ContentView()
}
