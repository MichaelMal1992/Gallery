//
//  UIViewController+ImagePicker.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 23.06.21.
//

import UIKit
import AVKit

extension GalleryViewController {

    func imagePickerWithAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: localized("camera"), style: .default, handler: { _ in
            if self.checkCameraPermissions() {
            self.createImagePicker(sourceType: .camera)
        } else {
            self.showErrorAlert()
        }
        }))
        alert.addAction(UIAlertAction(title: localized("library"), style: .default, handler: { _ in
            self.createImagePicker(sourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: localized("cancel"), style: .cancel))
        present(alert, animated: true)
    }

    func checkCameraPermissions() -> Bool {
        #if targetEnvironment(simulator)
        return false
        #else
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined, .authorized:
            return true
        default:
            return false
        }
        #endif
    }

    func showErrorAlert() {
        let title = localized("error")
        let message = localized("notPermission")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }

}
extension GalleryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func createImagePicker(sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = sourceType
        present(picker, animated: true)
        }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        saveImageToFolder(image: image)
        guard let lastName = getImagesStringArray().last else { return }
        Manager.shared.imagesArray = decoding(getDataValue())
        let newImage = Image()
        newImage.name = lastName
        newImage.time = getCurrentDate()
        Manager.shared.imagesArray.append(newImage)
        setDataValue(encoding(Manager.shared.imagesArray))
        Manager.shared.ifImageAdd = true
        imagesCollectionView.reloadData()
        picker.dismiss(animated: true)
    }

    func getImagesStringArray() -> [String] {
        var sortedStringArray: [String] = []
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: Manager.shared.imagesFolderURL.path) {
            do {
                let imageNames = try fileManager.contentsOfDirectory(atPath: Manager.shared.imagesFolderURL.path)
                let sortedImagesNames = imageNames.sorted()
                sortedStringArray = sortedImagesNames
            } catch {
                print(error.localizedDescription)
            }
        }
        return sortedStringArray
    }

    func getLastImage() -> UIImage? {
        if FileManager.default.fileExists(atPath: Manager.shared.imagesFolderURL.path) {
            do {
                guard let lastImageName = getImagesStringArray().last else { return nil}
                let imageURL = Manager.shared.imagesFolderURL.appendingPathComponent(lastImageName)
                    let imageData = try Data(contentsOf: imageURL)
                    let image = UIImage(data: imageData)
                    return image
            } catch {
                print(error.localizedDescription)
                return nil
            }
        }
        return nil
    }

    func getImageFromIndex(index: Int) -> UIImage? {
        if FileManager.default.fileExists(atPath: Manager.shared.imagesFolderURL.path) {
            do {
                if index >= 0 && index < getImagesStringArray().count {
                    let imageName = getImagesStringArray()[index]
                    let imageURL = Manager.shared.imagesFolderURL.appendingPathComponent(imageName)
                    let imageData = try Data(contentsOf: imageURL)
                    let image = UIImage(data: imageData)
                    return image
                } else {
                    return nil
                }
            } catch {
                print(error.localizedDescription)
                return nil
            }
        }
        return nil
    }

    func removeLastImage() {
        if FileManager.default.fileExists(atPath: Manager.shared.imagesFolderURL.path) {
            do {
                let sortedImagesNames = getImagesStringArray()
                guard let lastImageName = sortedImagesNames.last else { return }
                let imageURL = Manager.shared.imagesFolderURL.appendingPathComponent(lastImageName)
                try FileManager.default.removeItem(atPath: imageURL.path)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func removeImageFromIndex(index: Int) {
        if FileManager.default.fileExists(atPath: Manager.shared.imagesFolderURL.path) {
            do {
                if index >= 0 && index < getImagesStringArray().count {
                    let imageName = getImagesStringArray()[index]
                    let imageURL = Manager.shared.imagesFolderURL.appendingPathComponent(imageName)
                    try FileManager.default.removeItem(atPath: imageURL.path)
                } else {
                    return
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func saveImageToFolder(image: UIImage?) {
        guard let image = image else {
            return
        }
        let imageData = image.pngData()
        let fileManager = FileManager.default
        let url = Manager.shared.imagesFolderURL
        if FileManager.default.fileExists(atPath: url.path) == false {
            try? fileManager.createDirectory(atPath: url.path, withIntermediateDirectories: true, attributes: [:])
        }
        let imageURL = url.appendingPathComponent("\(Int(Date().timeIntervalSince1970)).png")
        fileManager.createFile(atPath: imageURL.path, contents: imageData, attributes: [:])
    }
}
