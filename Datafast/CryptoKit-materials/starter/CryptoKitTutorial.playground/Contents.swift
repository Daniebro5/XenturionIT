// Copyright (c) 2020 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

import UIKit
import CryptoKit

// Criptografia no solo es para uso no autorizado, verificar la corrupcion de datos.

// 3 estados de proteccion de datos

// datos en movimiento (envio y recibo de llamadas)
//    TLS Transport Layer Security (1.3)

// datos en uso (estan en memoria)
//    Autenticacion de usuario, LocalAuthentication (FaceID, TouchID)

// datos en descanso (almacenados en disco que no estan siendo usados)
//    DataProtection API -> CryptoKit -> Keychain
//    Siempre q el usuario ya tenga puesto un codigo de desbloqueo al iPhone, ya está disponible para nosotros usarlo, tipos de proteccion de archivos:
//          ProtectedUntilFirstUserAuthentication - Protegido hasta la autenticacion - archivos son cifrados hasta que el usuario desbloquea por primera vez el iphone (desde que esta apagado) Defecto
//          Complete - el archivo solo estara disponible si el dispositivo esta desbloqueado
//          CompleteUnlessOpen - si el archivo esta abierto se mantiene abierto asi se haya bloqueado


func getData(for item: String, of type: String) -> Data {
  let filePath = Bundle.main.path(forResource: item, ofType: type)!
  return FileManager.default.contents(atPath: filePath)!
}
//: ## Hashing data
//: ### Hashable Protocol
func hashItem(item: String) -> Int {
  var hasher = Hasher()
  item.hash(into: &hasher)
  return hasher.finalize()
}

// es una funcion unidireccional
// debe garantizar un nivel aceptable de unicidad () que sean unicos (digest)
// debe ser caotico (al cambiar una minima porcion de los datos asi sea un solo bit, el digest debe ser completamente diferente)
// debe ser estable

// DATA() -> (HASH) = Digest // si es posible
// Digest -> (X) = DATA() // Imposible

// aaaaaaaaaaaaaaaab -> (HASH) = 123456789
// aaaaaaaaaaaaaaaaa -> (HASH) = 168652386
// aaaaaaaaaaaaaaaaa -> (HASH) = 168652386
// aaaaaaaaaaaaaaaaa -> (HASH) = 168652386
// aaaaaaaaaaaaaaaaa -> (HASH) = 168652386
// aaaaaaaaaaaaaaaaa -> (HASH) = 168652386

//: ### Cryptographic Hashing
let data = getData(for: "Baby", of: "png")
UIImage(data: data)

// Create a digest of `data`:
let digest = SHA256.hash(data: data)


// Dumbledore sends`data` and `digest` to Harry,
// who hashes `data` and checks that digests match.
let receivedDataDigest = SHA256.hash(data: data)
if digest == receivedDataDigest {
  print("los datos recibidos están integros")
}


// Get String representation of `digest`:


// Small change in `data` produces completely different digest:
String(describing: SHA256.hash(data: "Harry is a horcrux".data(using: .utf8)!))
String(describing: SHA256.hash(data: "Harry is a horcrux.".data(using: .utf8)!))

print(String(describing: digest))
//: ## HMAC: Hash-based Message Authentication Code
//: Use a symmetric cryptographic key when creating the digest
//: so the receiver knows it’s from you, or a server can check
//: that you’re authorized to upload files.
// Create a 256-bit symmetric key
// clave simetrica significa que el sender y el receiver ambos conocen la clave privada
// Clave simetrica permite a ambos (sender y receiver) crear sus pares de claves interna y externa para firmar y decodificar
// Es como tener una caja y un candado (que requiere llave tanto al abrir como para cerrar), ambos usuarios tendrian copia de la llave (firmo el digest y envio en la caja)

// Create a keyed digest of data
let key256 = SymmetricKey(size: .bits256)
let sha512MAC = HMAC<SHA256>.authenticationCode(for: data, using: key256)
String(describing: sha512MAC)

// Convert signature to Data
let authenticationCodeData = Data(sha512MAC)

// Dumbledore sends data and signature to Harry, who checks the signature:
if HMAC<SHA512>.isValidAuthenticationCode(authenticationCodeData,
                                          authenticating: data,
                                          using: key256) {
  print("El HMAC corresponde a los datos \(data)")
  UIImage(data: data)
} else {
  print("nos han hackeado!")
}



//: ## Authenticated Encryption
// Create a sealed box with the encrypted data
let sealedBoxData = try! ChaChaPoly.seal(data, using: key256).combined
// AES.GCM es un standard en USA
// combined usamos para enviar por internet

// Send sealed box data over network connection
let sealedBox = try! ChaChaPoly.SealedBox(combined: sealedBoxData)


// Decrypt data with the same key
let decryptedData = try! ChaChaPoly.open(sealedBox, using: key256)

// What else is in the box?
sealedBox.nonce
sealedBox.tag


// encryptedData isn't an image
let encryptedData = sealedBox.ciphertext
UIImage(data: encryptedData)


//: ## Public-Key Cryptography
// Crea dos claves MATEMATICAMENTE enlazadas (Numeros primos muuuuuy grandes), mantenemos nuestra clave "privada" en el Keychain o en el SecureEnclave y publico la clave publica.
// SecureEnclave es un chip (si es físicamente un CHIP)
// el keychain es un espacio de almacenamiento seguro que usa el secureenclave para encriptar

// tanto el usuario como el servidor (ambos tienen su clave publica publicada, y su correspodiente clave privada guardada) toman su propia clave privada y la clave publica del otro y general un SHARED-SECRET

// Servidor privX - pubY -> (SHAREDSECRET) -> privX-pubB
// Cliente  privA - pubB -> (SHAREDSECRET) -> privA-pubY

// privX-pubB y privA-pubY se comportan como la misma clave, acabo de obtener una clave simetrica.


// Dumbledore wants to send the horcrux image to Harry.
// He signs it so Harry can verify it's from him.
let albusSigningPrivateKey = Curve25519.Signing.PrivateKey()


// Dumbledore publishes `albusSigningPublicKeyData`.
// Dumbledore signs `data` (or `digest`) with his private key.
let albusSigningPublicKeyData = albusSigningPrivateKey.publicKey.rawRepresentation
let signatureForData = try! albusSigningPrivateKey.signature(for: data)

// Signing a digest of the data is faster:
let digest512 = SHA512.hash(data: data)
let signatureForDigest = try! albusSigningPrivateKey.signature(for: Data(digest512))

// Dumbledore sends `data`, `digest512` and `signatureForData`
// or `signatureForDigest` to Harry, who verifies signatures
// with key created from `albusSigningPublicKeyData`.
let publicKey = try! Curve25519.Signing.PublicKey(rawRepresentation: albusSigningPublicKeyData)
if publicKey.isValidSignature(signatureForData, for: data) {
  print("Estoy seguro que fue Albus Dumbledore")
}
if publicKey.isValidSignature(signatureForDigest, for: Data(digest512)) {
  print("Albus me lo envió, y además, están íntegros")
}



//: ## Shared secret / Key agreement
// Dumbledore and Harry create private and public keys for
// key agreement, and publish the public keys.

let albusPrivateKey = Curve25519.KeyAgreement.PrivateKey()
let albusPublicKeyData = albusPrivateKey.publicKey.rawRepresentation

let harryPrivateKey = Curve25519.KeyAgreement.PrivateKey()
let harryPublicKeyData = harryPrivateKey.publicKey.rawRepresentation



// Dumbledore and Harry must agree on the salt value
// for creating the symmetric key:
let protocolSalt = "Horrocruxes de Voldemort".data(using: .utf8)!


// Dumbledore uses his private key and Harry's public key
// to calculate `sharedSecret` and `symmetricKey`.

let harryPublicKey = try! Curve25519.KeyAgreement.PublicKey(rawRepresentation: harryPublicKeyData)

let ADSharedSecret = try! albusPrivateKey.sharedSecretFromKeyAgreement(with: harryPublicKey)

let ADSymmetricKey = ADSharedSecret.hkdfDerivedSymmetricKey(using: SHA256.self,
                                                            salt: protocolSalt,
                                                            sharedInfo: Data(),
                                                            outputByteCount: 32)


// Harry uses his private key and Dumbledore's public key
// to calculate `sharedSecret` and `symmetricKey`.
let albusPublicKey = try! Curve25519.KeyAgreement.PublicKey(rawRepresentation: albusPublicKeyData)

let HPSharedSecret = try! harryPrivateKey.sharedSecretFromKeyAgreement(with: albusPublicKey)

let HPSymmetricKey = HPSharedSecret.hkdfDerivedSymmetricKey(using: SHA256.self,
                                                            salt: protocolSalt,
                                                            sharedInfo: Data(),
                                                            outputByteCount: 32)




// As if by magic, they produce the same symmetric key!

if ADSymmetricKey == HPSymmetricKey {
  print("Se estan comunicando de manera segura")
}
//: Now Dumbledore and Harry can use symmetric key cryptography to authenticate or encrypt data.
