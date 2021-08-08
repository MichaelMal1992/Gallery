//
//  UIViewController+Alert.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 23.06.21.
//

import UIKit

extension UIViewController {

    func createAlertWithPassword(_ title: String, _ password: String, _ completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addTextField { alert in
            alert.isSecureTextEntry = true
        }
        alert.addAction(UIAlertAction(title: localized("continue"), style: .default, handler: { _ in
            if let text = alert.textFields?.first?.text {
                if text == password {
                    completion()
                } else {
                    self.present(alert, animated: true)
                    alert.title = self.localized("incorrectPassword")
                    alert.textFields?.first?.text?.removeAll()
                }
            }
        }))
        present(alert, animated: true)
    }

    func createAlertCancel(_ title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: localized("cancel"), style: .cancel))
        present(alert, animated: true)
    }

    func createAlertActionAndCancel(_ title: String, _ completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: localized("cancel"), style: .cancel))
        alert.addAction(UIAlertAction(title: localized("continue"), style: .default, handler: { _ in
            completion()
        }))
        present(alert, animated: true)
    }

    func createAlertWithNewPassword(_ title: String, _ completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addTextField { alert in
            alert.isSecureTextEntry = true
        }
        alert.addAction(UIAlertAction(title: localized("next"), style: .default, handler: { _ in
            if let text = alert.textFields?.first?.text {
                var isPossibleCreatePassword = false
                if text.isEmpty == false {
                    for textPassword in text {
                        if textPassword == " " {
                            isPossibleCreatePassword = false
                        } else {
                            isPossibleCreatePassword = true
                        }
                    }
                    if isPossibleCreatePassword == true {
                        PasswordManager.setPassword(text)
                        completion()
                    } else {
                        self.present(alert, animated: true)
                        alert.title = self.localized("spacesPassword")
                        alert.textFields?.first?.text?.removeAll()
                    }
                } else {
                    self.present(alert, animated: true)
                    alert.title = self.localized("createPassword")
                    alert.textFields?.first?.text?.removeAll()
                }
            }
        }))
        present(alert, animated: true)
    }

    func createAlertRepeatNewPassword(_ title: String, _ completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addTextField { alert in
            alert.isSecureTextEntry = true
        }
        alert.addAction(UIAlertAction(title: localized("continue"), style: .default, handler: { _ in
            if let text = alert.textFields?.first?.text {
                if text == PasswordManager.getPassword {
                    PasswordManager.setPassword(text)
                    completion()
                } else {
                    self.present(alert, animated: true)
                    alert.title = self.localized("incorrectPassword")
                    alert.textFields?.first?.text?.removeAll()
                }
            }
        }))
        present(alert, animated: true)
    }
}
