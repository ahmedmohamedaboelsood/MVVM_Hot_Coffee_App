//
//  OrdersVC.swift
//  MVVMHotCoffee
//
//  Created by 2B on 19/11/2023.
//

import UIKit

class OrdersVC: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var ordersTableView: UITableView!
    
    //MARK: - Variables
    
    var orderListViewModel = OrdersListViewModel()
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        consumeApi()
    }
    
    //MARK: - Methods
    
    private func setupUI(){
        setupOrdersTableView()
        setupNavigationBar()
    }
    
    private func consumeApi(){
        guard let url = URL(string: ApiURL.getAllOrders) else {return}
        let resources = Resources<[OrdersModel]>(url:url)
        WebServices().loadData(resources: resources) { results in
            switch results{
            case .success(let data):
                self.orderListViewModel.ordersViewModel = data.map({OrderViewModel(order: $0)})
                print(data)
                DispatchQueue.main.async {
                    self.ordersTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupOrdersTableView(){
        ordersTableView.register(UINib(nibName: OrdersTablViewCell.ID, bundle: nil), forCellReuseIdentifier: OrdersTablViewCell.ID)
        ordersTableView.delegate = self
        ordersTableView.dataSource = self
    }
    
    private func setupNavigationBar(){
        title = "Orders"
        addRightBarBtn()
    }
    
    private func addRightBarBtn(){
        let rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(rightBarBtnTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func rightBarBtnTapped(){
        navigationController?.pushViewController(AddOrdersVC(), animated: true)
    }
}

extension OrdersVC : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderListViewModel.ordersViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrdersTablViewCell.ID) as! OrdersTablViewCell
        
        let vm = orderListViewModel.orderviewModel(at: indexPath.row)
        cell.setupCell(vm)
        return cell
    }
    
}
