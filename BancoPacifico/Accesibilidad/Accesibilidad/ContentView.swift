import SwiftUI

struct ContentView: View {
    var body: some View {
        Image(systemName: "photo")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
            .accessibilityLabel(Text("Paisaje de montaña"))
            .accessibilityHint(Text("Un bello paisaje de una montaña en un atardecer"))
    }
}

#Preview {
    ContentView()
}
