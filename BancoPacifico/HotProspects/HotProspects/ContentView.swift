import SwiftUI
import UserNotifications

struct ContentView: View {

    var body: some View {
        VStack {
            Button("Request Permission") {
                UNUserNotificationCenter
                    .current()
                    .requestAuthorization(
                        options: [.alert, .badge, .sound]
                    ) { success, error in
                        if success {
                            print("Gracias!")
                        } else if let error {
                            print(error.localizedDescription)
                        }
                }
            }

            Button("Programar Notificacion") {
                let content = UNMutableNotificationContent()
                content.title = "Apagar la cocina"
                content.subtitle = "Se puede quemar el edificio"
                content.sound = UNNotificationSound.default

                let trigger = UNTimeIntervalNotificationTrigger(
                    timeInterval: 5,
                    repeats: false)

                let request = UNNotificationRequest(
                    identifier: UUID().uuidString,
                    content: content,
                    trigger: trigger)

                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}

#Preview {
    ContentView()
}
