//
//  UICollectionViewPagingFlowLayout.swift
//  ios-gemini-demo
//
//  Created by OkuderaYuki on 2018/04/15.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import UIKit

final class UICollectionViewPagingFlowLayout: UICollectionViewFlowLayout {

    /// スクロール後、どこに留まるかを指定する
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                      withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return proposedContentOffset
        }

        let offset = isVertical ? collectionView.contentOffset.y : collectionView.contentOffset.x
        let velocity = isVertical ? velocity.y : velocity.x

        let flickVelocityThreshold: CGFloat = 0.2
        let currentPage = offset / pageSize

        if fabs(velocity) > flickVelocityThreshold {
            let nextPage = velocity > 0.0 ? ceil(currentPage) : floor(currentPage)
            let nextPosition = nextPage * pageSize
            return isVertical
            ? CGPoint(x: proposedContentOffset.x, y: nextPosition)
            : CGPoint(x: nextPosition, y: proposedContentOffset.y)
        } else {
            let nextPosition = round(currentPage) * pageSize
            return isVertical
            ? CGPoint(x: proposedContentOffset.x, y: nextPosition)
            : CGPoint(x: nextPosition, y: proposedContentOffset.y)
        }
    }

    private var isVertical: Bool {
        return scrollDirection == .vertical
    }

    private var pageSize: CGFloat {
        if isVertical {
            return itemSize.height + minimumInteritemSpacing
        } else {
            return itemSize.width + minimumLineSpacing
        }
    }
}
