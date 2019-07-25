//
//  Progressable.swift
//  TVShows
//
//  Created by Filip Gulan on 28/07/2018.
//  Copyright © 2018 Filip Gulan. All rights reserved.
//

import UIKit
import PKHUD

protocol Progressable: class {
    func showLoading()
    func showLoadingInView()
    func hideLoading()
    func hideLoadingInView()
    func showSuccess()
    func showFailure(with error: Error)
}

protocol Refreshable {
    var refreshControl: UIRefreshControl { get }
}

extension Refreshable {
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
}

extension Progressable where Self: WireframeInterface {
    
    func showLoading() {
        guard shouldShowSpinner() else { return }
        PKHUD.sharedHUD.dimsBackground = false
        HUD.show(.progress)
    }
    
    func showLoadingInView() {
        guard shouldShowSpinner() else { return }
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.dimsBackground = false
        PKHUD.sharedHUD.show(onView: viewController.view)
    }
    
    func hideLoading() {
        (viewController as? Refreshable)?.endRefreshing()
        HUD.hide()
    }
    
    func hideLoadingInView() {
        (viewController as? Refreshable)?.endRefreshing()
        HUD.hide()
    }
    
    func showSuccess() {
        HUD.flash(.success, delay: 0.7)
    }
    
    func showFailure(with error: Error) {
        log.error((error as CustomDebugStringConvertible).debugDescription)
        let alertView = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alertView, animated: true, completion: nil)
    }

    private func shouldShowSpinner() -> Bool {
        if
            let refreshable = viewController as? Refreshable,
            refreshable.refreshControl.isRefreshing
        {
            return false
        }
        return true
    }
}

