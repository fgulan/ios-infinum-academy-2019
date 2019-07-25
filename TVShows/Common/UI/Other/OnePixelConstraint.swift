//
//  OnePixelConstraint.swift
//  TVShows
//
//  Created by Filip Gulan on 29/07/2018.
//  Copyright © 2018 Filip Gulan. All rights reserved.
//

import UIKit

class OnePixelConstraint: NSLayoutConstraint {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        constant = 1 / UIScreen.main.scale
    }
}
