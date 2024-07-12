import SwiftUI

struct ContentView: View {
  var body: some View {
    HStack(alignment: .midAccountAndName) {
      VStack {
        Text("@iamdanniandre")
          .alignmentGuide(.midAccountAndName) { d in
            d[VerticalAlignment.center]
          }
        Image(systemName: "person.crop.circle")
          .resizable()
          .frame(width: 64, height: 64)
      }

      VStack {
        Text("Full Name:")
        Text("Danni André")
          .alignmentGuide(.midAccountAndName) { d in
            d[VerticalAlignment.center]
          }
          .font(.largeTitle)
      }
    }
  }
}

#Preview {
  ContentView()
}

extension VerticalAlignment {
  struct MidAccountAndName: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
      context[.top]
    }
  }

  static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}
