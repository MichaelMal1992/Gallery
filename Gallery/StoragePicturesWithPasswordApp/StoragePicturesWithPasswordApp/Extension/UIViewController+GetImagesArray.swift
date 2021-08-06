//
//  UIViewController+SaveImagesArray.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 5.07.21.
//

import UIKit

extension UIViewController {

    func getArrayImages() -> [UIImage]? {
        var imagesArray: [UIImage] = []
        if Manager.shared.fileManager.fileExists(atPath: Manager.shared.imagesFolderURL.path) {
            do {
                let url = Manager.shared.imagesFolderURL
                let fileManager = Manager.shared.fileManager
                let sortedImagesNames = try fileManager.contentsOfDirectory(atPath: url.path).sorted()
                for imageName in sortedImagesNames {
                    let imageURL = url.appendingPathComponent(imageName)
                        let imageData = try Data(contentsOf: imageURL)
                        let image = UIImage(data: imageData)
                    if let newImage = image {
                        imagesArray.append(newImage)
                    }
                }
            } catch {
                print(error.localizedDescription)
                return nil
            }
        } else {
            return nil
        }
        return imagesArray
    }
}
