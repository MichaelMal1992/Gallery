//
//  AuthorizationViewController+TextFieldDelegate.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 8.08.21.
//

import UIKit

extension AuthorizationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
