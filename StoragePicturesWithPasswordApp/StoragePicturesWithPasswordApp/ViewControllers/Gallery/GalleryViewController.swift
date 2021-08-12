//
//  GalleryViewController.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 23.06.21.
//

import UIKit

class GalleryViewController: UIViewController {

    @IBOutlet weak private var imagesCollectionView: UICollectionView!
    @IBOutlet weak private var commentsTableView: UITableView!
    @IBOutlet weak private var addCommentTextField: UITextField!
    @IBOutlet weak private var countsCommentsLabel: UILabel!
    @IBOutlet weak private var likeButton: UIButton!
    @IBOutlet weak private var containerForTabelAndTextFieldView: UIView!
    @IBOutlet weak private var cancelCommentButton: UIButton!
    @IBOutlet weak private var containerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak private var commentLabel: UILabel!
    @IBOutlet weak private var likeLabel: UILabel!
    @IBOutlet weak private var trashLabel: UILabel!
    @IBOutlet weak private var addLabel: UILabel!
    @IBOutlet weak private var settingsLabel: UILabel!
    @IBOutlet weak private var exitLabel: UILabel!
    @IBOutlet weak private var countsCommentContainerView: UIView!
    @IBOutlet weak private var containerTableBottomConstraint: NSLayoutConstraint!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        imagesCollectionView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interfaceSetup()
        localizeSetup()
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self

        let nibTable = UINib(nibName: String(describing: CommentsTableViewCell.self), bundle: nil)
        commentsTableView.register(nibTable, forCellReuseIdentifier: CommentsTableViewCell.identifier)

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

    @IBAction private func cancelCommentButtonPressed(_ sender: UIButton) {
        hidenComments()
    }

    @IBAction private func exitButonPressed(_ sender: UIButton) {
        createActionAlert("willExit".localized) {
            exit(0)
        }
    }

    @IBAction private func settingsButtonPressed(_ sender: UIButton) {
        createActionAlert("goSettings".localized) {
            self.createViewController(String(describing: SettingsViewController.self))
        }
    }

    @IBAction private func likeButtonPressed(_ sender: UIButton) {
        if PictureManager.shared.namesArray.isEmpty {
            createAlert("emptyGallery".localized)
        } else {
            if PictureManager.shared.currentName.isEmpty {
                createAlert("clickToLike".localized)
            } else {
                let array = ImageDataManager.shared.get
                if let image = array.first(where: {$0.name == PictureManager.shared.currentName}) {
                    if image.like == "heart" {
                        image.like = "heart.fill"
                        ImageDataManager.shared.set(array)
                    } else {
                        image.like = "heart"
                        ImageDataManager.shared.set(array)
                    }
                }
            }
        }
        updateLike()
    }

    @IBAction private func commentsButtonPressed(_ sender: UIButton) {
        commentsTableView.dataSource = self
        commentsTableView.delegate = self
        addCommentTextField.delegate = self
        if PictureManager.shared.namesArray.isEmpty {
            createAlert("emptyGallery".localized)
        } else {
            if PictureManager.shared.currentName.isEmpty {
                createAlert("chooseToComment".localized)
            } else {
                showComments()
                commentsTableView.reloadData()
            }
        }
    }

    @IBAction private func trashButtonPressed(_ sender: UIButton) {
        if PictureManager.shared.namesArray.isEmpty {
            createAlert("emptyGallery".localized)
        } else {
            if PictureManager.shared.currentName.isEmpty {
                createAlert("selectToDelete".localized)
            } else {
                createActionAlert("removed".localized) {
                    PictureManager.shared.remove(PictureManager.shared.currentName)
                    PictureManager.shared.selectedPicture = true
                    self.imagesCollectionView.reloadData()
                    self.updateCommentsCount()
                    self.updateLike()
                }
            }
        }
    }

    @IBAction private func addButtonPressed(_ sender: UIButton) {
        addPicture()
        PictureManager.shared.selectedIndexPath = nil
        PictureManager.shared.currentName = ""
        imagesCollectionView.scrollDirection(.vertical)
        updateCommentsCount()
        updateLike()
    }

    private func interfaceSetup() {
        containerHeightConstraint.constant = 0
        containerTableBottomConstraint.constant = 0
        cancelCommentButton.isHidden = true
        updateCommentsCount()
        updateLike()
    }

    private func localizeSetup() {
        likeLabel.text = "like".localized
        commentLabel.text = "comment".localized
        trashLabel.text = "trash".localized
        addLabel.text = "add".localized
        settingsLabel.text = "settings".localized
        exitLabel.text = "exit".localized
        cancelCommentButton.setTitle("cancel".localized, for: .normal)
        addCommentTextField.placeholder = "addComment".localized
    }

    private func showComments() {
        containerHeightConstraint.constant = view.frame.height
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.cancelCommentButton.isHidden = false
        }
    }

    private func hidenComments() {
        addCommentTextField.text?.removeAll()
        addCommentTextField.resignFirstResponder()
        containerHeightConstraint.constant = 0
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
            self.cancelCommentButton.isHidden = true
        }
    }

    func createIndexPath(_ center: CGPoint) {
        if let indexPath = imagesCollectionView.indexPathForItem(at: center) {
            let array = ImageDataManager.shared.get
            PictureManager.shared.currentName = array[indexPath.item].name
            }
    }

    func updateTableView() {
        commentsTableView.reloadData()
    }

    func updateCollectionView() {
        imagesCollectionView.reloadData()
    }

    func updateLike() {
        let array = ImageDataManager.shared.get
        if let image = array.first(where: {$0.name == PictureManager.shared.currentName}) {
            likeButton.setImage(UIImage(systemName: image.like), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }

    func updateCommentsCount() {
        let array = ImageDataManager.shared.get
        if let image = array.first(where: {$0.name == PictureManager.shared.currentName}) {
            if image.comments.text.isEmpty {
                countsCommentContainerView.isHidden = true
            } else {
                if image.comments.text.count > 99 {
                    countsCommentsLabel.text = "99+"
                    countsCommentContainerView.isHidden = false
                } else {
                    countsCommentContainerView.isHidden = false
                    countsCommentsLabel.text = "\(image.comments.text.count)"
                }
            }
        } else {
            countsCommentContainerView.isHidden = true
        }
    }

    @objc private func handleShowKeyboard(_ notification: Notification) {
        if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            containerTableBottomConstraint.constant = frame.height - 70
        }
    }

    @objc private func handleHidenKeyboard(_ notification: Notification) {
        containerTableBottomConstraint.constant = 0
    }
}
