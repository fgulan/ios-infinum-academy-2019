//
//  UIColor+Inits.swift
//  TVShows
//
//  Created by Filip Gulan on 28/07/2018.
//  Copyright © 2018 Filip Gulan. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(rgbHex: Int, alpha: CGFloat = 1) {
        let r = (rgbHex >> 16) & 0xFF
        let g = (rgbHex >> 8) & 0xFF
        let b = rgbHex & 0xFF

        self.init(
            red: CGFloat(r) / 255.0,
            green: CGFloat(g) / 255.0,
            blue: CGFloat(b) / 255.0,
            alpha: alpha
        )
    }
    
    convenience init?(rgbHex: String, alpha: CGFloat = 1) {
        
        let string = rgbHex
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .uppercased()
        
        guard
            string.count == 6,
            let int = Int(string, radix: 16)
        else {
            return nil
        }
        
        self.init(rgbHex: int, alpha: alpha)
    }
}
