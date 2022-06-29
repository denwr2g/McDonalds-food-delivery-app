//
//  FavouriteViewController.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 02/05/2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let profileView = ProfileView()
    var viewModel: ProfileViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        configTable()
        configNavigationItems()
        setValues()
        configActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        viewModel?.getOrders()
    }
    
    func configure(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
    }
    
    public func updateTableViewContent() {
        profileView.tableView.reloadData()
    }
    
}

//MARK: - View Configuration

private extension ProfileViewController {
    
    func configView() {
        view.addSubview(profileView)
        
        profileView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configNavigationItems() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Profile"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))
    }
    
    func configTable() {
        profileView.tableView.delegate = self
        profileView.tableView.dataSource = self
        profileView.tableView.register(UINib(nibName: "OrderCell", bundle: nil), forCellReuseIdentifier: OrderCell.identifier)
    }
    
    func setValues() {
        guard let name = viewModel?.profile?.name else { return }
        guard let address = viewModel?.profile?.address else { return }
        guard let phoneNumber = viewModel?.profile?.phone else { return }
        
        let phone = String(phoneNumber)
        
        profileView.nameLabel.text = name
        profileView.addressLabel.text = address
        profileView.phoneLabel.text = phone
    }
     
}

//MARK: - Actions Configuration

private extension ProfileViewController {
    
    func configActions() {
        viewModel?.onStartIndicator = { [weak self] in
            guard let self = self else { return }
            self.profileView.tableView.isHidden = true
            self.profileView.indicator.startAnimating()
        }
        
        viewModel?.onStopIndicator = { [weak self] in
            guard let self = self else { return }
            self.profileView.tableView.isHidden = false
            self.profileView.indicator.stopAnimating()
        }
        
        viewModel?.onShowMessage = { [weak self] in
            guard let self = self else { return }
            self.profileView.messageLabel.isHidden = false
        }
        
        viewModel?.onHideMessage = { [weak self] in
            guard let self = self else { return }
            self.profileView.messageLabel.isHidden = true
        }
        
        viewModel?.onShowAlert = { [weak self] in
            guard let self = self else { return }
            self.basicAlert(with: "Your profile has been successfully updated")
        }
    }
}

//MARK: - ProfileViewController Methods

private extension ProfileViewController {
    
    @objc func save() {
        guard let name = profileView.nameLabel.text else { return }
        guard let address = profileView.addressLabel.text else { return }
        guard let phone = profileView.phoneLabel.text else { return }
        guard let phoneNumber = Int(phone) else { return }

        
        viewModel?.updateProfile(name: name, address: address, phone: phoneNumber)
        print("Saved")
    }
}

//MARK: - TableView Methods

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = viewModel?.getOrdersCount() else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderCell.identifier, for: indexPath) as? OrderCell, let order = viewModel?.getValue(index: indexPath.row) else { return .init() }
                        
        cell.configCell(order)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
