//
//  KeychainService.swift
//
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import KeychainAccess

enum KeychainKey: String {
  case authToken
  case refreshToken
  case pushToken
}

final class KeychainService {
  
  static let shared = KeychainService()
  
  private let keychain = Keychain(service: Bundle.main.bundleIdentifier!)

  func get(for key: KeychainKey) -> String? {
    return keychain[string: key.rawValue]
  }
  
  func save(value: String?, for key: KeychainKey) {
    keychain[string: key.rawValue] = value
  }
  
  func deleteAuthTokens() {
    try? keychain.remove(KeychainKey.authToken.rawValue)
    try? keychain.remove(KeychainKey.refreshToken.rawValue)
  }
  
}
