//
//  AddOrdersVC.swift
//  MVVMHotCoffee
//
//  Created by 2B on 19/11/2023.
//

import UIKit

class AddOrdersVC: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var typeTableView: UITableView!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var nameTxtField: UITextField!
    
    //MARK: - Variables
    
    private var coffeSizesSegmantedControl : UISegmentedControl!
    private var addOrderViewModel = AddOrderViewModel()
    var delegate : AddOrderState?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        self.delegate = self
        setupTableView()
        setupNavigationBar()
        setupSizeSegmantedControl()
    }
    
    private func setupSizeSegmantedControl(){
        coffeSizesSegmantedControl = UISegmentedControl(items: addOrderViewModel.size)
        coffeSizesSegmantedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(coffeSizesSegmantedControl)
        coffeSizesSegmantedControl.topAnchor.constraint(equalTo: typeTableView.bottomAnchor, constant: 20).isActive = true
        coffeSizesSegmantedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor , constant: 0).isActive = true
    }
    
    private func setupTableView(){
        typeTableView.delegate = self
        typeTableView.dataSource = self
        typeTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupNavigationBar(){
        addRightBarBtn()
    }
    
    private func addRightBarBtn(){
        let rightBarButtonItem = UIBarButtonItem(
            title: "Save",
            style: .plain,
            target: self,
            action: #selector(rightBarBtnTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func setupParamsForWebServices(){
        let name = self.nameTxtField.text
        let email = self.emailTxtField.text
        let selectedSize = self.coffeSizesSegmantedControl.titleForSegment(at: self.coffeSizesSegmantedControl.selectedSegmentIndex)
        guard let indexPath = typeTableView.indexPathForSelectedRow else {
            print("select type")
            return
        }
        
        addOrderViewModel.name = name
        addOrderViewModel.email = email
        addOrderViewModel.selectedSize = selectedSize
        addOrderViewModel.selectedType = addOrderViewModel.type[indexPath.row]
        
        WebServices().loadData(resources: OrdersModel.create(addOrderViewModel)) { results in
            switch results{
            case .success(_):
                DispatchQueue.main.async {
                    self.delegate?.AddOrderIsDone()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.delegate?.AddOrderIsFail(message: error.localizedDescription)
                }
            }
        }
    }
    
    @objc func rightBarBtnTapped(){
       setupParamsForWebServices()
    }
}

extension AddOrdersVC : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addOrderViewModel.type.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = addOrderViewModel.type[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}

extension AddOrdersVC : AddOrderState {
    func AddOrderIsDone() {
        navigationController?.popViewController(animated: true)
    }
    
    func AddOrderIsFail(message: String) {
        print(message)
    }
    
    
}
