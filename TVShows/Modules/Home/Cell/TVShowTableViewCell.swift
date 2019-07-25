//
//  TVShowTableViewCell.swift
//  TVShows
//
//  Created by Filip Gulan on 24/07/2018.
//  Copyright © 2018 Filip Gulan. All rights reserved.
//

import UIKit
import Kingfisher

class TVShowTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var _titleLabel: UILabel!
    @IBOutlet private weak var _imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        _setupImageView()
    }

    func configure(with item: Show) {
        _titleLabel.text = item.title
        if let imageUrl = item.imageUrl {
            let url = URL(string: "https://api.infinum.academy/")?
                        .appendingPathComponent(imageUrl)
            _imageView.kf.setImage(with: url)
        } else {
            _imageView.image = nil
        }
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
