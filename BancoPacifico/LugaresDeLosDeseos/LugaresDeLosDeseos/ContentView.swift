import LocalAuthentication
import SwiftUI

struct ContentView: View {

    @State private var estaDesbloqueado = false

    var body: some View {
        VStack {
            if estaDesbloqueado {
                Text("Desbloqueado")
            } else {
                Text("Bloqueado")
            }
        }
        .onAppear(perform: autenticar)
    }

    func autenticar() {
        let context = LAContext()

        var error: NSError?

        // chequeamos si la autenticacion biometrica es posible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                     error: &error) {
            // es posible entoces usemoslo
            let reason = "Necesitamos desbloquear tus datos"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                // autenticacion completa
                if success {
                    estaDesbloqueado = true
                } else {
                    // existio un problema
                }
            }
        } else {
            // no existen biometricos disponibles
        }
    }
}

#Preview {
    ContentView()
}
