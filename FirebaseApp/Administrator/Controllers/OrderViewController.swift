//
//  OrderViewController.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 27/05/2022.
//

import UIKit

class OrderViewController: UIViewController {
    
    private var orderView = OrderView()
    var viewModel: OrderViewModel?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        configItems()
        configPicker()
        configTable()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        viewModel?.shouldUpdateAdminTable()
    }
    
    func configure(viewModel: OrderViewModel) {
        self.viewModel = viewModel
    }
    
}

//MARK: - View Configuration

extension OrderViewController {
    
    private func configView() {
        view.addSubview(orderView)
        
        orderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configItems() {
        
        viewModel?.getUserData(completion: { [weak self] result in
            guard let self = self,
                  let totalCost = self.viewModel?.currentOrder?.cost,
                  let status = self.viewModel?.currentOrder?.status else { return }
            
            switch(result) {
            case .success(let user):
                self.orderView.nameLabel.text = user.name
                self.orderView.phoneLabel.text = user.textPhone
                self.orderView.addressLabel.text = user.address
                self.orderView.statusTextField.text = status
                self.orderView.totalCostLabel.text = "\(totalCost) $"
            case .failure(let error):
                print(error)
            }
        })
    }
    
    private func configPicker() {
        orderView.pickerView.delegate = self
        orderView.pickerView.dataSource = self
        
    }
    
    private func configTable() {
        orderView.tableView.delegate = self
        orderView.tableView.dataSource = self
        orderView.tableView.register(UINib(nibName: "PositionCell", bundle: nil), forCellReuseIdentifier: PositionCell.identifier)
    }
}

//MARK: - UIPickerView Methods

extension OrderViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let count = viewModel?.statuses.count else { return 0 }
        return count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel?.statuses[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let status = viewModel?.statuses[row] else { return }
        orderView.statusTextField.text = status
        orderView.statusTextField.resignFirstResponder()
        
        viewModel?.updateStatus(with: status)
    }
}

//MARK: - TableView Methods

extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        return 80
    }
    
}
