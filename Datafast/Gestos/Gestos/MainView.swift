import SwiftUI

struct MainView: View {

  @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor

  @State private var cards = Array<Card>(repeating: .example, count: 10)

  var body: some View {
    ZStack {
      VStack {
        if accessibilityDifferentiateWithoutColor {
          VStack {
            Spacer()
            HStack {
              Image(systemName: "xmark.circle")
                .padding()
                .background(.black.opacity(0.7))
                .clipShape(.circle)
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding()
          }
        }
        ZStack {
          ForEach(0 ..< cards.count, id: \.self) { index in
            CardView(card: cards[index]) {
              withAnimation {
                removeCard(at: index)
              }
            }
            .stacked(at: index, in: cards.count)
          }
        }
      }
    }
  }

  func removeCard(at index: Int) {
    cards.remove(at: index)
  }
}

extension View {
  func stacked(at position: Int, in total: Int) -> some View {
    let offset = Double(total - position)
    return self.offset(y: offset * 10)
  }
}

#Preview {
  MainView()
}
