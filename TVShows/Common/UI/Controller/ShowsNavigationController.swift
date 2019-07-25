//
//  ShowsNavigationController.swift
//  TVShows
//
//  Created by Filip Gulan on 28/07/2018.
//  Copyright © 2018 Filip Gulan. All rights reserved.
//

import UIKit
import AHKNavigationController

class ShowsNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            navigationBar.prefersLargeTitles = false
        }
        
        navigationBar.backgroundColor = .white
        navigationBar.tintColor = UIColor.TVShows.gray
        navigationBar.isTranslucent = false
    }
}
