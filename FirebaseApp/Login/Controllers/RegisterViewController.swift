//
//  RegisterViewController.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 26/04/2022.
//

import UIKit


class RegisterViewController: UIViewController {
    
    private let registerView = RegisterView()
    var viewModel: RegisterViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        configNavigationItems()
        configActions()
    }
    
    func configure(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
    }
    
}

//MARK: - View Configuration

private extension RegisterViewController {
    
    func configView() {
        view.addSubview(registerView)
        
        registerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    func configNavigationItems() {
        navigationItem.leftBarButtonItem =  UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(back))
    }
    
}

//MARK: - Actions Configuration

private extension RegisterViewController {
    
    func configActions() {
        registerView.registerButton.addTarget(self, action: #selector(registerPressed), for: .touchUpInside)
        
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

//MARK: - RegisterViewController Methods

private extension RegisterViewController {
    
    func loadingSpinnerDidAppear() {
        self.registerView.spinner.startAnimating()
        self.registerView.registerButton.isEnabled = false
        self.registerView.registerButton.setTitle("", for: .normal)
    }
    
    func loadingSpinnerDidDisappear() {
        self.registerView.spinner.stopAnimating()
        self.registerView.registerButton.isEnabled = true
        self.registerView.registerButton.setTitle("Sign Up!", for: UIControl.State.normal)
    }
    
    @objc func back() {
        viewModel?.shouldGoHomeViewController()
    }
    
    
    @objc func registerPressed() {
        guard let email = registerView.loginField.textField.text,
              let password = registerView.passField.textField.text else { return }
        
        viewModel?.signUp(email: email, password: password)
    }
}

