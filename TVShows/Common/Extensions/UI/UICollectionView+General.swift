//
//  UICollectionView+General.swift
//  TVShows
//
//  Created by Filip Gulan on 29/07/2018.
//  Copyright © 2018 Filip Gulan. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func dequeueReusableCell<T: UICollectionViewCell>(ofType _: T.Type, withReuseIdentifier identifier: String? = nil, for indexPath: IndexPath) -> T {
        let identifier = identifier ?? String(describing: T.self)
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! T
    }
    
    func register<T>(cellOfType _: T.Type, withReuseIdentifier identifier: String? = nil) {
        let cellName = String(describing: T.self)
        let identifier = identifier ?? cellName
        let nib = UINib(nibName: cellName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: identifier)
    }
}
