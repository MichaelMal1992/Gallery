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
            enterNewPasswordTextField.becomeFirstResponder()
            return true
        case enterNewPasswordTextField:
            repeatNewPasswordTextField.becomeFirstResponder()
            return true
        case repeatNewPasswordTextField:
            repeatNewPasswordTextField.resignFirstResponder()
            return true
        default:
            return false
        }
    }

    func validateCurrentPassword() -> Bool {
        if let password = enterCurrentPasswordTextField.text {
            if PasswordManager.shared.validate(password) {
                enterNewPasswordTextField.becomeFirstResponder()
                return true
            } else {
                createAlert("incorrectPassword".localized)
                enterCurrentPasswordTextField.becomeFirstResponder()
                return false
            }
        }
        return false
    }

    func validateNewPassword() -> Bool {
        if let newPassword = enterNewPasswordTextField.text,
           let password = enterCurrentPasswordTextField.text {
            if newPassword.isEmpty {
                createAlert("emptyPassword".localized)
                enterCurrentPasswordTextField.becomeFirstResponder()
                return false
            } else {
                let spaces = newPassword.first(where: {$0 == " "})
                if spaces == " " {
                    createAlert("spacesPassword".localized)
                    enterCurrentPasswordTextField.becomeFirstResponder()
                    return false
                } else {
                    if newPassword == password {
                        createAlert("differentPassword".localized)
                        return false
                    } else {
                        repeatNewPasswordTextField.becomeFirstResponder()
                        return true
                    }
                }
            }
        }
        return false
    }

    func validateRepeatPassword() -> Bool {
        if let repeatPassword = repeatNewPasswordTextField.text,
           let newPassword = enterNewPasswordTextField.text {
            if repeatPassword == newPassword {
                repeatNewPasswordTextField.resignFirstResponder()
                return true
            } else {
                createAlert("repeatPassword".localized)
                repeatNewPasswordTextField.becomeFirstResponder()
                return false
            }
        }
        return false
    }
}
