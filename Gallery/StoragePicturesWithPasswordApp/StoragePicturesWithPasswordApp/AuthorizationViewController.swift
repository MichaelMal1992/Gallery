//
//  AuthorizationViewController.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 23.06.21.
//

import UIKit

class AuthorizationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let password = UserDefaults.standard.value(forKey: PasswordManager.shared.keyToPassword) as? String {
            PasswordManager.shared.password = password
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
        if PasswordManager.shared.password.isEmpty == true {
            createAlertWithNewPassword(title: "Create a password and don't share it with others") {
                self.createAlertRepeatNewPassword(title: "Repeat the new password") {
                    self.createNewViewController(String(describing: GalleryViewController.self))
                }
            }
        } else {
            createAlertWithPassword(title: "Enter the password", password: PasswordManager.shared.password) {
                self.createNewViewController(String(describing: GalleryViewController.self))
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
