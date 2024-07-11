import SwiftUI

struct MainView: View {

  @State private var cards = Array<Card>(repeating: .example, count: 10)

    var body: some View {
      ZStack {
        VStack {
          ZStack {
            ForEach(0 ..< cards.count, id: \.self) { index in
              CardView(card: cards[index])
                .stacked(at: index, in: cards.count)
            }
          }
        }
      }
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
