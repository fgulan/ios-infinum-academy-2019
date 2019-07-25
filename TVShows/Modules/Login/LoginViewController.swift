//
//  LoginViewController.swift
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

final class LoginViewController: ShowsViewController {

    // MARK: - Private properties -

    private let _disposeBag = DisposeBag()

    // MARK: - IBOutlets
    
    @IBOutlet private weak var _scrollView: UIScrollView!
    
    @IBOutlet private weak var _loginButton: UIButton!
    @IBOutlet private weak var _registerButton: UIButton!
    @IBOutlet private weak var _checkmarkButton: UIButton!
    
    @IBOutlet private weak var _emailField: UITextField!
    @IBOutlet private weak var _passwordField: UITextField!
    
    // MARK: - Public properties -

    var presenter: LoginPresenterInterface!

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        _setupView()
        _setupUI()
    }
	
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

// MARK: - Extensions -

extension LoginViewController: LoginViewInterface {
}

private extension LoginViewController {

    func _setupView() {

        let toggleRememberMe = _checkmarkButton.rx.tap.asDriver()
            .scan(false) { state, _ in !state }
            .startWith(false)
        
        toggleRememberMe
            .drive(_checkmarkButton.rx.isSelected)
            .disposed(by: _disposeBag)
        
        let output = Login.ViewOutput(email: _emailField.rx.text.asDriver().unwrap(),
                                      password: _passwordField.rx.text.asDriver().unwrap(),
                                      rememberMe: toggleRememberMe,
                                      loginPressed: _loginButton.rx.tap.asDriver(),
                                      registerPressed: _registerButton.rx.tap.asDriver())
        
        let input = presenter.setupBinding(with: output)
        
        input
            .loginEnabled
            .drive(_loginButton.rx.isEnabled)
            .disposed(by: _disposeBag)
        
        input
            .registerEnabled
            .drive(_registerButton.rx.isEnabled)
            .disposed(by: _disposeBag)
    }
    
    func _setupUI() {
        _loginButton.layer.cornerRadius = 6.0
        _loginButton.setBackgroundImage(.from(color: UIColor.TVShows.pink), for: .normal)
        _loginButton.setBackgroundImage(.from(color: UIColor.TVShows.pink.withAlphaComponent(0.5)),
                                        for: .disabled)
        
        KeyboardHandler
            .register(scrollView: _scrollView)
            .disposed(by: _disposeBag)
    }
}
