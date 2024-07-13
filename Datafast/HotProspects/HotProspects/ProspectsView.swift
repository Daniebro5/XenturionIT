import CodeScanner
import SwiftData
import SwiftUI
import UserNotifications

struct ProspectsView: View {

  enum FilterType {
    case none, contacted, uncontacted
  }

  let filter: FilterType

  @Environment(\.modelContext) var modelContext
  @Query(sort: \Prospect.name) var prospects: [Prospect]
  @State private var isShowingScanner = false
  @State private var selectedProspects = Set<Prospect>()

  init(filter: FilterType) {
    self.filter = filter

    if filter != .none {
      let showContactedOnly = filter == .contacted

      _prospects = Query(filter: #Predicate { $0.isContacted == showContactedOnly },
                         sort: [SortDescriptor(\Prospect.name)])
    }
  }

  var body: some View {
    NavigationStack {
      List(prospects, selection: $selectedProspects) { prospect in
        VStack(alignment: .leading) {
          Text(prospect.name)
            .font(.headline)
          Text(prospect.emailAddress)
            .foregroundStyle(.secondary)
        }
        .swipeActions {
          Button("Delete", systemImage: "trash") {
            modelContext.delete(prospect)
          }
          .tint(.red)
          if prospect.isContacted {
            Button("Marcar como no contactado",
                   systemImage: "person.crop.circle.fill.badge.xmark") {
              prospect.isContacted.toggle()
            }
                   .tint(.blue)
          } else {
            Button("Marcar como contactado",
                   systemImage: "person.crop.circle.badge.checkmark") {
              prospect.isContacted.toggle()
            }
                   .tint(.green)
          }
        }
        .tag(prospect)
      }
      .navigationTitle(title)
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button("Scan", systemImage: "qrcode.viewfinder") {
            isShowingScanner = true
          }
        }
        ToolbarItem(placement: .topBarLeading) {
          EditButton()
        }
        if !selectedProspects.isEmpty {
          ToolbarItem(placement: .bottomBar) {
            Button("Delete Selected", action: delete)
          }
        }
      }
    }
    .sheet(isPresented: $isShowingScanner) {
      CodeScannerView(codeTypes: [.qr],
                      simulatedData: "Danni Brito\ndanni.andre@icloud.com",
                      completion: handleScan)
    }
  }

  func handleScan(result: Result<ScanResult, ScanError>) {
    isShowingScanner = false
    switch result {
    case .success(let result):
      let details = result.string.components(separatedBy: "\n")
      guard details.count == 2 else { return }

      let person = Prospect(name: details[0], emailAddress: details[1], isContacted: false)
      modelContext.insert(person)
    case .failure(let error):
      print("Scaneo fallido: \(error.localizedDescription)")
    }
  }

  func delete() {
    for prospect in selectedProspects {
      modelContext.delete(prospect)
    }
  }

  func addNotification(for prospect: Prospect) {
    let center = UNUserNotificationCenter.current()

    let addRequest = {
      let content = UNMutableNotificationContent()
      content.title = "Contactar a \(prospect.name)"
      content.subtitle = prospect.emailAddress
      content.sound = UNNotificationSound.default

//      var dateComponents = DateComponents()
//      dateComponents.hour = 9
//
//      let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, 
//                                                  repeats: false)

      let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5,
                                                      repeats: false)

      let request = UNNotificationRequest(identifier: UUID().uuidString,
                                          content: content,
                                          trigger: trigger)
      center.add(request)
    }

    center.getNotificationSettings { settings in
      if settings.authorizationStatus == .authorized {
        addRequest()
      } else {
        center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
          if success {
            addRequest()
          } else if let error {
            print(error.localizedDescription)
          }
        }
      }
    }
  }

  // variable computada
  var title: String {
    switch filter {
    case .none:
      "Todos"
    case .contacted:
      "Gente Contactada"
    case .uncontacted:
      "Gente no Contactada"
    }
  }
}

#Preview {
  ProspectsView(filter: .none)
}
