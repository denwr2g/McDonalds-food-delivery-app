//
//  AppDelegate.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 26/04/2022.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var navigationController: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        setupNavigationController()
        window?.rootViewController = navigationController
        
        return true
    }
    
    //MARK: - Login
    
    func makeHomeViewController() -> UIViewController {
        let vc = HomeViewController()
        let vm = HomeViewModel()
        
        vm.onGoToLoginViewController = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.pushViewController(self.makeLoginViewController(), animated: true)
        }
        
        vm.onGoToRegisterViewController = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.pushViewController(self.makeRegisterViewController(), animated: true)
        }
        
        vc.configure(viewModel: vm)
        
        return vc
    }
    
    func makeLoginViewController() -> UIViewController {
        let vc = LoginViewController()
        let vm = LoginViewModel()
        
        vm.onGoToMainViewController = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.pushViewController(self.makeMainTabBarController(), animated: true)
        }
        
        vm.onGoToAdminViewController = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.pushViewController(self.makeAdminViewController(), animated: true)
        }
        
        vm.onGoToHomeViewController = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        vm.onShowErrorAlert = {
            vc.errorAlert()
        }
        
        vc.configure(viewModel: vm)
        return vc
    }
    
    func makeRegisterViewController() -> UIViewController {
        let vc = RegisterViewController()
        let vm = RegisterViewModel()
        
        vm.onGoToMainViewController = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.pushViewController(self.makeMainTabBarController(), animated: true)
        }
        
        vm.onGoToHomeViewController = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        vc.configure(viewModel: vm)
        
        return vc
    }

    func setupNavigationController() {
        navigationController = UINavigationController(rootViewController: makeHomeViewController())
        
        UINavigationBar.appearance().tintColor = .black
    }

    //MARK: - User
    
    func makeMainTabBarController() -> UITabBarController {
        let vc = MainTabBarController()
        
        let catalogVC = createNavController(vc: makeCatalogViewController(), selected: UIImage(systemName: "newspaper.fill"), unselected: UIImage(systemName: "newspaper"), title: "Catalog")
        let cartVC = createNavController(vc: makeCartViewController(), selected: UIImage(systemName: "cart.fill"), unselected: UIImage(systemName: "cart"), title: "Cart")
        let profileVC = createNavController(vc: makeProfileViewController(), selected: UIImage(systemName: "star.fill"), unselected: UIImage(systemName: "star"), title: "Profile")
               

        vc.viewControllers = [catalogVC, cartVC, profileVC]

        return vc
    }
    
    func makeCatalogViewController() -> UIViewController {
        let vc = CatalogViewController()
        let vm = CatalogViewModel()
                
        vm.onGoToHomeViewController = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        vm.onOpenCatalogDetailViewController = { [weak self] product in
            guard let self = self else { return }
            self.navigationController?.present(self.makeCatalogDetailViewController(with: product), animated: true)
        }
        
        vm.onUpdateTable = { vc.updateTableViewContent() }
        
        vc.configure(viewModel: vm)
        
        return vc
    }
    
    func makeCatalogDetailViewController(with product: ProductDB) -> UIViewController {
        let vc = CatalogDetailViewController()
        let vm = CatalogDetailViewModel()
        
        vm.onGoToCatalogViewController = { vc.dismiss(animated: true) }
        
        vm.setProduct(product: product)
        vc.configure(viewModel: vm)

        return vc
    }
    
    func makeCartViewController() -> UIViewController {
        let vc = CartViewController()
        let vm = CartViewModel()
        
        vm.onShowSuccessfullyAlert = {
            vc.basicAlert(with: "You have successfully made an order!")
        }
        
        vm.onShowErrorAlert = {
            vc.basicAlert(with: "Cart is empty!")
        }
        
        vm.onUpdateTable = {
            vc.updateTableViewContent()
        }
    
        vc.configure(viewModel: vm)
        return vc
    }
    
    func makeProfileViewController() -> UIViewController {
        let vc = ProfileViewController()
        let vm = ProfileViewModel()
        
        vm.onUpdateTable = {
            vc.updateTableViewContent()
        }
        
        vc.configure(viewModel: vm)
        return vc
    }
    
    private func createNavController(vc: UIViewController, selected: UIImage!, unselected: UIImage!, title: String) -> UINavigationController {
        let viewController = vc
        let navController = UINavigationController(rootViewController: viewController)
        viewController.tabBarItem.image = unselected
        viewController.tabBarItem.selectedImage = selected
        viewController.title = title
        return navController
    }
    
    //MARK: - Administrator
    
    func makeAdminViewController() -> UIViewController {
        let vc = AdminViewController()
        let vm = AdminViewModel()
        
        vm.onUpdateTable = { vc.updateTableViewContent() }
        
        vm.onGoToHomeViewController = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        vm.onGoToOrderViewController = { [weak self] order in
            guard let self = self else { return }
            self.navigationController?.present(self.makeOrderViewController(with: order, adminVC: vc), animated: true)
        }
        
        vm.onGoToProductstViewController = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.pushViewController(self.makeProductsViewController(), animated: true)
        }
        
        vm.onGoToNewProductViewController = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.present(self.makeNewProductViewController(), animated: true)
        }
        
        vc.configure(viewModel: vm)
        return vc
    }
    
    func makeOrderViewController(with order: Order, adminVC: AdminViewController) -> UIViewController {
        let vc = OrderViewController()
        let vm = OrderViewModel()
        
        vm.onUpdateAdminTable = {
            adminVC.updateOrders()
        }
        
        vm.setCurrentOrder(with: order)
        vc.configure(viewModel: vm)
        
        return vc
    }
    
    func makeProductsViewController() -> UIViewController {
        let vc = ProductsViewController()
        let vm = ProductsViewModel()
        
        vm.onUpdateTable = { vc.updateTableViewContent() }
        vm.onGoToBack = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
        
        vc.configure(viewModel: vm)
        
        return vc
    }
  
    func makeNewProductViewController() -> UIViewController {
        let vc = NewProductViewController()
        let vm = NewProductViewModel()
        
        vm.onShowSuccesfullAlert = {
            vc.basicAlertWithCompletion(with: "Product added successfully!") {
                vc.dismiss(animated: true)
            }
        }
        
        vc.configure(viewModel: vm)
        
        return vc
    }
}

