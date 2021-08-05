//
//  UIViewController+Codable.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 6.07.21.
//

import UIKit

extension UIViewController {

    func setDataValue(_ data: Data) {
        UserDefaults.standard.setValue(data, forKey: Manager.shared.keyForImage)
    }

    func getDataValue() -> Data {
        guard let data = UserDefaults.standard.value(forKey: Manager.shared.keyForImage) as? Data else { return Data() }
        return data
    }
}
