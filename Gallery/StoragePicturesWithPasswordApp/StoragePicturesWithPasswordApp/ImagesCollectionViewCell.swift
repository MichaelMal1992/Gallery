//
//  ImagesCollectionViewCell.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 7.07.21.
//

import UIKit

class ImagesCollectionViewCell: UICollectionViewCell {

    static var identifier = String(describing: ImagesCollectionViewCell.self)
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageCollectionViewCellImageView: UIImageView!
    @IBOutlet weak var labelCollectionViewCellLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
