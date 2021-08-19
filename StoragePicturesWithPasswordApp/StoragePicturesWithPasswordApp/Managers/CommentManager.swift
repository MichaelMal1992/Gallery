//
//  CommentManager.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 10.08.21.
//

import UIKit

class CommentManager {

    static let shared = CommentManager()

    var selectedChange: Bool?
    var currentComment = "no"

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
                    if selectedChange != nil {
                        selectedChange = nil
                        for image in array {
                            if let comment = image.comments.first(where: {$0.text == currentComment}) {
                                comment.text = text
                                comment.time = "\(Date().current)\n(\("changed".localized))"
                            }
                        }
                    } else {
                        let comment = Comment()
                        comment.text = text
                        comment.time = Date().current
                        image.comments.append(comment)
                    }
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

    func deleteComment(_ text: String) {
        let array = ImageDataManager.shared.get
        for image in array {
            for _ in image.comments {
                image.comments.removeAll(where: {$0.text == text})
            }
        }
        ImageDataManager.shared.set(array)
    }
}
