//
//  Comments.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 6.07.21.
//

import UIKit

class Image: Codable {
    var comments = Comment()
    var name = ""
    var like = "heart"
    var time = ""

}

class Comment: Codable {
    var text: [String] = []
    var time: [String] = []
}
