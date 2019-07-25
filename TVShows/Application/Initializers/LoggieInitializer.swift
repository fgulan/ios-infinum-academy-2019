//
//  LoggieInitializer.swift
//  TVShows
//
//  Created by Filip Gulan on 28/07/2018.
//  Copyright © 2018 Filip Gulan. All rights reserved.
//

import Foundation
#if DEV
import Loggie
#endif

final class LoggieInitializer: Initializable {
    
    func initialize() {
        #if DEV
            URLProtocol.registerClass(LoggieURLProtocol.self)
        #endif
    }
}
