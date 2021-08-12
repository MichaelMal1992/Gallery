//
//  UIViewController+Alert.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 23.06.21.
//

import UIKit

extension UIViewController {

    func createAlert(_ title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "close".localized, style: .cancel))
        present(alert, animated: true)
    }

    func createActionAlert(_ title: String, _ completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "cancel".localized, style: .cancel))
        alert.addAction(UIAlertAction(title: "continue".localized, style: .default, handler: { _ in
            completion()
        }))
        present(alert, animated: true)
    }

    func createChangeCommentAllert(_ tableView: UITableView,
                                   changeCompletion: @escaping () -> Void,
                                   deleteCompletion: @escaping () -> Void) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "cancel".localized, style: .cancel, handler: { _ in
            tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "change".localized, style: .default, handler: { _ in
            changeCompletion()
        }))
        alert.addAction(UIAlertAction(title: "delete".localized, style: .default, handler: { _ in
            deleteCompletion()
        }))
        present(alert, animated: true)
    }
}
