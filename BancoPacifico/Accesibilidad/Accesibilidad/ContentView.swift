import SwiftUI

struct ContentView: View {
    @State private var isDarkMode = false
    var body: some View {
        VStack {
            Button(action: {
                isDarkMode.toggle()
            }, label: {
                Image(systemName: isDarkMode ? "sun.max.fill" : "moon.fill")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(isDarkMode ? Color.black : Color.white)
                    .foregroundStyle(isDarkMode ? .white : .black)
                    .clipShape(.capsule)
                    .ignoresSafeArea()
            })
            .accessibilityLabel(Text("Cambia el dark mode. Actualmente, dark mode esta \(isDarkMode ? "activado" : "desactivado")"))
        }

    }
}

#Preview {
    ContentView()
}
