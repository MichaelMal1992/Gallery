//
//  GalleryViewController+TableView.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 6.07.21.
//

import UIKit

extension GalleryViewController: UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
    }
}

extension GalleryViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let images = ImageDataManager.shared.get
        if let image = images.first(where: {$0.name == PictureManager.shared.currentName}) {
            return image.comments.text.count
        }
        return 0
    }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let identidier = CommentsTableViewCell.identifier
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identidier) as? CommentsTableViewCell else {
                return UITableViewCell()
            }
            let images = ImageDataManager.shared.get
            if let image = images.first(where: {$0.name == PictureManager.shared.currentName}) {
                cell.commentLabel.text = image.comments.text[indexPath.row]
                cell.timeLabel.text = image.comments.time[indexPath.row]
            }
            return cell
        }
}
