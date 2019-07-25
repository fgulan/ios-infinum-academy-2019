//
//  ShowsGridFlowLayout.swift
//  TVShows
//
//  Created by Filip Gulan on 24/07/2018.
//  Copyright © 2018 Filip Gulan. All rights reserved.
//

import UIKit

class ShowsGridFlowLayout: UICollectionViewFlowLayout {

    var itemHeight: CGFloat = 160
    var numberOfColumns = 2
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    func setupLayout() {
        minimumInteritemSpacing = 1
        minimumLineSpacing = 1
        scrollDirection = .vertical
    }
    
    func itemWidth() -> CGFloat {
        return (collectionView!.frame.width / 2) - 1
    }
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width: itemWidth(), height: itemHeight)
        }
        get {
            return CGSize(width: itemWidth(), height: itemHeight)
        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
}
