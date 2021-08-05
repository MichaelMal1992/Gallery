//
//  UIViewController+Date.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 7.07.21.
//

import UIKit

extension UIViewController {

    func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale(identifier: "ru")
        let date = dateFormatter.string(from: Date())
        return date
    }
}
