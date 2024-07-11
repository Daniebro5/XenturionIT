import SwiftUI

struct ContentView: View {

  // cuanto han movido el circulo
  @State private var offset = CGSize.zero

  // se está moviendo?
  @State private var isDragging = false

  var body: some View {

    // un gesto de movimiento que actualiza el offset y la variable isDragging cuando se mueve
    let dragGesture = DragGesture()
      .onChanged { value in offset = value.translation }
      .onEnded { _ in
        withAnimation {
          offset = .zero
          isDragging = false
        }
      }

    // gesto que activa el movimiento
    let pressGesture = LongPressGesture()
      .onEnded { value in
        withAnimation {
          isDragging = true
        }
      }

    // un gesto combinado q fuerza al usuario a un longPress y luego a mover
    let combined = pressGesture.sequenced(before: dragGesture)

    Circle()
      .fill(.red)
      .frame(width: 64, height: 64)
      .scaleEffect(isDragging ? 1.5 : 1)
      .offset(offset)
      .gesture(combined)
  }
}

#Preview {
  ContentView()
}
