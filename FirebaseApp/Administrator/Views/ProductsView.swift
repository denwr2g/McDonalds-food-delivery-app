//
//  ProductsView.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 22/06/2022.
//

import Foundation
import UIKit

class ProductsView: UIView {
    
    var scrollView = UIScrollView()
    var segmentedController = NoSwipeSegmentedControl(items: ["All", "Breakfast", "Burgers", "Desserts", "Finger Foods", "Fries", "Sauces"])
    let tableView = UITableView(frame: .zero, style: .grouped)
    var indicator = UIActivityIndicatorView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addScrollView()
        addSegmentedController()
        addTableView()
        addIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .systemBackground
    }
}

private extension ProductsView {
    
    func addScrollView() {
        addSubview(scrollView)
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isUserInteractionEnabled = true
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(10)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(40)
        }
    }
    
    func addSegmentedController() {
        scrollView.addSubview(segmentedController)
        
      
        segmentedController.selectedSegmentIndex = 0
        segmentedController.backgroundColor = .white
        segmentedController.selectedSegmentTintColor = .systemCyan

        segmentedController.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentedController.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        segmentedController.addTarget(self, action: #selector(changeScrollViewPosition), for: .valueChanged)

            
        segmentedController.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.edges.equalTo(scrollView.snp.edges)
        }
    }
    
    func addTableView() {
        addSubview(tableView)
        
        tableView.isHidden = true

        tableView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(10)
        }
    }
    
    func addIndicator() {
        addSubview(indicator)
        
        indicator.style = .large
        indicator.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        indicator.hidesWhenStopped = true
        indicator.color = .systemMint
        indicator.startAnimating()
        
        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func changeScrollViewPosition(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        case 1: scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        case 2: scrollView.setContentOffset(CGPoint(x: 80 , y: 0), animated: true)
        case 3: scrollView.setContentOffset(CGPoint(x: 180, y: 0), animated: true)
        case 4: scrollView.setContentOffset(CGPoint(x: 270, y: 0), animated: true)
        case 5: scrollView.setContentOffset(CGPoint(x: 340, y: 0), animated: true)
        case 6: scrollView.setContentOffset(CGPoint(x: 340, y: 0), animated: true)
        default: scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)

        }
    }
}
