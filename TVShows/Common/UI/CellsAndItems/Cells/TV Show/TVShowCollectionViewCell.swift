//
//  TVShowCollectionViewCell.swift
//  TVShows
//
//  Created by Filip Gulan on 24/07/2018.
//  Copyright © 2018 Filip Gulan. All rights reserved.
//

import UIKit

struct ShowCollectionCellItem {
    
    let title: String
    let imageUrl: URL?
    let didSelectAction: () -> ()
}

extension ShowCollectionCellItem: CollectionCellItem {
    
    func cell(from collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ofType: TVShowCollectionViewCell.self,
                                                      for: indexPath)
        cell.configure(with: self)
        
        return cell
    }
    
    func didSelect(at indexPath: IndexPath) {
        didSelectAction()
    }
}

class TVShowCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var _titleLabel: UILabel!
    @IBOutlet private weak var _imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        _setupImageView()
    }
    
    func configure(with item: ShowCollectionCellItem) {
        _titleLabel.text = item.title
        _imageView.kf.setImage(with: item.imageUrl)
    }
    
    // MARK: - Private functions -
    
    private func _setupImageView() {
        _imageView.layer.shadowColor = UIColor.black.cgColor
        _imageView.layer.shadowOffset = CGSize(width: 0, height: 1)
        _imageView.layer.shadowOpacity = 1
        _imageView.layer.shadowRadius = 2.0
        _imageView.clipsToBounds = false
    }
}
