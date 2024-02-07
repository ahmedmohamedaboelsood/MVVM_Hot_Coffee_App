//
//  CustomDelegates.swift
//  MVVMHotCoffee
//
//  Created by 2B on 31/12/2023.
//

import Foundation

protocol AddOrderState {
    func AddOrderIsDone()
    func AddOrderIsFail(message:String)
}
