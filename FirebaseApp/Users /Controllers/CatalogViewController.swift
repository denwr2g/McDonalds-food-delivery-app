//
//  CatalogViewController.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 09/05/2022.
//

import UIKit

class CatalogViewController: UIViewController {
    
    var viewModel: CatalogViewModel?
    private let catalogView = CatalogView()
    private var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        configNavigationItems()
        configTable()
        configActions()
        configActivityIndicator()
    }
    
    func configure(viewModel: CatalogViewModel) {
        self.viewModel = viewModel
    }
    
    public func updateTableViewContent() {
        catalogView.tableView.reloadData()
    }
    
}

//MARK: - View Configuration

private extension CatalogViewController {
    
    func configView() {
        view.addSubview(catalogView)
        
        catalogView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configNavigationItems() {
        title = "Catalog"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
    }
    
    func configTable() {
        catalogView.tableView.delegate = self
        catalogView.tableView.dataSource = self
        catalogView.tableView.register(CatalogTableCell.self, forCellReuseIdentifier: CatalogCell.identifier)
    }
    
}

//MARK: - Actions Configuration

private extension CatalogViewController {
    
    func configActions() {
        catalogView.segmentedController.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
    }
    
    func configActivityIndicator() {
        viewModel?.onStartIndicator = { [weak self] in
            guard let self = self else { return }
            self.catalogView.tableView.isHidden = true
            self.catalogView.indicator.startAnimating()
        }
        
        viewModel?.onStopIndicator = { [weak self] in
            guard let self = self else { return }
            self.catalogView.tableView.isHidden = false
            self.catalogView.indicator.stopAnimating()
        }
    }
    
}

//MARK: - CatalogViewController Methods

private extension CatalogViewController {
    
    @objc func valueChanged(sender: UISegmentedControl) {
        self.currentIndex = sender.selectedSegmentIndex
        catalogView.tableView.reloadData()
    }
    
    @objc func logOut() {
        showLogoutAlert { [weak self] in
            guard let self = self else { return }
            self.viewModel?.logOut()
        }
    }
    
}


//MARK: - TableView Delegate and DataSource

extension CatalogViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Count Configuration
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        guard let numberOfSection = viewModel?.numberOfSection(index: currentIndex) else { return 0 }
        
        return numberOfSection
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let numberOfRowsInSection = viewModel?.numberOfRowInSection(index: currentIndex, section: section) else { return 0 }
        
        return numberOfRowsInSection
    }
    
    //MARK: - Cell Configuration
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CatalogTableCell.identifier, for: indexPath) as? CatalogTableCell, let product = viewModel?.getValue(currentIndex: currentIndex, section: indexPath.section, row: indexPath.row) else { return .init() }
        
        cell.configure(name: product.title, price: product.priceStr, desc: product.descript)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        viewModel?.didSelectRowAt(currentIndex: currentIndex, section: indexPath.section, row: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    //MARK: - Header Configuration
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = CatalogHeader()
        
        header.title.text = viewModel?.viewForHeaderInSection(index: currentIndex, section: section)
        
        header.imageView.isHidden = true
        
        //        guard let tuple = viewModel?.viewForHeaderInSection(index: currentIndex, section: section) else { return nil }
        //
        //        header.title.text = tuple.0
        //        header.imageView.image = UIImage(named: tuple.1)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
}
