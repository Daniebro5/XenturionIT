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

// Usando el Shared Secret para una comunicacion de dos vias
print("===*** SHARED SECRET ***===")
// es una caja sellada, en la cual tanto Danni y Jessica tienen una llave

// G es el punto generador del algoritmo de curva eliptica
// d es la clave privada de danni
// j es la clave privada de Jessica

// d * G es la clave publica de Danni
// j * G es la clave publica de Jessica

// (d * G) * j = (j * G) * d -> este es el shared secret
// - * - * - = - * - * -
// 1 -> Magia! (Matematicas)


let andreClavePrivada = Curve25519.KeyAgreement.PrivateKey()
// la clave publica (o en este caso sus datos DATA son publicados en internet)
let andreClavePublicaData = andreClavePrivada.publicKey.rawRepresentation

let paolaClavePrivate = Curve25519.KeyAgreement.PrivateKey()
// la clave publica (o en este caso sus datos DATA son publicados en internet)
let paolaClavePublicaData = paolaClavePrivate.publicKey.rawRepresentation

// un mensaje que va a ser la raiz de las comunicaciones, no importa si se filtra
// xq se va a basar en las claves privadas
let protocoloSAL = "el amor lo puede todo".data(using: .utf8)!


// cada uno va a obtener la clave publica del contrario y lugo la combina con su clave privada para obtener el primer SHAREDSECRET

// del lado de andre
let paolaClavePublica = try! Curve25519.KeyAgreement.PublicKey(rawRepresentation: paolaClavePublicaData)
let andreSharedSecret = try! andreClavePrivada.sharedSecretFromKeyAgreement(with: paolaClavePublica)
let andreClaveSimetrica = andreSharedSecret.hkdfDerivedSymmetricKey(
    using: SHA256.self,
    salt: protocoloSAL,
    sharedInfo: Data(),
    outputByteCount: 32)

// del lado de andre
let andreClavePublica = try! Curve25519.KeyAgreement.PublicKey(rawRepresentation: andreClavePublicaData)
let paolaSharedSecret = try! paolaClavePrivate.sharedSecretFromKeyAgreement(with: andreClavePublica)
let paolaClaveSimetrica = paolaSharedSecret.hkdfDerivedSymmetricKey(
    using: SHA256.self,
    salt: protocoloSAL,
    sharedInfo: Data(),
    outputByteCount: 32)

if andreClaveSimetrica == paolaClaveSimetrica {
    print("Hemos creado una clave simetrica entre andre y paola")
}

// SECURE ENCLAVE
print("===*** SECURE ENCLAVE ***===")
// los iPhone cuentan con un chip especializado en seguridad y encriptacion, este chip se llama secure enclave
// nos sirve para ejecutar operaciones de seguridad en un chip especializado, a este no tiene acceso ninguna aplicacion
// como extra nos permite darle una capa extra de acceso al uso de la clave
if SecureEnclave.isAvailable {
    let privateKey = try SecureEnclave.P256.Signing.PrivateKey()

    let accessControl = SecAccessControlCreateWithFlags(nil, kSecAttrAccessibleWhenUnlockedThisDeviceOnly, [.privateKeyUsage, .userPresence], nil)!

    let clavePrivadaConControlDeAcceso = try SecureEnclave.P256.Signing.PrivateKey(accessControl: accessControl)
} else {
    let privateKey = P256.Signing.PrivateKey()
}

