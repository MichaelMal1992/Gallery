//
//  GalleryViewController+UICollectionViewDataSource.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 7.07.21.
//

import UIKit
extension GalleryViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let array = ImageDataManager.shared.get
        return array.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = ImagesCollectionViewCell.identifier
        let dequeue = collectionView.dequeueReusableCell
        guard let cell = dequeue(identifier, indexPath) as? ImagesCollectionViewCell else {
            return UICollectionViewCell()
        }
        let array = ImageDataManager.shared.get
        let image = array[indexPath.item]
        cell.collectionViewCellLabel.text = image.time
        cell.collectionViewCellImageView.image = PictureManager.shared.getImage(image.name)
        if PictureManager.shared.selectedPicture == true {
            PictureManager.shared.selectedPicture = nil
            PictureManager.shared.currentName = array[indexPath.item].name
            updateCommentsCount()
            updateLike()
        }
        return cell
    }
}

extension GalleryViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if PictureManager.shared.selectedIndexPath == nil {
            let array = ImageDataManager.shared.get
            PictureManager.shared.selectedIndexPath = indexPath
            PictureManager.shared.selectedPicture = true
            collectionView.scrollDirection(.gorizontal)
            PictureManager.shared.currentName = array[indexPath.item].name
        } else {
            PictureManager.shared.selectedIndexPath = nil
            PictureManager.shared.selectedPicture = nil
            collectionView.scrollDirection(.vertical)
            PictureManager.shared.currentName = ""
        }
        collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: false)
        updateCommentsCount()
        updateLike()
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.alwaysBounceVertical {
            return
        } else {
            let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2),
                                 y: 0)
            createIndexPath(center)
            updateCommentsCount()
            updateLike()
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
        if PictureManager.shared.selectedIndexPath != nil {
            return collectionView.frame.size
        } else {
            return cellSize
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
