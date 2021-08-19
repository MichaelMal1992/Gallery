//
//  Date+CurrentDate.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 10.08.21.
//

import Foundation

extension Date {

    var current: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale(identifier: "ru")
        let date = dateFormatter.string(from: Date())
        return date
    }
}
