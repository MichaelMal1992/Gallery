//
//  Comments.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 6.07.21.
//

import UIKit

class Image: Codable {
    var comments = Comment()
    var name = "no"
    var like = "heart"
    var time = "no"

}

class Comment: Codable {
    var text: [String] = []
    var time: [String] = []
}
