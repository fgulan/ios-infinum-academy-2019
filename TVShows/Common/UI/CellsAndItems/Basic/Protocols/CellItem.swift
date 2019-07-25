//
//  CellItem.swift
//
//

import UIKit

protocol CellItem {
    
}

protocol TableCellItem: CellItem {
    
    //Required
    func cell(from tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
    
    //Optional
    var height: CGFloat { get }
    var estimatedHeight: CGFloat { get }
    
    func didSelect(at indexPath: IndexPath)

}

protocol CollectionCellItem: CellItem {
    
    //Required
    func cell(from collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell
    
    //Optional
    func sizeWithCollectionView(size: CGSize, numOfImtemsInSection: Int) -> CGSize
    
    func willDisplay(cell: UICollectionViewCell, at indexPath: IndexPath)
    
    func didSelect(at indexPath: IndexPath)
    
}

extension TableCellItem {
    
    var height: CGFloat {
        return UITableView.automaticDimension
    }
    
    var estimatedHeight: CGFloat {
        return 44
    }
    
    func didSelect(at indexPath: IndexPath) {
        //pass
    }
    
}

extension CollectionCellItem {
    
    func sizeWithCollectionView(size: CGSize, numOfImtemsInSection: Int) -> CGSize {
        return UICollectionViewFlowLayout.automaticSize
    }
    
    func willDisplay(cell: UICollectionViewCell, at indexPath: IndexPath) {
        //pass
    }
    
    func didSelect(at indexPath: IndexPath) {
        //pass
    }
    
}
