//
//  TappableImage.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 4.07.21.
//

import UIKit

@IBDesignable
class TappableImageView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var comentImageView: UIImageView!
    @IBOutlet weak var trashImageView: UIImageView!
    @IBOutlet weak var addImageView: UIImageView!
    @IBOutlet weak var countComentsLabel: UILabel!

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    @IBInspectable var borderColor: UIColor {
        get {
            if let cgColor = layer.borderColor {
                return UIColor(cgColor: cgColor)
            }
            return .black
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }

    var likeImageViewIsTapped: Bool = false
    var comentImageViewIsTapped: Bool = false
    var trashImageViewIsTapped: Bool = false
    var addImageViewIsTapped: Bool = false
    var likeImageViewDidPressedHundler: (() -> Void)?
    var comentImageViewDidPressedHundler: (() -> Void)?
    var trashImageViewDidPressedHundler: (() -> Void)?
    var addImageViewDidPressedHundler: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        let bundle = Bundle(for: TappableImageView.self)
        bundle.loadNibNamed(String(describing: TappableImageView.self), owner: self, options: nil)
        #if TARGET_INTERFACE_BUILDER
        contentView.frame = self.bounds
        self.addSubview(contentView)
        self.layer.masksToBounds = true
        #else
        contentView.fixInContainer(self)
        countComentsLabel.layer.masksToBounds = true
        #endif
        setupTapGestureForImageView(likeImageView, #selector(handleTapForLikeImageView(_:)))
        setupTapGestureForImageView(comentImageView, #selector(handleTapForComentImageView(_:)))
        setupTapGestureForImageView(trashImageView, #selector(handleTapForTrashImageView(_:)))
        setupTapGestureForImageView(addImageView, #selector(handleTapForAddImageView(_:)))
    }

    @objc func handleTapForLikeImageView(_ sender: UITapGestureRecognizer) {
        likeImageViewDidPressedHundler?()
    }

    @objc func handleTapForComentImageView(_ sender: UITapGestureRecognizer) {
        comentImageViewDidPressedHundler?()
    }

    @objc func handleTapForTrashImageView(_ sender: UITapGestureRecognizer) {
        trashImageViewDidPressedHundler?()
    }

    @objc func handleTapForAddImageView(_ sender: UITapGestureRecognizer) {
        addImageViewDidPressedHundler?()
    }

    private func setupTapGestureForImageView(_ imageView: UIImageView, _ selector: Selector) {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: selector)
        imageView.addGestureRecognizer(tapGesture)
    }

    func animateTappablelikeImageView() {
        self.likeImageViewIsTapped = !self.likeImageViewIsTapped
            UIView.animate(withDuration: 0.1) {
                self.likeImageView.alpha = 0
            } completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.likeImageView.alpha = 1
                }
            }
    }

    func animateTappableComentImageView() {
        self.comentImageViewIsTapped = !self.comentImageViewIsTapped
            UIView.animate(withDuration: 0.1) {
                self.comentImageView.alpha = 0
            } completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.comentImageView.alpha = 1
                }
            }
    }

    func animateTappableTrashImageView() {
        self.trashImageViewIsTapped = !self.trashImageViewIsTapped
            UIView.animate(withDuration: 0.1) {
                self.trashImageView.alpha = 0
            } completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.trashImageView.alpha = 1
                }
            }
    }

    func animateTappableAddImageView() {
        self.trashImageViewIsTapped = !self.trashImageViewIsTapped
            UIView.animate(withDuration: 0.1) {
                self.addImageView.alpha = 0
            } completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.addImageView.alpha = 1
                }
            }
    }
}
