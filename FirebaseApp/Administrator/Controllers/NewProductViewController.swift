//
//  NewProductViewController.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 02/06/2022.
//

import UIKit

class NewProductViewController: UIViewController {
    
    var viewModel: NewProductViewModel?
    private var newProductView = NewProductView()
    private let categories = ["Breakfast", "Burgers", "Desserts", "Finger Food", "Fries", "Sauces"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        configPicker()
        configImageView()
        
        self.setupHideKeyboardOnTap()
    }
    
    func configure(viewModel: NewProductViewModel) {
        self.viewModel = viewModel
    }
}

//MARK: - View Configuraion

private extension NewProductViewController {
    
    func configView() {
        view.addSubview(newProductView)
        
        newProductView.button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        
        newProductView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configPicker() {
        newProductView.pickerView.delegate = self
        newProductView.pickerView.dataSource = self
        
    }
    
    private func configImageView() {
        newProductView.productImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped)))
    }
    
}

//MARK: - NewProductViewController Methods

private extension NewProductViewController {
    
    func openImagePicker() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func newProductAdding() {
        
        if let title = newProductView.productNameTF.textField.text,
           let descript = newProductView.productDescriptTF.textField.text,
           let priceStr = newProductView.productPriceTF.textField.text,
           let category = newProductView.productCategoryTF.textField.text {
            
            if let price = Int(priceStr) {
                
                if !title.isEmpty && !descript.isEmpty && !category.isEmpty {
                
                    let isCount = newProductView.typeSwitch.isOn ? true : false
                    
                    let product = ProductDB(title: title, price: price, descript: descript, imgUrl: "", isCountable: isCount, category: category)
                    basicAlert(with: "Product \(title) has been added successfully")
                    viewModel?.addProduct(product: product)
                    clearFields()
                } else {
                    basicAlert(with: "All fields must be filled!")
                }
            } else {
                basicAlert(with: "All fields must be filled!")
            }
        } else {
            basicAlert(with: "All fields must be filled!")
        }

    }
    
    @objc func addTapped() {
        newProductAdding()
    }
    
  
    func clearFields() {
        newProductView.productNameTF.textField.text = ""
        newProductView.productDescriptTF.textField.text = ""
        newProductView.productPriceTF.textField.text = ""
        newProductView.productCategoryTF.textField.text = ""
        newProductView.typeSwitch.isOn = false
    }
    
    
    
    @objc func tapped() {
        openImagePicker()
    }
}

//MARK: - UIImagePicker Methods

extension NewProductViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let edittedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        self.newProductView.productImageView.image = edittedImage
        
        dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - UIPickerView Methods

extension NewProductViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        newProductView.productCategoryTF.textField.text = categories[row]
        newProductView.productCategoryTF.resignFirstResponder()
        self.view.endEditing(true)

       // pickerView.resignFirstResponder()
    }
    
}
