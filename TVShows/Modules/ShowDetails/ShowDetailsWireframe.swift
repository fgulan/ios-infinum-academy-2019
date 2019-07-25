//
//  ShowDetailsWireframe.swift
//  TVShows
//
//  Created by Filip Gulan on 30/07/2018.
//  Copyright (c) 2018 Filip Gulan. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit
import RxSwift
import RxCocoa

final class ShowDetailsWireframe: BaseWireframe {

    // MARK: - Private properties -

    private let storyboard = UIStoryboard(name: "ShowDetails", bundle: nil)

    // MARK: - Module setup -

    init(showId: String) {
        let moduleViewController = storyboard.instantiateViewController(ofType: ShowDetailsViewController.self)
        super.init(viewController: moduleViewController)
        
        let interactor = ShowDetailsInteractor(showId: showId)
        let presenter = ShowDetailsPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension ShowDetailsWireframe: ShowDetailsWireframeInterface {

    func navigate(to option: ShowDetailsNavigationOption) {
    }
}