/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation


// Facade - Patron Diseño
struct KeychainWrapperError: Error {
  var message: String?
  var type: KeychainErrorType

  enum KeychainErrorType {
    case badData
    case servicesError
    case itemNotFound
    case unableToConvertToString
  }

  init(status: OSStatus, type: KeychainErrorType) {
    self.type = type
    if let errorMessage = SecCopyErrorMessageString(status, nil) {
      self.message = String(errorMessage)
    } else {
      self.message = "Status Code: \(status)"
    }
  }

  init(type: KeychainErrorType) {
    self.type = type
  }

  init(message: String, type: KeychainErrorType) {
    self.message = message
    self.type = type
  }
}

final class KeychainWrapper {
  func storeGenericPasswordFor(
    account: String,
    service: String,
    password: String
  ) throws {
    guard let passwordData = password.data(using: .utf8) else {
      throw KeychainWrapperError(type: .badData)
    }

    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: account, // username
      kSecAttrService as String: service, // cadena auxiliar, por ejemplo: user login
      kSecValueData as String: passwordData // datos de la contraseña
    ]

    // añadimos la info del password al keychain
    let status = SecItemAdd(query as CFDictionary, nil)

    switch status {
    case errSecSuccess:
      // nuestra contraseña ahora está en el keychain
      break
    default:
      throw KeychainWrapperError(status: status, type: .servicesError)
    }
  }

  func getGenericPasswordFor(account: String, service: String) throws -> String {
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: account, // username
      kSecAttrService as String: service, // cadena auxiliar, por ejemplo: user login
      kSecMatchLimit as String: kSecMatchLimitOne, // le digo al keychain que espero solo 1 item
      kSecReturnAttributes as String: true,
      kSecReturnData as String: true
    ]

    var item: CFTypeRef?
    let status = SecItemCopyMatching(query as CFDictionary, &item)
    guard status != errSecItemNotFound else {
      throw KeychainWrapperError(type: .itemNotFound)
    }

    guard status == errSecSuccess else {
      throw KeychainWrapperError(status: status, type: .servicesError)
    }

    guard
      let existingItem = item as? [String: Any],
      let valueData = existingItem[kSecValueData as String] as? Data,
      let value = String(data: valueData, encoding: .utf8)
    else {
      throw KeychainWrapperError(type: .unableToConvertToString)
    }

    return value
  }
}
