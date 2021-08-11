//
//  DataManager.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 10.08.21.
//

import Foundation

class ImageDataManager {

    static let shared = ImageDataManager()

    var get: [Image] {
        var array: [Image] = []
        if let data = UserDefaults.standard.value(forKey: "User_Image") as? Data {
            do {
                array = try JSONDecoder().decode([Image].self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
        return array
    }

    func set(_ array: [Image]) {
        do {
            let data = try JSONEncoder().encode(array)
            UserDefaults.standard.setValue(data, forKey: "User_Image")
        } catch {
            print(error.localizedDescription)
        }
    }
}
