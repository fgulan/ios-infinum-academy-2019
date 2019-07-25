//
//  LoggingInitializer.swift
//  TVShows
//
//  Created by Filip Gulan on 28/07/2018.
//  Copyright © 2018 Filip Gulan. All rights reserved.
//

import Foundation
import SwiftyBeaver

let log = SwiftyBeaver.self

class LoggingInitializer: Initializable {
    
    func initialize() {
        
        let console = ConsoleDestination()
        
        #if DEBUG
            log.addDestination(console)
        #endif
    }
}
