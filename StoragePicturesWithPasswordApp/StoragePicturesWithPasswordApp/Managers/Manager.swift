//
//  ImagesManager.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 5.07.21.
//

import Foundation
import UIKit

class Manager {

    static var shared = Manager()
    lazy var cacheFolderURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    lazy var imagesFolderURL = cacheFolderURL.appendingPathComponent("images")
    var imagesArray: [Image] = []
    var imageKey = "User_Image_Class"
    var currentImageName: String?
    var currentCountImage: Int?
    var selectedIndexPath: IndexPath?
    var ifImageAdd: Bool = false
}
