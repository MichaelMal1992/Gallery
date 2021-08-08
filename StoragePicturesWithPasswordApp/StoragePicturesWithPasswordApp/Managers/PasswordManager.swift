//
//  File.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 4.07.21.
//

import Foundation

class PasswordManager {

    static var getPassword: String {
        if let password = UserDefaults.standard.value(forKey: "User_Password") as? String {
            return password
        }
        return ""
    }

    static func setPassword(_ password: String?) {
        if let newPassword = password {
            UserDefaults.standard.setValue(newPassword, forKey: "User_Password")
        }
    }
}
