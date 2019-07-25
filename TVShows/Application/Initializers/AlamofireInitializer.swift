//
//  AlamofireInitializer.swift
//  TVShows
//
//  Created by Filip Gulan on 28/07/2018.
//  Copyright © 2018 Filip Gulan. All rights reserved.
//

import Foundation
import AlamofireNetworkActivityLogger
import AlamofireNetworkActivityIndicator

final class AlamofireInitializer: Initializable {
    
    func initialize() {
        #if DEBUG
            NetworkActivityLogger.shared.startLogging()
            NetworkActivityLogger.shared.level = .debug
        #endif
            NetworkActivityIndicatorManager.shared.isEnabled = true
    }
}
