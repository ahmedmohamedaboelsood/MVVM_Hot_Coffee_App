//
//  EndPoints.swift
//  MVVMHotCoffee
//
//  Created by 2B on 21/11/2023.
//

import Foundation

//MARK: - Api Endpoints

enum EndPoints : String {
    
    case getAllOrders = "orders"
    case deleteAllOrders = "clear-orders"
}

//MARK: - Api URLs

struct ApiURL {
    
    static let getAllOrders = baseDomain + EndPoints.getAllOrders.rawValue
    static let addNewOrder = baseDomain + EndPoints.getAllOrders.rawValue
    static let deleteAllOrders = baseDomain + EndPoints.deleteAllOrders.rawValue
}
