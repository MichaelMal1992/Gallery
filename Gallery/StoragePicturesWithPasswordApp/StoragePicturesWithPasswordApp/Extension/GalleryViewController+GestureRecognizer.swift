//
//  UIViewController+GestureRecognizer.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 8.07.21.
//

import UIKit

extension GalleryViewController: UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }

    @objc func handletapGestureRecognizer(_ sender: UITapGestureRecognizer) {
        addCommentTextField.resignFirstResponder()
    }

    func hideKeyboardOnTap() {
        let tapper = UITapGestureRecognizer(target: self, action: #selector(handletapGestureRecognizer(_:)))
        tapper.delegate = self
        tapper.cancelsTouchesInView = false
        comentsTableView.addGestureRecognizer(tapper)
    }
}
