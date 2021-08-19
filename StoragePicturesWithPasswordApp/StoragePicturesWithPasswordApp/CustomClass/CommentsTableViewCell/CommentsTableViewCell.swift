//
//  CommentsTableViewCell.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 6.07.21.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {

    static var identifier = "CommentsTableViewCell"
    @IBOutlet weak var commentContainerView: UIView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
}
