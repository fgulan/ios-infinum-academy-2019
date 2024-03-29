//
//  ShowDetailsPresenter.swift
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

final class ShowDetailsPresenter {

    // MARK: - Private properties -

    private unowned let view: ShowDetailsViewInterface
    private let interactor: ShowDetailsInteractorInterface
    private let wireframe: ShowDetailsWireframeInterface

    // MARK: - Lifecycle -

    init(view: ShowDetailsViewInterface, interactor: ShowDetailsInteractorInterface, wireframe: ShowDetailsWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

// MARK: - Extensions -

extension ShowDetailsPresenter: ShowDetailsPresenterInterface {

    func setup(with output: ShowDetailsViewOutput) -> ShowDetailsViewInput {
        return ShowDetailsViewInput()
    }

}

