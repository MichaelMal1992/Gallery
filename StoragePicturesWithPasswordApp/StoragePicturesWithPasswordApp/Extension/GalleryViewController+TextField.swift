//
//  GalleryViewController+TextField.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 6.07.21.
//

import Foundation
import UIKit

extension GalleryViewController: UITextFieldDelegate {

    func saveComents(_ textField: UITextField) {
        Manager.shared.imagesArray = decoding(getDataValue())
        guard let text = textField.text else { return }
        if text.isEmpty == false {
            let filter = text.filter { $0 == " "}
            if filter != text {
                if Manager.shared.imagesArray.isEmpty == false {
                    for array in Manager.shared.imagesArray {
                        guard let currentName = Manager.shared.currentImageName else { return }
                        if array.name ==  currentName {
                            array.comments.text.append(text)
                            array.comments.time.append(getCurrentDate())
                            setDataValue(encoding(Manager.shared.imagesArray))
                            comentsTableView.reloadData()
                            textField.text?.removeAll()
                            return
                        }
                    }
                } else {
                    addCommentTextField.resignFirstResponder()
                    textField.text?.removeAll()
                    createAlertCancel(title: "The gallery is empty")
                }
            } else {
                textField.text?.removeAll()
                createAlertCancel(title: "A comment cannot be only from a spaces")
            }
        } else {
            createAlertCancel(title: "A comment cannot be empty")
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case addCommentTextField:
            saveComents(addCommentTextField)
            setupCountComentsLabel()
            addCommentTextField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
