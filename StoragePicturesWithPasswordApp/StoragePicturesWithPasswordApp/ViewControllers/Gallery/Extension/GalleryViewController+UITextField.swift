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

        if CommentManager.shared.saveComment(textField,
                                             emptyGalleryCompletion: {
            self.createAlert("emptyGallery".localized)
        },
                                             spacesCommentCompletion: {
            self.createAlert("spacesComment".localized)
        },
                                             emptyCommentCompletion: {
            self.createAlert("emptyComment".localized)
        }) {
            updateTableView()
            updateCommentsCount()
            textField.resignFirstResponder()
            return true
        } else {
            return false
        }
    }
}
