//
//  SettingsViewController+TextField.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 6.07.21.
//

import UIKit

extension SettingsViewController: UITextFieldDelegate {

//   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//    switch textField {
//    case enterCurrentPasswordTextField:
//        if enterCurrentPasswordTextField.text == PasswordManager.getPassword {
//            enterCurrentPasswordTextField.resignFirstResponder()
//            enterNewPasswordTextField.becomeFirstResponder()
//            enterNewPasswordTextField.isHidden = false
//            showNewPasswordButton.isHidden = false
//        } else {
//            createAlert(localized("incorrectPassword"))
//        }
//    case enterNewPasswordTextField:
//        let newPassword = enterNewPasswordTextField.text
//        if newPassword != PasswordManager.getPassword, newPassword?.isEmpty == false {
//            for password in newPassword ?? "" {
//                if password == " " {
//                    createAlert(localized("spacesPassword"))
//                    return false
//                } else {
//                    enterNewPasswordTextField.resignFirstResponder()
//                    repeatNewPasswordTextField.becomeFirstResponder()
//                    repeatNewPasswordTextField.isHidden = false
//                    showRepeatPasswordButton.isHidden = false
//                    return true
//                }
//            }
//        } else {
//            if enterNewPasswordTextField.text == PasswordManager.getPassword {
//                createAlert(localized("differentPassword"))
//            }
//            if enterNewPasswordTextField.text?.isEmpty == true {
//                createAlert(localized("emptyPassword"))
//            }
//        }
//    case repeatNewPasswordTextField:
//        let repeatPassword = repeatNewPasswordTextField.text
//        let newPassword = enterNewPasswordTextField.text
//        if repeatPassword == newPassword, repeatPassword?.isEmpty == false {
//            PasswordManager.setPassword(repeatPassword)
//            repeatNewPasswordTextField.resignFirstResponder()
//            defaultConfigurations()
//            createAlert(localized("changedPassword"))
//        } else {
//            createAlert(localized("repeatPassword"))
//        }
//    default:
//        textField.resignFirstResponder()
//    }
//        return true
//    }
//
//    private func defaultConfigurations() {
//        enterCurrentPasswordTextField.isSecureTextEntry = true
//        enterNewPasswordTextField.isSecureTextEntry = true
//        repeatNewPasswordTextField.isSecureTextEntry = true
//        enterCurrentPasswordTextField.text?.removeAll()
//        enterNewPasswordTextField.text?.removeAll()
//        repeatNewPasswordTextField.text?.removeAll()
//        enterNewPasswordTextField.isHidden = true
//        repeatNewPasswordTextField.isHidden = true
//        showNewPasswordButton.isHidden = true
//        showRepeatPasswordButton.isHidden = true
//        showCurrentPasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
//        showNewPasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
//        showRepeatPasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
//        containerForTextFieldPasswordView.alpha = 0
//        changePasswordButton.isEnabled = true
//    }
}
