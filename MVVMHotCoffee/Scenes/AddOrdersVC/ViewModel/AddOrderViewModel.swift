//
//  AddOrderViewModel.swift
//  MVVMHotCoffee
//
//  Created by 2B on 22/11/2023.
//

import Foundation

struct AddOrderViewModel {
    
    var name : String?
    var email : String?
    var selectedType : String?
    var selectedSize : String?
    
    var type : [String] {
        return CoffeeType.allCases.map{$0.rawValue.capitalized}
    }
    
    var size : [String] {
        return CoffeeSize.allCases.map{$0.rawValue.capitalized}
    }
}
