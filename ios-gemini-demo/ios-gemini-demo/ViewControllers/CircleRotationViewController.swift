//
//  CircleRotationViewController.swift
//  ios-gemini-demo
//
//  Created by OkuderaYuki on 2018/04/15.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import Gemini
import UIKit

final class CircleRotationViewController: UIViewController {

    // MARK: - properties

    @IBOutlet private weak var collectionView: GeminiCollectionView! {
        didSet {
            let nib = UINib(nibName: PhotoCell.identifier, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: PhotoCell.identifier)
            collectionView.backgroundColor = UIColor(red: 234 / 255, green: 242 / 255, blue: 248 / 255, alpha: 1)
            collectionView.gemini
                .circleRotationAnimation()
                .radius(450)
                .rotateDirection(rotateDirection)
                .itemRotationEnabled(true)
        }
    }
    private let images = Resource.images
    private var scrollDirection: UICollectionViewScrollDirection = .horizontal
    private var rotateDirection: CircleRotationDirection = .clockwise

    // MARK: - factory

    static func make(scrollDirection: UICollectionViewScrollDirection,
                     rotateDirection: CircleRotationDirection) -> CircleRotationViewController {

        let storyboardName = "CircleRotationViewController"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! CircleRotationViewController
        viewController.scrollDirection = scrollDirection
        viewController.rotateDirection = rotateDirection
        return viewController
    }

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    // MARK: - private methods

    private func setup() {

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = scrollDirection
            collectionView.collectionViewLayout = layout
        }

        var title = ""
        switch (scrollDirection, rotateDirection) {
        case (.horizontal, .clockwise):
            title = "Horizontal clockwise rotation"
        case (.horizontal, .anticlockwise):
            title = "Horizontal anticlockwise rotation"
        case (.vertical, .clockwise):
            title = "Vertical clockwise rotation"
        case (.vertical, .anticlockwise):
            title = "Vertical anticlockwise rotation"
        }
        navigationItem.title = title
    }
}

extension CircleRotationViewController: UICollectionViewDelegate {
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

extension CircleRotationViewController: UICollectionViewDataSource {

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

extension CircleRotationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 350)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
