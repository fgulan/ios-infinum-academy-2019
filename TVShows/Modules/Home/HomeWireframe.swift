//
//  HomeWireframe.swift
//  TVShows
//
//  Created by Filip Gulan on 29/07/2018.
//  Copyright (c) 2018 Filip Gulan. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit
import RxSwift
import RxCocoa

final class HomeWireframe: BaseWireframe {

    // MARK: - Private properties -

    private let storyboard = UIStoryboard(name: "Home", bundle: nil)

    // MARK: - Module setup -

    init() {
        let moduleViewController = storyboard.instantiateViewController(ofType: HomeViewController.self)
        super.init(viewController: moduleViewController)
        
        let interactor = HomeInteractor()
        let presenter = HomePresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension HomeWireframe: HomeWireframeInterface {
    
    func navigate(to option: Home.NavigationOption) {
        switch option {
        case .showDetails(showId: let id):
            navigationController?.pushWireframe(ShowDetailsWireframe(showId: id))
        }
    }
}