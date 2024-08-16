import SwiftUI

struct ContentView: View {
    @State private var volumen: Double = 50
    var body: some View {
        VStack {
            Slider(value: $volumen, in: 0 ... 100, step: 1)
                .padding()
                .accessibilityLabel(Text("Volumen"))
                .accessibilityValue(Text("\(Int(volumen)) porciento"))

            Text("Volumen: \(Int(volumen))%")
        }
    }
}

#Preview {
    ContentView()
}
