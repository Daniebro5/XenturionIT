import SwiftUI

struct ContentView: View {

  var body: some View {
    VStack {
      Text("Hola, Mundo!")
        .onTapGesture {
          // el hijo siempre tendrá prioridad si los gestos tienen la misma prioridad
          print("Text tapped")
        }
    }
    .highPriorityGesture(
      TapGesture()
        .onEnded{
          print("VStack tapped")
        }
    )
  }
}

#Preview {
  ContentView()
}
