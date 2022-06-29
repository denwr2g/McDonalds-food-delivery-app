//
//  CatalogDetailViewController.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 11/05/2022.
//

import UIKit

class CatalogDetailViewController: UIViewController {
    
    private let catalogDetailView = CatalogDetailView()
    var viewModel: CatalogDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        congifItems()
        configActions()
        isCountable()
    }
    
    func configure(viewModel: CatalogDetailViewModel) {
        self.viewModel = viewModel
    }
}

//MARK: - View Configuration

private extension CatalogDetailViewController {
    
    private func configView() {
        view.addSubview(catalogDetailView)
        
        navigationItem.title = "Detail"
        
        catalogDetailView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    private func congifItems() {
        catalogDetailView.titleLabel.text = viewModel?.product?.title
        catalogDetailView.priceLabel.text = viewModel?.product?.priceStr
        catalogDetailView.descriptionLabel.text = viewModel?.product?.descript
    }
    
}

//MARK: - Actions Configuration

private extension CatalogDetailViewController {
    
    func configActions() {
        catalogDetailView.segmentedController.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        
        catalogDetailView.toCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        
        catalogDetailView.stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
    }
    
}

//MARK: - CatalogDetailViewController Methods

private extension CatalogDetailViewController {
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!) {
        viewModel?.selectedIndex = sender.selectedSegmentIndex
        
        guard let price = viewModel?.getPrice() else { return }
        
        catalogDetailView.priceLabel.text = "\(price) $"
    }
    
    @objc func addToCart() {
        guard let product = viewModel?.product, let count = viewModel?.count else { return }
        
        guard let price = viewModel?.getPrice() else { return }
        
        var position = Position(id: UUID().uuidString, product: product, count: count)
        
        position.product.price = price
        
        viewModel?.addPosition(position)
    }
    
    @objc func stepperValueChanged(_ stepper: UIStepper) {
        let value = Int(stepper.value)
        
        guard let count = viewModel?.getCount(value: value) else { return }
        
        catalogDetailView.countLabel.text = String(count)
    }
    
    func isCountable() {
        
        if viewModel?.product?.isCountable == true {
            catalogDetailView.segmentedController.isEnabled = true
        }
        
    }
}
