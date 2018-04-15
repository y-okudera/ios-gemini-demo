//
//  CubeViewController.swift
//  ios-gemini-demo
//
//  Created by OkuderaYuki on 2018/04/15.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import Gemini
import UIKit

final class CubeViewController: UIViewController {

    // MARK: - properties

    @IBOutlet private weak var collectionView: GeminiCollectionView!  {
        didSet {
            let nib = UINib(nibName: PhotoCell.identifier, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: PhotoCell.identifier)
            collectionView.delegate   = self
            collectionView.dataSource = self
            collectionView.isPagingEnabled = true
            collectionView.gemini
                .cubeAnimation()
                .shadowEffect(.fadeIn)
        }
    }
    private let images = Resource.images

    var direction: UICollectionViewScrollDirection = .horizontal

    // MARK: - factory

    static func make(scrollDirection: UICollectionViewScrollDirection) -> CubeViewController {
        let storyboardName = "CubeViewController"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! CubeViewController
        viewController.direction = scrollDirection
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
            layout.scrollDirection = direction
            collectionView.collectionViewLayout = layout
        }

        navigationItem.title = direction == .horizontal ? "Horizontal cube" : "Vertical cube"
    }
}

extension CubeViewController: UICollectionViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.animateVisibleCells()
    }
}

extension CubeViewController: UICollectionViewDataSource {

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
        return cell
    }
}

extension CubeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.width,
                      height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
