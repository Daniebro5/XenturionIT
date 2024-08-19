import CryptoKit
import Foundation

// crptoKit es una API de APPLE que simplifica el uso de encriptacion en apps iOS
// es escencial en aplicaciones del sector bancario, medico, y legal

print("*** === Encriptación de Clave Simétrica === ***")
// Encriptación simétrica

// la más sencilla ya que utiliza la misma clave para cifrar y descifrar los datos

// creamos la clave simetrica
let claveSimetrica = SymmetricKey(size: .bits256)

// tenemos los datos codificados
let datosSensibles = "JessicaTeExtrañoVuelvePorFavor".data(using: .utf8)!

// dentro de la suite de encriptacion AES usaremos el algoritmo GCM para enriptar los datos
// metemos los datos dentro de una "caja sellada"

// GCM nos proporciona ademas metodos de autenticacion en otro constructor
let datosEncriptados = try! AES.GCM.seal(datosSensibles, using: claveSimetrica)
print(datosEncriptados)

//let caja = try! AES.GCM.SealedBox(combined: datosEncriptados)

// utilizamos el mismo algoritmo para desencriptar
let datosDesencriptados = try! AES.GCM.open(datosEncriptados, using: claveSimetrica)
print(datosDesencriptados)

// luego decodificamos los datos desencriptados
print(String(data: datosDesencriptados, encoding: .utf8)!)

print("*** === Encriptación de Clave Asimetrica (publica/privada) === ***")
// utiliza un par de claves, MATEMATICAMENTE enlazadas (numeros primos muy grandes)
// se utiliza de un patro de uno a muchos

// 91 (clave publica) -> 7 * 13 (clave privada)

// generamos el par de llaves
let clavePrivada = P256.KeyAgreement.PrivateKey()
let clavePublica = clavePrivada.publicKey

// datos a encriptar
let mensaje = "SeOlvidaronLosSanduchesVerdad?".data(using: .utf8)!

// encriptacion asimetrica
let claveSimetricaParaMensaje = SymmetricKey(size: .bits256)
// enviamos denbtro de la caja la misma clave simetrica (combined)
let datosEncriptadosSimetricamente = try! AES.GCM.seal(mensaje, using: claveSimetricaParaMensaje).combined!

// encriptamos la clave simetrica usando la clave publica
let claveEncriptada = try! clavePrivada.sharedSecretFromKeyAgreement(
    with: clavePublica
).hkdfDerivedSymmetricKey(
    using: SHA256.self,
    salt: Data(),
    sharedInfo: Data(),
    outputByteCount: 32
)


// Ejemplo de uso clave asimetrica
// quiero saber si el mensaje que recibo es realmente original

let mensajeDanni = "vuelve xfa".data(using: .utf8)!

//obtengo mi clave privada
let danniPrivateKey = Curve25519.Signing.PrivateKey()

// esto esta publicado en internet
let danniPublicKeyData = danniPrivateKey.publicKey.rawRepresentation

let digest512 = SHA512.hash(data: mensajeDanni)
print(digest512)
let firmaParaDigest = try! danniPrivateKey.signature(for: Data(digest512))


// envio mensajeDanni, digest512 y la firma (cualquiera del digest o de los datos)
// jessica va a recibir el mensaje y quiere saber si realmente lo envió danni

let clavePublicaDanni = try! Curve25519.Signing.PublicKey(rawRepresentation: danniPublicKeyData)

if clavePublicaDanni.isValidSignature(firmaParaDigest, for: Data(digest512)) {
    print("Datos recibidos, si son de Danni")
    print(String(data: mensajeDanni, encoding: .utf8)!)
}
