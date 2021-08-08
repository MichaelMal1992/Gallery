//
//  File.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 4.07.21.
//

import Foundation
import SwiftyKeychainKit

class PasswordManager {

    static let shared = PasswordManager()
    private lazy var keychain = Keychain(service: "michael.vasm.StoragePicturesWithPasswordApp")
    private let passwordKey = KeychainKey<String>(key: "_password")
    private init() { }

    func removePassword() {
        do {
            try keychain.removeAll()
        } catch {
            print(error.localizedDescription)
        }
    }

    func validatePassword(_ password: String) -> Bool {
        do {
            let storedPassword = try keychain.get(passwordKey)
            return password == storedPassword
        } catch {
            print(error.localizedDescription)
            return false
        }
    }

    func savePassword(_ password: String) {
        do {
            try keychain.set(password, for: passwordKey)
        } catch {
            print(error.localizedDescription)
        }
    }

    func isFirstAutorization() -> Bool {
        do {
            if let autorization = try keychain.get(passwordKey) {
                return autorization.isEmpty == true
            }
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}
