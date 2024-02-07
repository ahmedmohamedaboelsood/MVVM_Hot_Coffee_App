//
//  OrderViewModel.swift
//  MVVMHotCoffee
//
//  Created by 2B on 21/11/2023.
//

import Foundation

struct OrdersListViewModel{
    var ordersViewModel : [OrderViewModel]
    
    init() {
        self.ordersViewModel = [OrderViewModel]()
    }
    
    func orderviewModel(at index : Int)->OrderViewModel{
        return ordersViewModel[index]
    }
}

struct OrderViewModel{
    
    var order : OrdersModel
    
    init(order: OrdersModel) {
        self.order = order
    }
    
    var name : String {
        return order.name
    }
    
    var email : String {
        return order.email
    }
    
    var type : String {
        return order.type.rawValue.capitalized
    }
    
    var size : String {
        return order.size.rawValue.capitalized
    }
}
