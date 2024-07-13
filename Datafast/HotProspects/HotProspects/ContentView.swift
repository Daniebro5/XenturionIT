import UserNotifications
import SwiftUI

struct ContentView: View {

  @State private var backgroundColor = Color.red

  var body: some View {
    VStack {
      Button("Pedir permisos") {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
          if success {
            print("Lo logré")
          } else if let error {
            print(error.localizedDescription)
          }
        }
      }

      Button("Programar notificacion") {
        let content = UNMutableNotificationContent()
        content.title = "Colgar la ropa"
        content.subtitle = "Si no está lloviendo"
        content.sound = UNNotificationSound.default

        // mostraremos la notificacion despues de 5 segundos que se crea
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5,
                                                        repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)

        // añadimos nuestra peticion
        UNUserNotificationCenter.current().add(request)
      }
    }
  }
}

#Preview {
  ContentView()
}
