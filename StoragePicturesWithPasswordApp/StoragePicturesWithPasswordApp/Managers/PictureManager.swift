//
//  PictureManager.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 9.08.21.
//

import UIKit

class PictureManager {

    static let shared = PictureManager()
    var currentName = ""
    var selectedIndexPath: IndexPath?
    var selectedPicture: Bool?
    private let fileManager = FileManager.default
    private lazy var cacheFolderURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    private lazy var imagesFolderURL = cacheFolderURL.appendingPathComponent("images")

    func remove(_ name: String?) {
        guard let name = name else {
            return
        }
        if fileManager.fileExists(atPath: imagesFolderURL.path) {
            do {
                let url = imagesFolderURL.appendingPathComponent(name)
                try fileManager.removeItem(at: url)
                var array = ImageDataManager.shared.get
                array.removeAll(where: {$0.name == name})
                ImageDataManager.shared.set(array)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func removeAll() {
        if fileManager.fileExists(atPath: imagesFolderURL.path) {
            do {
                try fileManager.removeItem(atPath: imagesFolderURL.path)
                ImageDataManager.shared.set([])
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func save(_ image: UIImage?) {
        guard let image = image else {
            return
        }
        let data = image.pngData()
        if fileManager.fileExists(atPath: imagesFolderURL.path) == false {
            do {
                try fileManager.createDirectory(atPath: imagesFolderURL.path,
                                                withIntermediateDirectories: true, attributes: [:])
            } catch {
                print(error.localizedDescription)
            }
        }
        var array = ImageDataManager.shared.get
        let imageData = Image()
        imageData.name = "\(Int(Date().timeIntervalSince1970)).png"
        imageData.time = Date().current
        array.append(imageData)
        ImageDataManager.shared.set(array)
        let imageURL =
            imagesFolderURL.appendingPathComponent(imageData.name)
        fileManager.createFile(atPath: imageURL.path, contents: data, attributes: [:])
    }

    var namesArray: [String] {
        if fileManager.fileExists(atPath: imagesFolderURL.path) {
            do {
                let names = try fileManager.contentsOfDirectory(atPath: imagesFolderURL.path)
                return names.sorted()
            } catch {
                print(error.localizedDescription)
            }
        }
        return []
    }

    func getImage(_ name: String?) -> UIImage? {
        guard let name = name else {
            return nil
        }
        if fileManager.fileExists(atPath: imagesFolderURL.path) {
            do {
                let url = imagesFolderURL.appendingPathComponent(name)
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    return image
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
