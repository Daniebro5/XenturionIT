import SwiftUI

struct MainView: View {

  @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
  @Environment(\.scenePhase) var scenePhase

  @State private var isActive = true

  @State private var cards = Array<Card>(repeating: .example, count: 10)

  @State private var timeRemaining = 100
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

  var body: some View {
    ZStack {
      VStack {
        Text("Time: \(timeRemaining)")
          .font(.largeTitle)
          .foregroundStyle(.white)
          .padding(.horizontal, 20)
          .padding(.vertical, 5)
          .background(.black.opacity(0.75))
          .clipShape(.capsule)
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
    .onReceive(timer) { time in
      guard isActive else { return }
      if timeRemaining > 0 {
        timeRemaining -= 1
      }
    }
    .onChange(of: scenePhase) {
      if scenePhase == .active {
        isActive = true
      } else {
        isActive = false
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
