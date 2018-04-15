//
//  PitchRotationViewController.swift
//  ios-gemini-demo
//
//  Created by OkuderaYuki on 2018/04/15.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import Gemini
import UIKit

final class PitchRotationViewController: UIViewController {

    // MARK: - properties

    @IBOutlet private weak var collectionView: GeminiCollectionView! {
        didSet {
            let nib = UINib(nibName: PhotoCell.identifier, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: PhotoCell.identifier)
            collectionView.backgroundColor = .clear
            collectionView.gemini
                .pitchRotationAnimation()
                .scale(0.7)
                .pitchEffect(rotationEffect)
        }
    }
    private let images = Resource.images
    private var rotationEffect = PitchRotationEffect.pitchUp
    private var scrollDirection = UICollectionViewScrollDirection.horizontal

    // MARK: - factory

    static func make(scrollDirection: UICollectionViewScrollDirection,
                     effect: PitchRotationEffect) -> PitchRotationViewController {
        let storyboardName = "PitchRotationViewController"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! PitchRotationViewController
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
        layout.itemSize = CGSize(width: view.bounds.width - 60,
                                 height: view.bounds.height - 100)
        layout.sectionInset = UIEdgeInsets(top: 50, left: 30, bottom: 50, right: 30)
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 30
        collectionView.collectionViewLayout = layout
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast

        let startColor = UIColor(red: 238 / 255, green: 156 / 255, blue: 167 / 255, alpha: 1)
        let endColor = UIColor(red: 225 / 255, green: 221 / 255, blue: 225 / 255, alpha: 1)
        let colors: [CGColor] = [startColor.cgColor, endColor.cgColor]
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.frame.size = view.frame.size
        view.layer.insertSublayer(gradientLayer, at: 0)

        var title = ""
        switch (scrollDirection, rotationEffect) {
        case (.horizontal, .pitchUp):
            title = "Horizontal pitch up"
        case (.horizontal, .pitchDown):
            title = "Horizontal pitch down"
        case (.horizontal, .sineWave):
            title = "Horizontal sine wave"
        case (.horizontal, .reverseSineWave):
            title = "Horizontal reverse sine wave"
        case (.vertical, .pitchUp):
            title = "Vertical pitch up"
        case (.vertical, .pitchDown):
            title = "Vertical pitch down"
        case (.vertical, .sineWave):
            title = "Vertical sine wave"
        case (.vertical, .reverseSineWave):
            title = "Vertical reverse sine wave"
        }
        navigationItem.title = title
    }
}

extension PitchRotationViewController: UICollectionViewDelegate {
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

extension PitchRotationViewController: UICollectionViewDataSource {

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
