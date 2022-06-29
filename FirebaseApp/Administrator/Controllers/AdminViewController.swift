//
//  AdminViewController.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 27/05/2022.
//

import UIKit

class AdminViewController: UIViewController {
    
    private let adminView = AdminView()
    var viewModel: AdminViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        configNavigationItems()
        configTable()
        configActions()
        configFloatingButton()
    }

    func configure(viewModel: AdminViewModel) {
        self.viewModel = viewModel
    }
    
    public func updateTableViewContent() {
        adminView.tableView.reloadData()
    }
    
    public func updateOrders() {
        viewModel?.getOrders()
    }
}

//MARK: - View Configuration

extension AdminViewController {
    
    private func configView() {
        view.addSubview(adminView)
        
        adminView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configNavigationItems() {
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.counterclockwise"), style: .plain, target: self, action: #selector(update))
    }
    
    private func configTable() {
        adminView.tableView.delegate = self
        adminView.tableView.dataSource = self
        adminView.tableView.register(UINib(nibName: "OrderCell", bundle: nil), forCellReuseIdentifier: OrderCell.identifier)
    }

}

//MARK: - Actions Configuration

private extension AdminViewController {
    
    func configActions() {
        viewModel?.onStartIndicator = { [weak self] in
            guard let self = self else { return }
            self.adminView.tableView.isHidden = true
            self.adminView.indicator.startAnimating()
        }
        
        viewModel?.onStopIndicator = { [weak self] in
            guard let self = self else { return }
            self.adminView.tableView.isHidden = false
            self.adminView.indicator.stopAnimating()
        }
        
        viewModel?.onShowMessage = { [weak self] in
            guard let self = self else { return }
            self.adminView.messageLabel.isHidden = false
        }
        
        viewModel?.onHideMessage = { [weak self] in
            guard let self = self else { return }
            self.adminView.messageLabel.isHidden = true
        }
    }
    
    func configFloatingButton() {
        adminView.floatingButton.addTarget(self, action: #selector(didTapButton1), for: .touchUpInside)
        adminView.listButton.addTarget(self, action: #selector(didTapListButton), for: .touchUpInside)
    }
    
}

//MARK: - AdminViewController Methods

private extension AdminViewController {
    
    @objc func logOut() {
        showLogoutAlert { [weak self] in
            guard let self = self else { return }
            self.viewModel?.logOut()
        }
    }
    
    @objc func update() {
        viewModel?.getOrders()
    }
    
    @objc func didTapButton1() {
        viewModel?.shouldGoToNewProductViewController()
    }
    
    @objc func didTapListButton() {
        viewModel?.shouldGoToProductsViewController()
    }
}

//MARK: - TableView Methods

extension AdminViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = viewModel?.getOrdersCount() else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderCell.identifier, for: indexPath) as? OrderCell,    let order = viewModel?.getValue(index: indexPath.row) else { return .init() }
        
        cell.configCell(order)
        cell.selectionStyle = .default

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let order = viewModel?.getValue(index: indexPath.row) else { return }
        viewModel?.shouldGoToOrderViewController(with: order)
    }
}

