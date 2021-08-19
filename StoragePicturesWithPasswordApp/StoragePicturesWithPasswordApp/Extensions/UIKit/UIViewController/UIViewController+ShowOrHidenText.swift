//
//  UIViewController+ShowOrHidenText.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 13.08.21.
//

import UIKit

extension UIViewController {

    func showOrHidenText(_ sender: UIButton, _ textField: UITextField) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            textField.isSecureTextEntry = false
            sender.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            textField.isSecureTextEntry = true
            sender.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }
}
