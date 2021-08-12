//
//  CommentManager.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 10.08.21.
//

import UIKit

class CommentManager {

    static let shared = CommentManager()

    func saveComment(_ textField: UITextField,
                     emptyGalleryCompletion: @escaping() -> Void,
                     spacesCommentCompletion: @escaping() -> Void,
                     emptyCommentCompletion: @escaping() -> Void) -> Bool {
        let array = ImageDataManager.shared.get
        guard let text = textField.text else {
            return false
        }
        if text.isEmpty == false {
            let filter = text.filter {$0 == " "}
            if filter != text {
                if array.isEmpty == false {
                    guard let image = array.first(where: {$0.name == PictureManager.shared.currentName}) else {
                        return false
                    }
                    image.comments.text.append(text)
                    image.comments.time.append(Date().current)
                    ImageDataManager.shared.set(array)
                    textField.text?.removeAll()
                    return true
                } else {
                    textField.resignFirstResponder()
                    textField.text?.removeAll()
                    emptyGalleryCompletion()
                    return false
                }
            } else {
                textField.text?.removeAll()
                spacesCommentCompletion()
                return false
            }
        } else {
            emptyCommentCompletion()
            return false
        }
    }
}
