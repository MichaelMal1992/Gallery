//
//  UICollectionView+ScrollDirection.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 10.08.21.
//

import UIKit

extension UICollectionView {

    func scrollDirection(_ direction: Direction) {
        if let flowLayout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            switch direction {
            case .gorizontal:
                flowLayout.scrollDirection = .horizontal
                self.isPagingEnabled = true
            case .vertical:
                flowLayout.scrollDirection = .vertical
                self.isPagingEnabled = false
            }
        }
    }
}
