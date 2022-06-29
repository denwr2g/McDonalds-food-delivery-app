//
//  ProductsViewController.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 22/06/2022.
//

import UIKit

class ProductsViewController: UIViewController {
    
    var viewModel: ProductsViewModel?
    private let productsView = ProductsView()
    private var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.getProducts()
        configView()
        configNavigationItems()
        configTable()
        configActions()
    }
    
    func configure(viewModel: ProductsViewModel) {
        self.viewModel = viewModel
    }
    
    public func updateTableViewContent() {
        productsView.tableView.reloadData()
    }
}

//MARK: - View Configuration

private extension ProductsViewController {
    
    func configView() {
        view.addSubview(productsView)
        
        productsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configNavigationItems() {
        navigationItem.leftBarButtonItem =  UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(back))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.counterclockwise"), style: .plain, target: self, action: #selector(update))
    }
    
    func configTable() {
        productsView.tableView.delegate = self
        productsView.tableView.dataSource = self
        productsView.tableView.register(CatalogTableCell.self, forCellReuseIdentifier: CatalogTableCell.identifier)
    }

}

//MARK: - Actions Configuration

private extension ProductsViewController {
    
    func configActions() {
        
        productsView.segmentedController.addTarget(self, action: #selector(valueChanged), for: .valueChanged)

        viewModel?.onStartIndicator = { [weak self] in
            guard let self = self else { return }
            self.productsView.tableView.isHidden = true
            self.productsView.indicator.startAnimating()
        }
        
        viewModel?.onStopIndicator = { [weak self] in
            guard let self = self else { return }
            self.productsView.tableView.isHidden = false
            self.productsView.indicator.stopAnimating()
        }
    }
}


//MARK: - ProductsViewController Methods

private extension ProductsViewController {
    
    @objc func update() {
        viewModel?.getProducts()
    }
    
    @objc func back() {
        viewModel?.shouldGoBack()
    }
    
    @objc func valueChanged(sender: UISegmentedControl) {
        self.currentIndex = sender.selectedSegmentIndex
        productsView.tableView.reloadData()
    }
}


//MARK: - TableView Configuration

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        guard let numberOfSection = viewModel?.numberOfSection(index: currentIndex) else { return 0 }
        
        return numberOfSection
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let numberOfRowsInSection = viewModel?.numberOfRowInSection(index: currentIndex, section: section) else { return 0 }
        
        return numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CatalogTableCell.identifier) as? CatalogTableCell,
              let product = viewModel?.getValue(currentIndex: currentIndex, section: indexPath.section, row: indexPath.row) else { return .init() }
        
        cell.configure(name: product.title, price: product.priceStr, desc: product.descript)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    //MARK: - Header configure
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = CatalogHeader()
                
        header.title.text = viewModel?.viewForHeaderInSection(index: currentIndex, section: section)
        
        header.imageView.isHidden = true
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
}


