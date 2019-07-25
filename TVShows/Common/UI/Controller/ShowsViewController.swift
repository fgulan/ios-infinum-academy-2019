//
//  ShowsViewController.swift
//  TVShows
//
//  Created by Filip Gulan on 28/07/2018.
//  Copyright © 2018 Filip Gulan. All rights reserved.
//

import UIKit
import RxSwift

class ShowsViewController: UIViewController {

    #if DEBUG
        private let startResourceCount = Resources.total
    #endif
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        #if DEBUG
            let logString = "⚠️ Number of start resources = \(Resources.total) ⚠️"
            log.info(logString)
        #endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .`default`
    }
    
    deinit {
        #if DEBUG
        
        let mainQueue = DispatchQueue.main
        let when = DispatchTime.now() + DispatchTimeInterval.milliseconds(300)
        
        mainQueue.asyncAfter(deadline: when) {
            let logString = "⚠️ Number of resources after dispose = \(Resources.total) ⚠️"
            log.info(logString)
        }
        
        /*
         !!! This cleanup logic is adapted for example app use case. !!!
         
         It is being used to detect memory leaks during pre release tests.
         
         !!! In case you want to have some resource leak detection logic, the simplest
         method is just printing out `RxSwift.Resources.total` periodically to output. !!!
         
         
         /* add somewhere in
         func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
         */
         _ = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
         .subscribe(onNext: { _ in
         print("Resource count \(RxSwift.Resources.total)")
         })
         
         Most efficient way to test for memory leaks is:
         * navigate to your screen and use it
         * navigate back
         * observe initial resource count
         * navigate second time to your screen and use it
         * navigate back
         * observe final resource count
         
         In case there is a difference in resource count between initial and final resource counts, there might be a memory
         leak somewhere.
         
         The reason why 2 navigations are suggested is because first navigation forces loading of lazy resources.
         */
        
        #endif
    }
}
