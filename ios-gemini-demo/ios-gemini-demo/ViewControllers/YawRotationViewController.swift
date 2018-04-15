//
//  YawRotationViewController.swift
//  ios-gemini-demo
//
//  Created by OkuderaYuki on 2018/04/15.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import Gemini
import UIKit

final class YawRotationViewController: UIViewController {

    // MARK: - properties

    @IBOutlet private weak var collectionView: GeminiCollectionView! {
        didSet {
            let nib = UINib(nibName: PhotoCell.identifier, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: PhotoCell.identifier)
            collectionView.backgroundColor = UIColor(red: 255 / 255, green: 212 / 255, blue: 100 / 255, alpha: 1)
            collectionView.gemini
                .yawRotationAnimation()
                .scale(0.7)
                .yawEffect(rotationEffect)
        }
    }
    private let images = Resource.images
    private var rotationEffect = YawRotationEffect.yawUp
    private var scrollDirection = UICollectionViewScrollDirection.horizontal

    // MARK: - factory

    static func make(scrollDirection: UICollectionViewScrollDirection,
                     effect: YawRotationEffect) -> YawRotationViewController {
        let storyboardName = "YawRotationViewController"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! YawRotationViewController
        viewController.rotationEffect = effect
        viewController.scrollDirection = scrollDirection
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
        layout.itemSize = CGSize(width: view.bounds.width - 50,
                                 height: view.bounds.width - 50)
        let cellHeight: CGFloat = view.bounds.width - 50
        layout.sectionInset = UIEdgeInsets(top: (view.bounds.height - cellHeight) / 2,
                                           left: 25,
                                           bottom: (view.bounds.height - cellHeight) / 2,
                                           right: 25)
        layout.minimumLineSpacing = 80
        layout.minimumInteritemSpacing = 80
        collectionView.collectionViewLayout = layout
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast

        var title = ""
        switch (scrollDirection, rotationEffect) {
        case (.horizontal, .yawUp):
            title = "Horizontal yaw up"
        case (.horizontal, .yawDown):
            title = "Horizontal yaw down"
        case (.horizontal, .sineWave):
            title = "Horizontal sine wave"
        case (.horizontal, .reverseSineWave):
            title = "Horizontal reverse sine wave"
        case (.vertical, .yawUp):
            title = "Vertical yaw up"
        case (.vertical, .yawDown):
            title = "Vertical yaw down"
        case (.vertical, .sineWave):
            title = "Vertical sine wave"
        case (.vertical, .reverseSineWave):
            title = "Vertical reverse sine wave"
        }
        navigationItem.title = title
    }
}

extension YawRotationViewController: UICollectionViewDelegate {

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

extension YawRotationViewController: UICollectionViewDataSource {

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
