//
//  OrdersModel.swift
//  MVVMHotCoffee
//
//  Created by 2B on 20/11/2023.
//

import Foundation

enum CoffeeType : String , Codable , CaseIterable{
    case espresso = "espresso"
    case latte = "latte"
    case cappuccino = "cappuccino"
    case cortado = "cortado"
}

enum CoffeeSize : String , Codable , CaseIterable{
    case small = "small"
    case medium = "medium"
    case large = "large"
}

struct OrdersModel : Codable{
    var name : String
    var email : String
    var type : CoffeeType
    var size : CoffeeSize
}

extension OrdersModel {
    init?(_ vm : AddOrderViewModel){
        guard let name =  vm.name,
              let email = vm.email,
              let selectedSize = CoffeeSize(rawValue:vm.selectedSize!.lowercased()),
              let selectedType = CoffeeType(rawValue:vm.selectedType!.lowercased()) else {
            return nil
        }
        
        self.name = name
        self.email = email
        self.size = selectedSize
        self.type = selectedType
    }
}

extension OrdersModel {
    
    static func create(_ vm : AddOrderViewModel ) -> Resources<OrdersModel> {
        
        let order = OrdersModel(vm)
        guard let url = URL(string: ApiURL.addNewOrder) else {fatalError("No URL")}
        
        guard let data = try? JSONEncoder().encode(order) else {fatalError("No Data")}
        var resources = Resources<OrdersModel>(url: url)
        resources.data = data
        resources.method = .post
        
        return resources
    }
}
