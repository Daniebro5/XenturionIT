import Observation

@Observable
class User {
    var firstName = "Danni"
    var lastName = "Brito"
}


// Patron de diseño observable
// ReactNative, React, RxJS, RxSwift, RxKotlin

// inherentemente una app mobil es una app que reacciona a eventos:

// recibimos info del servidor
// el usuario hace un tap
// el usuario hace scroll
// recibimos una notificacion
// nos quedamos sin internet

// reaccionamos a eventos que suceden en cualquier momento

// al conjunto de toda la info (info que recibi del servidor, notificacion, estado de la red, si el usuario esta tocando la pantalla o no) lo llamamos ESTADO

// y la vista simplemente es un reflejo del ESTADO



// una app solo termina con un error (X) o en completitud (|)
// T                |------------------------------------------------->
// Tap              |------a--------------b-----------c----->
// Notificaciones   |--1------------2-------------3--------->
// Red              |--------------------------X---------->
// info del server  |---1------------------4--------------->
// mostrando modal  |------V--------------F-------------------->

// Streams

// Pantalla `       |--NS--M--------N-----MS---E--N---T---------->








// Patron Observable como Suscripciones

// La revista observable

// publicador           |--------a-------b--------c-------->
// suscriptor1                      |----b--------c---------->
// suscriptor2              |----a-------b----X



// publicador           |--------1-------2--------3--------4-------->
// filter(pares)        |----------------2-----------------4-------->
// map(x2)              |--------2-------4--------6--------8-------->
