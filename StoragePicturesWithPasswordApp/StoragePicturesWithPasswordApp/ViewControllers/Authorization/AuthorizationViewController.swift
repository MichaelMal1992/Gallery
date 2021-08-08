//
//  AuthorizationViewController.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 23.06.21.
//

import UIKit

class AuthorizationViewController: UIViewController {

    private let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
        let password = PasswordManager.getPassword
        if password.isEmpty == true {
            createAlertWithNewPassword(localized("createPassword")) {
                self.createAlertRepeatNewPassword(self.localized("repeatPassword")) {
                    self.createNewViewController(String(describing: GalleryViewController.self))
                }
            }
        } else {
            createAlertWithPassword(localized("enterPassword"), password) {
                self.createNewViewController(String(describing: GalleryViewController.self))
            }
        }
    }
}
