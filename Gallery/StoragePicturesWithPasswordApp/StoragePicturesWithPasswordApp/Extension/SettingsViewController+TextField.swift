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
        if enterNewPasswordTextField.text != PasswordManager.shared.password, enterNewPasswordTextField.text?.isEmpty == false {
            for textPassword in enterNewPasswordTextField.text ?? "" {
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
        if repeatNewPasswordTextField.text == enterNewPasswordTextField.text, repeatNewPasswordTextField.text?.isEmpty == false {
            UserDefaults.standard.setValue(repeatNewPasswordTextField.text ?? "", forKey: PasswordManager.shared.keyToPassword)
            PasswordManager.shared.password = UserDefaults.standard.value(forKey: PasswordManager.shared.keyToPassword) as? String ?? ""
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
