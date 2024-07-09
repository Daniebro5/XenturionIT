//
//  ContentView.swift
//  DatafastConsumoAPIsApp
//
//  Created by Danni Andre Brito Morales on 3/7/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // dibuja en profundidad desde atrás hacia adelante
        ZStack {
            // dibuja desde arriba hacia abajo
            Color.red
            VStack(alignment: .leading) {
                // dibuja una imagen
                Image(systemName: "globe")
                    .resizable()
                    .frame(width: 100, height: 100)
                // dibuja un texto
                Text("Hello, world!")
                    .foregroundStyle(.blue)
                // Fuentes definidas en apple:
                    .font(.largeTitle)
                Text("Este")
                Text("Es")
                Text("El")
                Text("Curso")
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                Text("de")
                    .bold()
                Text("desarrollo")
                    .background(Color.blue)
                Text("iOS")
                    .kerning(5)
                    .italic()
                    .bold()
                Image(systemName: "globe")
                // dibuja de izq a derecha
                HStack {
                    Text("La vista esLa vista esLa vista esLa vista esLa vista esLa vista esLa vista esLa vista esLa vista esLa vista es")
                        .multilineTextAlignment(.trailing)
                    Text("horizontal")
                }
                HStack {
                    Text("Esto a la izquierda")
                    // vista transparente, que va a tomar todo el espacio disponible, siempre querrá hacerse lo más grande que pueda
                    Spacer()
                    Text("Esto a la derecha")
                }
                .background(Color.green)

                HStack {
                    Spacer()
                    Text("Esto al centro")
                    Spacer()
                }
                .background(Color.white)
            }
            // el padding empuja el contenido hacia donde se le indique
            .padding(.horizontal, 2)
        }


    }
}

#Preview {
    ContentView()
}

// stack es un contenedor de vistas ordenadas
// SwiftUI es una manera declarativa de hacer interfaces

// siempre va a tomar todo el espacio disponible


// iOS, la izquierda se llama LEADING, la derecha se llama TRAILING, arriba se llama TOP y abajo se llama BOTTOM


// La combinación de stacks y spacers es lo que la gran mayoría de vistas vas a necesitar
