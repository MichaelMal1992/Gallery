//
//  AuthorizationViewController.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 23.06.21.
//

import UIKit

class AuthorizationViewController: UIViewController {

    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var repeatPasswordTextField: UITextField!
    @IBOutlet weak private var passwordContainerView: UIView!
    @IBOutlet weak private var repeatPasswordContainerView: UIView!
    @IBOutlet weak private var taglineLabel: UILabel!
    @IBOutlet weak private var logInButton: UIButton!
    @IBOutlet weak private var repeatPasswordContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak private var recoverPasswordButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        localizeSetup()
        interfaceSetup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    @IBAction private func logInButtonPressed(_ sender: UIButton) {
        guard let password = passwordTextField.text else {
            return
        }
        if PasswordManager.shared.isFirstAutorization() {
            if password.isEmpty {
                createAlert(localized("emptyPassword"))
                passwordTextField.becomeFirstResponder()
            } else {
                let spaces = password.first(where: {$0 == " "})
                if spaces == " " {
                    createAlert(localized("spacesPassword"))
                    passwordTextField.becomeFirstResponder()
                } else {
                    if password == repeatPasswordTextField.text {
                        PasswordManager.shared.savePassword(password)
                        createViewController(String(describing: GalleryViewController.self))
                    } else {
                        createAlert(localized("repeatPassword"))
                        repeatPasswordTextField.becomeFirstResponder()
                    }
                }
            }
        } else {
            if PasswordManager.shared.validatePassword(password) {
                createViewController(String(describing: GalleryViewController.self))
            } else {
                createAlert(localized("incorrectPassword"))
                passwordTextField.becomeFirstResponder()
            }
        }
    }

    @IBAction private func recoverPasswordButtonPressed(_ sender: UIButton) {
        createActionAlert(localized("removedPassword")) {
            PasswordManager.shared.removePassword()
            self.localizeSetup()
            self.interfaceSetup()
        }
    }

    @IBAction private func securePasswordButtonPressed(_ sender: UIButton) {
        showOrHidenText(sender, passwordTextField)
    }

    @IBAction private func secureRepeatPasswordButtonPressed(_ sender: UIButton) {
        showOrHidenText(sender, repeatPasswordTextField)
    }

    private func showOrHidenText(_ sender: UIButton, _ textField: UITextField) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            textField.isSecureTextEntry = false
            sender.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            textField.isSecureTextEntry = true
            sender.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }
    private func interfaceSetup() {
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        passwordTextField.returnKeyType = .continue
        repeatPasswordTextField.isSecureTextEntry = true
        repeatPasswordTextField.returnKeyType = .continue
        if PasswordManager.shared.isFirstAutorization() {
            repeatPasswordContainerHeightConstraint.constant = 34
            recoverPasswordButton.isHidden = true
        } else {
            repeatPasswordContainerHeightConstraint.constant = 0
            recoverPasswordButton.isHidden = false
        }
    }

    private func localizeSetup() {
        repeatPasswordTextField.placeholder = localized("repeatPassword")
        taglineLabel.text = localized("tagline")
        if PasswordManager.shared.isFirstAutorization() {
            passwordTextField.placeholder = localized("enterNewPassword")
            logInButton.setTitle(localized("create"), for: .normal)
        } else {
            passwordTextField.placeholder = localized("enterPassword")
            recoverPasswordButton.setTitle(localized("recover"), for: .normal)
            logInButton.setTitle(localized("logIn"), for: .normal)
        }
    }
}
