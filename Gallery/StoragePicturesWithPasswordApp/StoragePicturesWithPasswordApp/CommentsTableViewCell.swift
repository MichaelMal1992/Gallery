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

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
