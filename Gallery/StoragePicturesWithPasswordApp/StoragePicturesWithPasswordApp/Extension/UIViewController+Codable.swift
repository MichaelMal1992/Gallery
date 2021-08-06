//
//  UIViewController+Codable.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 7.07.21.
//

import UIKit

extension UIViewController {

    func encoding(_ with: [Image]) -> Data {
        guard let data = try? JSONEncoder().encode(with) else { return Data() }
        return data
    }

    func decoding(_ with: Data) -> [Image] {
        guard let image = try? JSONDecoder().decode([Image].self, from: with) else { return [Image()]}
        return image
    }
}
