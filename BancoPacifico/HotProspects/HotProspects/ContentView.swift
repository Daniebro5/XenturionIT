import SwiftUI

struct ContentView: View {

    @State private var selectedTab = "Uno"

    var body: some View {
        TabView(selection: $selectedTab) {
            Button("Show Tab 2") {
                selectedTab = "Dos"
            }
            .tabItem {
                Label("Uno", systemImage: "star")
            }
            Text("Tab 2")
                .tabItem {
                    Label("Dos", systemImage: "circle")
                }
                .tag("Dos")
        }
    }
}

#Preview {
    ContentView()
}
