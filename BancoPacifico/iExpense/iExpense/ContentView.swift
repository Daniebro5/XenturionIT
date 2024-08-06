import SwiftUI

struct ContentView: View {
    @State private var showingSheet = false

    var body: some View {
        Button("Show sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: "@iamdanniandre")
        }
    }
}

struct SecondView: View {

    @Environment(\.dismiss) var dismiss

    let name: String

    var body: some View {
        VStack {
            Text("Hola \(name)!")
            Button("Dismiss") {
                dismiss()
            }
        }
    }
}

#Preview("ContentView") {
    ContentView()
}

#Preview("SecondView") {
    SecondView(name: "@iamdanniandre")
}
