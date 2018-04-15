//
//  CustomAnimationViewController.swift
//  ios-gemini-demo
//
//  Created by OkuderaYuki on 2018/04/15.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import Gemini
import UIKit

enum CustomAnimationType {
    case custom1
    case custom2

    func layout(parentView: UIView) -> UICollectionViewFlowLayout {
        switch self {
        case .custom1:
            let layout = UICollectionViewPagingFlowLayout()
            layout.itemSize = CGSize(width: parentView.bounds.width - 100,
                                     height: parentView.bounds.height - 200)
            layout.sectionInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
            layout.minimumLineSpacing = 10
            layout.scrollDirection = .horizontal
            return layout
        case .custom2:
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 150, height: 150)
            layout.sectionInset = UIEdgeInsets(top: 15,
                                               left: (parentView.bounds.width - 150) / 2,
                                               bottom: 15,
                                               right: (parentView.bounds.width - 150) / 2)
            layout.minimumLineSpacing = 15
            layout.scrollDirection = .vertical
            return layout
        }
    }
}

final class CustomAnimationViewController: UIViewController {

    // MARK: - properties

    @IBOutlet weak var collectionView: GeminiCollectionView! {
        didSet {
            let nib = UINib(nibName: PhotoCell.identifier, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: PhotoCell.identifier)
        }
    }

    private let images = Resource.images

    private var animationType = CustomAnimationType.custom2

    // MARK: - factory

    static func make(animationType: CustomAnimationType) -> CustomAnimationViewController {
        let storyboardName = "CustomAnimationViewController"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! CustomAnimationViewController
        viewController.animationType = animationType
        return viewController
    }

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    // MARK: - private methods

    private func setup() {

        if animationType == .custom1 {
            collectionView.collectionViewLayout = animationType.layout(parentView: view)
            collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        } else {
            collectionView.collectionViewLayout = animationType.layout(parentView: view)
        }

        if animationType == .custom1 {
            collectionView.gemini
                .customAnimation()
                .translation(y: 50)
                .rotationAngle(y: 13)
                .ease(.easeOutExpo)
                .shadowEffect(.fadeIn)
                .maxShadowAlpha(0.3)
        } else {
            collectionView.gemini
                .customAnimation()
                .backgroundColor(startColor: UIColor(red: 38 / 255, green: 194 / 255, blue: 129 / 255, alpha: 1),
                                 endColor: UIColor(red: 89 / 255, green: 171 / 255, blue: 227 / 255, alpha: 1))
                .ease(.easeOutSine)
                .cornerRadius(75)
        }

        var title = ""
        switch (animationType) {
        case (.custom1):
            title = "Custom animation1"
        case (.custom2):
            title = "Custom animation2"
        }
        navigationItem.title = title
    }
}

extension CustomAnimationViewController: UICollectionViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.animateVisibleCells()
    }

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if let cell = cell as? GeminiCell {
            self.collectionView.animateCell(cell)
        }
    }
}

extension CustomAnimationViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoCell.identifier,
            for: indexPath) as! PhotoCell
        
        // Set image only when animation type is custom1
        if animationType == .custom1 {
            cell.imageView.image = images[indexPath.row]
        }

        self.collectionView.animateCell(cell)
        return cell
    }
}
