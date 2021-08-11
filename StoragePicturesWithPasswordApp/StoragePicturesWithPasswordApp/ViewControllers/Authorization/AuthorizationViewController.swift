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
        if PasswordManager.shared.firstAutorization {
            if password.isEmpty {
                createAlert("emptyPassword".localized)
                passwordTextField.becomeFirstResponder()
            } else {
                let spaces = password.first(where: {$0 == " "})
                if spaces == " " {
                    createAlert("spacesPassword".localized)
                    passwordTextField.becomeFirstResponder()
                } else {
                    if password == repeatPasswordTextField.text {
                        PasswordManager.shared.save(password)
                        createViewController(String(describing: GalleryViewController.self))
                    } else {
                        createAlert("repeatPassword".localized)
                        repeatPasswordTextField.becomeFirstResponder()
                    }
                }
            }
        } else {
            if PasswordManager.shared.validate(password) {
                createViewController(String(describing: GalleryViewController.self))
            } else {
                createAlert("incorrectPassword".localized)
                passwordTextField.becomeFirstResponder()
            }
        }
    }

    @IBAction private func recoverPasswordButtonPressed(_ sender: UIButton) {
        createActionAlert("removedPassword".localized) {
            PasswordManager.shared.remove()
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
        if PasswordManager.shared.firstAutorization {
            repeatPasswordContainerHeightConstraint.constant = 34
            recoverPasswordButton.isHidden = true
        } else {
            repeatPasswordContainerHeightConstraint.constant = 0
            recoverPasswordButton.isHidden = false
        }
    }

    private func localizeSetup() {
        repeatPasswordTextField.placeholder = "repeatPassword".localized
        taglineLabel.text = "tagline".localized
        if PasswordManager.shared.firstAutorization {
            passwordTextField.placeholder = "enterNewPassword".localized
            logInButton.setTitle("create".localized, for: .normal)
        } else {
            passwordTextField.placeholder = "enterPassword".localized
            recoverPasswordButton.setTitle("recover".localized, for: .normal)
            logInButton.setTitle("logIn".localized, for: .normal)
        }
    }
}
