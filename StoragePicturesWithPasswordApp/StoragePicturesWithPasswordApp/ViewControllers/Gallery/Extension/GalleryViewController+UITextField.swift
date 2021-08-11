//
//  GalleryViewController+TextField.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 6.07.21.
//

import Foundation
import UIKit

extension GalleryViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case addCommentTextField:
            saveComents(addCommentTextField)
            commentsTableView.reloadData()
            updateCount()
            addCommentTextField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }

    private func saveComents(_ textField: UITextField) {
        let array = ImageDataManager.shared.get
        guard let text = textField.text else {
            return
        }
        if text.isEmpty == false {
            let filter = text.filter {$0 == " "}
            if filter != text {
                if array.isEmpty == false {
                    guard let image = array.first(where: {$0.name == PictureManager.shared.currentName}) else {
                        return
                    }
                    image.comments.text.append(text)
                    image.comments.time.append(Date().current)
                    ImageDataManager.shared.set(array)
                    textField.text?.removeAll()
                } else {
                    addCommentTextField.resignFirstResponder()
                    textField.text?.removeAll()
                    createAlert("emptyGallery".localized)
                }
            } else {
                textField.text?.removeAll()
                createAlert("spacesComment".localized)
            }
        } else {
            createAlert("emptyComment".localized)
        }
    }
}
