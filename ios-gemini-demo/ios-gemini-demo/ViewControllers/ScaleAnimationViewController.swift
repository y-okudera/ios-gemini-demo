//
//  ScaleAnimationViewController.swift
//  ios-gemini-demo
//
//  Created by OkuderaYuki on 2018/04/15.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import Gemini
import UIKit

final class ScaleAnimationViewController: UIViewController {

    // MARK: - properties

    @IBOutlet private weak var collectionView: GeminiCollectionView! {
        didSet {
            let nib = UINib(nibName: PhotoCell.identifier, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: PhotoCell.identifier)
            collectionView.gemini
                .scaleAnimation()
                .scale(0.75)
                .scaleEffect(scaleEffect)
                .ease(.easeOutQuart)
        }
    }
    private let images = Resource.images
    private var scrollDirection = UICollectionViewScrollDirection.horizontal
    private var scaleEffect = GeminScaleEffect.scaleUp

    // MARK: - factory

    static func make(scrollDirection: UICollectionViewScrollDirection,
                     scaleEffect: GeminScaleEffect) -> ScaleAnimationViewController {
        let storyboardName = "ScaleAnimationViewController"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! ScaleAnimationViewController
        viewController.scrollDirection = scrollDirection
        viewController.scaleEffect = scaleEffect
        return viewController
    }

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    // MARK: - private methods

    private func setup() {

        let layout = UICollectionViewPagingFlowLayout()
        layout.scrollDirection = scrollDirection
        layout.itemSize = CGSize(width: view.bounds.width - 80, height: view.bounds.height - 400)
        layout.sectionInset = UIEdgeInsets(top: 200, left: 40, bottom: 200, right: 40)
        layout.minimumLineSpacing = 40
        layout.minimumInteritemSpacing = 40
        collectionView.collectionViewLayout = layout
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast

        var title = ""
        switch (scrollDirection, scaleEffect) {
        case (.horizontal, .scaleUp):
            title = "Horizontal scale up"
        case (.horizontal, .scaleDown):
            title = "Horizontal scale down"
        case (.vertical, .scaleUp):
            title = "Vertical scale up"
        case (.vertical, .scaleDown):
            title = "Vertical scale down"
        }
        navigationItem.title = title
    }
}

extension ScaleAnimationViewController: UICollectionViewDelegate {

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

extension ScaleAnimationViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoCell.identifier,
            for: indexPath) as! PhotoCell
        cell.imageView.image = images[indexPath.row]
        self.collectionView.animateCell(cell)
        return cell
    }
}
