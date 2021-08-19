//
//  UIViewController+NewViewController.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 23.06.21.
//

import UIKit

extension UIViewController {

    func createViewController(_ identifier: String) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyboard.instantiateViewController(identifier: identifier)
        navigationController?.pushViewController(newViewController, animated: true)
        navigationController?.modalPresentationStyle = .fullScreen
    }
}
