import SwiftUI

struct ContentView: View {

  @State private var output = ""

  var body: some View {
    EmptyView()
  }

  func fetchReadings() async {
    let fetchTask = Task {
      let url = URL(string: "https://hws.dev/readings.json")!
      let (data, _) = try await URLSession.shared.data(from: url)
      let readings = try JSONDecoder().decode([Double].self,
                                              from: data)
      return "Encontre \(readings.count) lecturas"
    }

    let result = await fetchTask.result

    switch result {
    case .success(let string):
      output = string
    case .failure(let error):
      output = "Error: \(error.localizedDescription)"
    }
  }
}

#Preview {
  ContentView()
}
