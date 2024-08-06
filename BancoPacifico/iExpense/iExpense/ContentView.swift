import SwiftUI

struct ContentView: View {
    @State private var showingSheet = false

    var body: some View {
        Button("Show sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView()
        }
    }
}

struct SecondView: View {
    var body: some View {
        Text("Second View")
    }
}

#Preview("ContentView") {
    ContentView()
}

#Preview("SecondView") {
    SecondView()
}
