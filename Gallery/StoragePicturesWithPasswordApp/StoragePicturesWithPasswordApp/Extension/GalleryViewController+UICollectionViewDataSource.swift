//
//  GalleryViewController+UICollectionViewDataSource.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 7.07.21.
//

import UIKit

extension GalleryViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let array = getArrayImages() else {
            return 0
        }
        return array.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = ImagesCollectionViewCell.identifier
        let dequeue = imagesCollectionView.dequeueReusableCell
        guard let cell = dequeue(identifier, indexPath) as? ImagesCollectionViewCell else {
            return UICollectionViewCell()
        }
        for image in Manager.shared.imagesArray {
            if image.name == getImagesStringArray()[indexPath.item] {
                cell.labelCollectionViewCellLabel.text = image.time
            }
        }

        if let array = getArrayImages() {
            cell.imageCollectionViewCellImageView.image = array[indexPath.item]

        }
        return cell
    }
}

extension GalleryViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if Manager.shared.selectedIndexPath == nil {
            Manager.shared.selectedIndexPath = indexPath
            if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.scrollDirection = .horizontal
                collectionView.isPagingEnabled = true
                collectionView.maximumZoomScale = 3
                collectionView.isScrollEnabled = true
                Manager.shared.currentImageName = getImagesStringArray()[indexPath.item]
                Manager.shared.currentCountImage = indexPath.item
            }
        } else {
            if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.scrollDirection = .vertical
                collectionView.isPagingEnabled = false
                collectionView.maximumZoomScale = 1
                Manager.shared.currentImageName = nil
                Manager.shared.currentCountImage = nil
            }
            Manager.shared.selectedIndexPath = nil
        }
        setupCountComentsLabel()
        setupLikeImageView()
        collectionView.reloadData()
        collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: false)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2),
                             y: (scrollView.frame.height / 2))
        if let indexPath = imagesCollectionView.indexPathForItem(at: center) {
                let index = indexPath.row
            Manager.shared.currentImageName = getImagesStringArray()[index]
            Manager.shared.currentCountImage = index
            setupCountComentsLabel()
            setupLikeImageView()
            }
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellSize: CGSize {
            var minimumLineSpacing: CGFloat = 0
            if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                minimumLineSpacing = flowLayout.minimumLineSpacing
            }
            let width = (collectionView.frame.width - minimumLineSpacing) / 2
            return CGSize(width: width, height: width)
        }
        if Manager.shared.selectedIndexPath != nil {
            return collectionView.frame.size
        } else {
            return cellSize
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if Manager.shared.selectedIndexPath == nil {
            return 0
        } else {
            return 0
        }
    }
}
