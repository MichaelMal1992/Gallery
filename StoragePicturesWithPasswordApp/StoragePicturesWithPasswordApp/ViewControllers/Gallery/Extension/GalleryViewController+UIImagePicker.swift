//
//  UIViewController+ImagePicker.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 23.06.21.
//

import UIKit
import AVKit

extension GalleryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private func createImagePicker(sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = sourceType
        present(picker, animated: true)
        }

    func addPicture() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "camera".localized, style: .default, handler: { _ in
            if self.checkCameraPermissions() {
            self.createImagePicker(sourceType: .camera)
        } else {
            self.showErrorAlert()
        }
        }))
        alert.addAction(UIAlertAction(title: "library".localized, style: .default, handler: { _ in
            self.createImagePicker(sourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "cancel".localized, style: .cancel))
        present(alert, animated: true)
    }

    private func checkCameraPermissions() -> Bool {
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

    private func showErrorAlert() {
        let title = "error".localized
        let message = "notPermission".localized
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "continue".localized, style: .cancel))
        present(alert, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        PictureManager.shared.save(image)
        imagesCollectionView.reloadData()
        picker.dismiss(animated: true)
    }
}
