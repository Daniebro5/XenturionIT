import SwiftUI

struct ContentView: View {

    var body: some View {
        Button("Hello, SwiftUI", action: {})
            .padding()
            .foregroundColor(.white)
            .background(.black)
            .clipShape(.capsule)
    }
}

#Preview {
    ContentView()
}
