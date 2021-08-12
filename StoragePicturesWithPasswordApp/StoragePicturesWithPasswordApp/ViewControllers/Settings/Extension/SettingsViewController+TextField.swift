//
//  SettingsViewController+TextField.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 6.07.21.
//

import UIKit

extension SettingsViewController: UITextFieldDelegate {

   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    switch textField {
    case enterCurrentPasswordTextField:
        guard let password = enterCurrentPasswordTextField.text else {
            return false
        }
        if  PasswordManager.shared.validate(password) {
            enterCurrentPasswordTextField.resignFirstResponder()
            enterNewPasswordTextField.becomeFirstResponder()
            enterNewPasswordTextField.isHidden = false
            showNewPasswordButton.isHidden = false
            return true
        } else {
            createAlert("incorrectPassword".localized)
            return true
        }
    case enterNewPasswordTextField:
        guard let newPassword = enterNewPasswordTextField.text else {
            return false
        }
        if PasswordManager.shared.validate(newPassword) == false, newPassword.isEmpty == false {
            if newPassword.first(where: {$0 == " "}) != nil {
                createAlert("spacesPassword".localized)
            } else {
                enterNewPasswordTextField.resignFirstResponder()
                repeatNewPasswordTextField.becomeFirstResponder()
                repeatNewPasswordTextField.isHidden = false
                showRepeatPasswordButton.isHidden = false
                return true
            }
        } else {
            if PasswordManager.shared.validate(newPassword) {
                createAlert("differentPassword".localized)
            }
            if newPassword.isEmpty {
                createAlert("emptyPassword".localized)
            }
        }
    case repeatNewPasswordTextField:
        if let repeatPassword = repeatNewPasswordTextField.text,
           let newPassword = enterNewPasswordTextField.text {
            if repeatPassword == newPassword, repeatPassword.isEmpty == false {
                PasswordManager.shared.save(repeatPassword)
                repeatNewPasswordTextField.resignFirstResponder()
                defaultConfigurations()
                createAlert("changedPassword".localized)
                return true
            } else {
                createAlert("repeatPassword".localized)
            }
        }
    default:
        textField.resignFirstResponder()
    }
    return false
   }

    private func defaultConfigurations() {
        enterCurrentPasswordTextField.isSecureTextEntry = true
        enterNewPasswordTextField.isSecureTextEntry = true
        repeatNewPasswordTextField.isSecureTextEntry = true
        enterCurrentPasswordTextField.text?.removeAll()
        enterNewPasswordTextField.text?.removeAll()
        repeatNewPasswordTextField.text?.removeAll()
        enterNewPasswordTextField.isHidden = true
        repeatNewPasswordTextField.isHidden = true
        showNewPasswordButton.isHidden = true
        showRepeatPasswordButton.isHidden = true
        showCurrentPasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        showNewPasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        showRepeatPasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        containerForTextFieldPasswordView.alpha = 0
        changePasswordButton.isEnabled = true
    }
}
