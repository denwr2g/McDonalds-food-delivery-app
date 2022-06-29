//
//  VideoViewController.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 02/05/2022.
//

import UIKit

class CartViewController: UIViewController {
    
    var viewModel: CartViewModel?
    private var cartView = CartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
        configNavigationItems()
        configTable()
        configItems()
        configActions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        configItems()
    }
    
    func configure(viewModel: CartViewModel) {
        self.viewModel = viewModel
    }
    
    public func updateTableViewContent() {
        cartView.tableView.reloadData()
    }
}

// MARK: - View Configuration

private extension CartViewController {
    
    func configView() {
        view.addSubview(cartView)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Cart"
        
        cartView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configNavigationItems() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Cart"
    }
    
    func configTable() {
        cartView.tableView.delegate = self
        cartView.tableView.dataSource = self
        cartView.tableView.register(UINib(nibName: "PositionCell", bundle: nil), forCellReuseIdentifier: PositionCell.identifier)
    }
    
    func configItems() {
        cartView.tableView.reloadData()
        cartView.totalPriceLabel.text = viewModel?.getTotalCost()
    }
    
}

// MARK: - Actions Configuration

private extension CartViewController {
    
    func configActions() {
        cartView.makeOrderButton.addTarget(self, action: #selector(makeOrderTapped), for: .touchUpInside)
        cartView.cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        
        viewModel?.onShowOrderSheet = { [weak self] in
            guard let self = self else { return }
            self.makeOrderSheet {
                self.viewModel?.makeOrder()
                self.cartView.totalPriceLabel.text = "0 $"
            }
        }
        
        viewModel?.onEnableButton = { [weak self] in
            guard let self = self else { return }
            self.cartView.makeOrderButton.isEnabled = true
        }
        
        viewModel?.onDisableButton = { [weak self] in
            guard let self = self else { return }
            self.cartView.makeOrderButton.isEnabled = false

        }
    }
    
}

// MARK: - CartViewController Methods

private extension CartViewController {
    
    @objc func makeOrderTapped() {
        viewModel?.makeOrderTapped()
    }
    
    @objc func cancelTapped() {
        viewModel?.clearCart()
        cartView.totalPriceLabel.text = "0 $"
    }
}

// MARK: - TableView Datasource and Delegate

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = viewModel?.getPositionsCount() else { return 0 }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PositionCell.identifier, for: indexPath) as? PositionCell, let position = viewModel?.getValue(index: indexPath.row) else { return .init() }
        
        cell.configCell(position)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            viewModel?.removePosition(index: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            configItems()
            
            tableView.endUpdates()
        }
    }
}
