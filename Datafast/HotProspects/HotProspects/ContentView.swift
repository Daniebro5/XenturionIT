import SwiftUI

struct ContentView: View {

  @State private var backgroundColor = Color.red

  var body: some View {
    VStack {
      Text("Hello, World!")
        .padding()
        .background(backgroundColor)

      Text("Change Color")
        .padding()
        .contextMenu {
          Button("Rojo") {
            backgroundColor = .red
          }

          Button("Verde") {
            backgroundColor = .green
          }

          Button("Azul") {
            backgroundColor = .blue
          }
        }
    }
  }
}

#Preview {
  ContentView()
}
