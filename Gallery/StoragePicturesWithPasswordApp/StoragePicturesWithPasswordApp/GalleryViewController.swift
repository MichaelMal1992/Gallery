//
//  GalleryViewController.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 23.06.21.
//

import UIKit

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var tappableImageView: TappableImageView!
    @IBOutlet weak var comentsTableView: UITableView!
    @IBOutlet weak var containerForTabelAndTextFieldView: UIView!
    @IBOutlet weak var addCommentTextField: UITextField!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        likeImageViewDidPressed()
        comentImageViewDidPressed()
        trashImageViewDidPressed()
        addImageViewDidPressed()
        setupCountComentsLabel()
        hideKeyboardOnTap()
        addCommentTextField.delegate = self
        comentsTableView.dataSource = self
        comentsTableView.delegate = self
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self

        let nibTable = UINib(nibName: String(describing: CommentsTableViewCell.self), bundle: nil)
        comentsTableView.register(nibTable, forCellReuseIdentifier: CommentsTableViewCell.identifier)

        let nibCollection = UINib(nibName: String(describing: ImagesCollectionViewCell.self), bundle: nil)
        imagesCollectionView.register(nibCollection, forCellWithReuseIdentifier: ImagesCollectionViewCell.identifier)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleShowKeyboard(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleHidenKeyboard(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    @IBAction func exitButonPressed(_ sender: UIButton) {
        exit(0)
    }

    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        createNewViewController(String(describing: SettingsViewController.self))
    }

    private func likeImageViewDidPressed() {
        tappableImageView.likeImageViewDidPressedHundler = {
            self.tappableImageView.animateTappablelikeImageView()
            Manager.shared.imagesArray = self.decoding(self.getDataValue())
            if Manager.shared.imagesArray.isEmpty == true {
                self.createAlertCancel(title: "The gallery is empty")
            } else {
                guard let currentName = Manager.shared.currentImageName else {
                    self.createAlertCancel(title: "Click on the photo and send like")
                    return
                }
                for array in Manager.shared.imagesArray {
                    if array.name == currentName {
                        if array.like == "heart" {
                            array.like = "heart.fill"
                            self.setDataValue(self.encoding(Manager.shared.imagesArray))
                            self.setupLikeImageView()
                            return
                        } else {
                            array.like = "heart"
                            self.setDataValue(self.encoding(Manager.shared.imagesArray))
                            self.setupLikeImageView()
                            return
                        }
                    }
                }
            }
        }
    }

    private func comentImageViewDidPressed() {
        tappableImageView.comentImageViewDidPressedHundler = {
            self.tappableImageView.animateTappableComentImageView()
            Manager.shared.imagesArray = self.decoding(self.getDataValue())
            if Manager.shared.imagesArray.isEmpty == true {
                self.createAlertCancel(title: "The gallery is empty, cannot send a comments")
            } else {
                self.comentsTableView.reloadData()
                self.setupCountComentsLabel()
                if self.tappableImageView.comentImageViewIsTapped {
                    if Manager.shared.currentImageName == nil {
                        self.createAlertCancel(title: "Choose a photo and writing a comment")
                    } else {
                        UIView.animate(withDuration: 0.5) { [self] in
                            self.containerForTabelAndTextFieldView.alpha = 1
                        }
                    }
                } else {
                    UIView.animate(withDuration: 0.5) {
                        self.containerForTabelAndTextFieldView.alpha = 0
                    }
                }
            }
        }
    }

    private func trashImageViewDidPressed() {
        tappableImageView.trashImageViewDidPressedHundler = {
            Manager.shared.imagesArray = self.decoding(self.getDataValue())
            self.tappableImageView.animateTappableTrashImageView()
            if Manager.shared.imagesArray.isEmpty == false {
                if let currentName = Manager.shared.currentImageName,
                   let currentCount = Manager.shared.currentCountImage {
                    for array in Manager.shared.imagesArray {
                        if array.name == currentName {
                            self.createAlertActionAndCancel(title: "The photo will be removed") {
                                Manager.shared.imagesArray.removeAll(where: {$0.name == currentName})
                                self.removeImageFromIndex(index: currentCount)
                                self.setDataValue(self.encoding(Manager.shared.imagesArray))
                                Manager.shared.currentImageName = nil
                                self.setupCountComentsLabel()
                                self.setupLikeImageView()
                                self.imagesCollectionView.reloadData()
                            }
                            return
                        }
                    }
                    self.createAlertCancel(title: "Select (tap) a photo to delete it")
                } else {
                    self.createAlertCancel(title: "Select (tap) a photo to delete it")
                }
            } else {
                self.createAlertCancel(title: "The gallery is empty")
            }
        }
    }

    private func addImageViewDidPressed() {
        tappableImageView.addImageViewDidPressedHundler = {
            self.tappableImageView.animateTappableAddImageView()
            self.imagePickerWithAlert()
            UIView.animate(withDuration: 0.5) {
                self.containerForTabelAndTextFieldView.alpha = 0
            }
        }
    }

    func setupLikeImageView() {
        Manager.shared.imagesArray = self.decoding(self.getDataValue())
        guard let currentName = Manager.shared.currentImageName else {
            self.tappableImageView.likeImageView.image = UIImage(systemName: "heart")
            return
        }
        for array in Manager.shared.imagesArray {
            if array.name == currentName {
                self.tappableImageView.likeImageView.image = UIImage(systemName: array.like)
                return
            } else {
                self.tappableImageView.likeImageView.image = UIImage(systemName: "heart.fill")
            }
        }
    }

    func setupCountComentsLabel() {
        tappableImageView.countComentsLabel.layer.cornerRadius = tappableImageView.countComentsLabel.frame.height / 2
        Manager.shared.imagesArray = decoding(getDataValue())
        tappableImageView.countComentsLabel.isHidden = true
        guard let currentName = Manager.shared.currentImageName else { return }
        for array in Manager.shared.imagesArray {
            if array.name == currentName {
                if array.comments.text.count > 99 {
                    tappableImageView.countComentsLabel.text = "99+"
                    tappableImageView.countComentsLabel.isHidden = false
                    return
                } else {
                    tappableImageView.countComentsLabel.text = "\(array.comments.text.count)"
                    tappableImageView.countComentsLabel.isHidden = false
                    return
                }
            } else {
                tappableImageView.countComentsLabel.text = ""
                tappableImageView.countComentsLabel.isHidden = true
            }
        }
    }

    @objc func handleShowKeyboard(_ notification: Notification) {
        if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let inset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
            comentsTableView.contentInset = inset
        }
    }

    @objc func handleHidenKeyboard(_ notification: Notification) {
            let inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            comentsTableView.contentInset = inset
    }
}
