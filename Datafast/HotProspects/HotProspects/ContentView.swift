import SwiftUI

struct ContentView: View {

  let users = ["Danni", "Hugo", "Andrea", "Luis"]

  @State private var selection = Set<String>()

  var body: some View {
    TabView {
      Text("Tab 1")
        .tabItem {
          Label("Uno", systemImage: "star")
        }
      Text("Tab 2")
        .tabItem {
          Label("Dos", systemImage: "circle")
        }
    }
  }
}

#Preview {
  ContentView()
}
