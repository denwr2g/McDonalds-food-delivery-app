//
//  ViewController.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 26/04/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    let homeView = HomeView()
    var viewModel: HomeViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        configActions()
    }
    
    func configure(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    

}

//MARK: - View Configuration

private extension HomeViewController {
    
    func configView() {
        view.addSubview(homeView)
        
        homeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
   
}

//MARK: - Actions Configuration

private extension HomeViewController {
    
    func configActions() {
        homeView.loginButton.addTarget(self, action: #selector(goToLoginViewController), for: .touchUpInside)
        homeView.signUpButton.addTarget(self, action: #selector(goToRegisterViewController), for: .touchUpInside)
    }
    
    @objc func goToLoginViewController() {
        viewModel?.shouldGoToLoginViewController()
    }
    
    @objc func goToRegisterViewController() {
        viewModel?.shouldGoToRegisterViewController()
    }
}
