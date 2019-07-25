//
//  CollectionViewReloader.swift
//
//

import UIKit

protocol CollectionViewReloader {
    func reload(_ collectionView: UICollectionView, oldSections: [CollectionSectionItem]?, newSections: [CollectionSectionItem]?)
}

struct DefaultCollectionViewReloader: CollectionViewReloader {
    
    func reload(_ collectionView: UICollectionView, oldSections: [CollectionSectionItem]?, newSections: [CollectionSectionItem]?) {
        collectionView.reloadData()
    }
    
}
