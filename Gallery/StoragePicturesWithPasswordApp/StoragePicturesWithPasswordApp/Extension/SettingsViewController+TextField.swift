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
        if enterCurrentPasswordTextField.text == PasswordManager.shared.password {
            enterCurrentPasswordTextField.resignFirstResponder()
            enterNewPasswordTextField.becomeFirstResponder()
            enterNewPasswordTextField.isHidden = false
            showNewPasswordButton.isHidden = false
        } else {
            createAlertCancel(title: "The current password is incorrect")
        }
    case enterNewPasswordTextField:
        let newPassword = enterNewPasswordTextField.text
        let password = PasswordManager.shared.password
        if newPassword != password, newPassword?.isEmpty == false {
            for textPassword in newPassword ?? "" {
                if textPassword == " " {
                    createAlertCancel(title: "The new password cannot contain a spaces")
                    return false
                }
            }
            enterNewPasswordTextField.resignFirstResponder()
            repeatNewPasswordTextField.becomeFirstResponder()
            repeatNewPasswordTextField.isHidden = false
            showRepeatPasswordButton.isHidden = false
            return true
        } else {
            if enterNewPasswordTextField.text == PasswordManager.shared.password {
                createAlertCancel(title: "The new password must be different from the current password")
            }
            if enterNewPasswordTextField.text?.isEmpty == true {
                createAlertCancel(title: "The new password cannot be empty")
            }
        }
    case repeatNewPasswordTextField:
        let repeatPassword = repeatNewPasswordTextField.text
        let newPassword = enterNewPasswordTextField.text
        if repeatPassword == newPassword, repeatPassword?.isEmpty == false {
            let key = PasswordManager.shared.keyToPassword
            let userDefaults = UserDefaults.standard
            userDefaults.setValue(repeatNewPasswordTextField.text ?? "", forKey: key)
            PasswordManager.shared.password = userDefaults.value(forKey: key) as? String ?? ""
            repeatNewPasswordTextField.resignFirstResponder()
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
            createAlertCancel(title: "The password was be changed")
        } else {
            createAlertCancel(title: "Repeat the new password")
        }
    default:
        textField.resignFirstResponder()
    }
        return true
    }
}
