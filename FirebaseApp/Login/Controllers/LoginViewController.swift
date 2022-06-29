//
//  LoginViewController.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 26/04/2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let loginView = LoginView()
    var viewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        configNavigationItems()
        configActions()
    }
    
    func configure(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
}

//MARK: - View Configuration

private extension LoginViewController {
    
    func configView() {
        view.addSubview(loginView)
        
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configNavigationItems() {
        navigationItem.leftBarButtonItem =  UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(back))
    }
    
}

//MARK: - Actions Configuration

private extension LoginViewController {
    
    func configActions() {
        
        loginView.loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        
        viewModel?.onLoadingSpinnerAppear = { [weak self] in
            guard let self = self else { return }
            self.loadingSpinnerDidAppear()
        }
        
        viewModel?.onLoadingSpinnerDisappear = { [weak self] in
            guard let self = self else { return }
            self.loadingSpinnerDidDisappear()
        }
    }
    
}

//MARK: - LoginViewController Methods

private extension LoginViewController {
    
    @objc func back() {
        viewModel?.shouldGoHomeViewController()
    }
    
    @objc func loginPressed() {
        guard let email = loginView.loginField.textField.text,
              let password = loginView.passField.textField.text else { return }
        
        viewModel?.signIn(email: email, password: password)
    }
    
    func loadingSpinnerDidAppear() {
        self.loginView.spinner.startAnimating()
        self.loginView.loginButton.isEnabled = false
        self.loginView.loginButton.setTitle("", for: .normal)
    }
    
    func loadingSpinnerDidDisappear() {
        self.loginView.spinner.stopAnimating()
        self.loginView.loginButton.isEnabled = true
        self.loginView.loginButton.setTitle("Sign In!", for: UIControl.State.normal)
    }
}
