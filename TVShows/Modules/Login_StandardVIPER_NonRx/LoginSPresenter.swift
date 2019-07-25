//
//  LoginSPresenter.swift
//  TVShows
//
//  Created by Filip Gulan on 29/07/2018.
//  Copyright (c) 2018 Filip Gulan. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation

final class LoginSPresenter {

    // MARK: - Private properties -

    private unowned let _view: LoginSViewInterface
    private let _interactor: LoginSInteractorInterface
    private let _wireframe: LoginSWireframeInterface

    // MARK: - Lifecycle -

    init(wireframe: LoginSWireframeInterface, view: LoginSViewInterface, interactor: LoginSInteractorInterface) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
    }
}

// MARK: - Extensions -

extension LoginSPresenter: LoginSPresenterInterface {
    
    func didSelectLoginWith(email: String, password: String) {
        _wireframe.showLoading()
        _interactor.login(email: email, password: password) { [weak _wireframe] result in
            _wireframe?.hideLoading()
            switch result {
            case .success:
                _wireframe?.navigate(to: .home)
            case .failure(let error):
                _wireframe?.showFailure(with: error)
            }
        }
    }
    
    func didSelectRegisterWith(email: String, password: String) {
        _wireframe.showLoading()
        _interactor.register(email: email, password: password) { [weak _wireframe, weak self] result in
            _wireframe?.hideLoading()
            switch result {
            case .success:
                self?.didSelectLoginWith(email: email, password: password)
            case .failure(let error):
                _wireframe?.showFailure(with: error)
            }
        }
    }
}