import SwiftUI

struct ContentView: View {
  @State private var currentAmountScale = 0.0
  @State private var finalAmountScale = 1.0

  @State private var currentAmountAngle = Angle.zero
  @State private var finalAmountAngle = Angle.zero

  var body: some View {
    VStack(spacing: 30) {
      Text("Hola mundo - Escala!")
        .font(.title)
        .scaleEffect(finalAmountScale + currentAmountScale)
        .gesture(
          MagnifyGesture()
            .onChanged { value in
              currentAmountScale = value.magnification - 1
            }
            .onEnded{ value in
              finalAmountScale += currentAmountScale
              currentAmountScale = 0
            }
        )
      Text("Hola mundo - Rotacion!")
        .font(.title)
        .rotationEffect(finalAmountAngle + currentAmountAngle)
        .gesture(
          RotateGesture()
            .onChanged { value in
              currentAmountAngle = value.rotation
            }
            .onEnded{ value in
              finalAmountAngle += currentAmountAngle
              currentAmountAngle = .zero
            }
        )
    }

  }
}

#Preview {
  ContentView()
}
