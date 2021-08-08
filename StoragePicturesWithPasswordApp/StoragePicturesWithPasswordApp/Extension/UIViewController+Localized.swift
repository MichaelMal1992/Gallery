//
//  UIViewController+Localized.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 8.08.21.
//

import UIKit

extension UIViewController {

    func localized(_ key: String) -> String {
        let localizable = NSLocalizedString(key, comment: "")
        return localizable
    }
}
