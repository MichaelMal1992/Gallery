//
//  UIViewController+Alert.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 23.06.21.
//

import UIKit

extension UIViewController {
    func createAlertWithPassword(title: String, password: String, completion: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addTextField { alert in
            alert.isSecureTextEntry = true
        }
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
            if let text = alert.textFields?.first?.text {
                if text == password {
                    completion()
                } else {
                    self.present(alert, animated: true)
                    alert.title = "The entered password is wrong, try again"
                    alert.textFields?.first?.text?.removeAll()
                }
            }
        }))
        present(alert, animated: true)
    }

    func createAlertCancel(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

    func createAlertActionAndCancel(title: String, completion: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
            completion()
        }))
        present(alert, animated: true)
    }

    func createAlertWithNewPassword(title: String, completion: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addTextField { alert in
            alert.isSecureTextEntry = true
        }
        alert.addAction(UIAlertAction(title: "Next", style: .default, handler: { _ in
            if let text = alert.textFields?.first?.text {
                var isPossibleCreatePassword = false
                if text.isEmpty == false {
                    isPossibleCreatePassword = true
                    for textPassword in text {
                        if textPassword == " " {
                            isPossibleCreatePassword = false
                        }
                    }
                    if isPossibleCreatePassword == true {
                        PasswordManager.shared.password = text
                        completion()
                    } else {
                        self.present(alert, animated: true)
                        alert.title = "A password cannot contain spaces"
                        alert.textFields?.first?.text?.removeAll()
                    }
                } else {
                    self.present(alert, animated: true)
                    alert.title = "Create and enter a password to continiue"
                    alert.textFields?.first?.text?.removeAll()
                }
            }
        }))
        present(alert, animated: true)
    }

    func createAlertRepeatNewPassword(title: String, completion: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addTextField { alert in
            alert.isSecureTextEntry = true
        }
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
            if let text = alert.textFields?.first?.text {
                let password = PasswordManager.shared.password
                let key = PasswordManager.shared.keyToPassword
                if text == password {
                    UserDefaults.standard.setValue(password, forKey: key)
                    completion()
                } else {
                    self.present(alert, animated: true)
                    alert.title = "Incorrect the password, try again"
                    alert.textFields?.first?.text?.removeAll()
                }
            }
        }))
        present(alert, animated: true)
    }
}
