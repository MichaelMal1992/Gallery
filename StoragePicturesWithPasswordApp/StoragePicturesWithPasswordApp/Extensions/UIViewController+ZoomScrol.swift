//
//  UIViewController+ZoomScrol.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 5.07.21.
//

import UIKit

extension GalleryViewController: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return containerView
    }
}
