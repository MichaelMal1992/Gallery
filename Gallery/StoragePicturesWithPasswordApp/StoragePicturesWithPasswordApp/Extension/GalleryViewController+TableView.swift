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

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            return UIView()
        }
}

extension GalleryViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Manager.shared.imagesArray = decoding(getDataValue())
            if Manager.shared.imagesArray.isEmpty == false {
                for array in Manager.shared.imagesArray {
                    guard let currentName = Manager.shared.currentImageName else { return 0 }
                    if array.name == currentName, array.comments.text.isEmpty == false {
                        return array.comments.text.count
                    }
                }
            } else {
                return 0
            }
        return 0
    }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let identidier = CommentsTableViewCell.identifier
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identidier) as? CommentsTableViewCell else {
                return UITableViewCell()
            }
            Manager.shared.imagesArray = decoding(getDataValue())
            if Manager.shared.imagesArray.isEmpty == false {
                for array in Manager.shared.imagesArray {
                    guard let currentName = Manager.shared.currentImageName else { return cell }
                    if array.name == currentName, array.comments.text.isEmpty == false {
                        cell.commentLabel.text = array.comments.text[indexPath.row]
                        cell.timeLabel.text = array.comments.time[indexPath.row]
                        return cell
                    }
                }
            } else {
                return cell
            }
            return cell
        }
}
