//
//  OrdersTablViewCell.swift
//  MVVMHotCoffee
//
//  Created by 2B on 22/11/2023.
//

import UIKit

class OrdersTablViewCell: UITableViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet weak var sizeLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
     
    //MARK: - Variables
    
    static let ID = String(describing: OrdersTablViewCell.self)
    
    //MARK: - Cell lifecycle
    
    override func
    awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Methods
    
    func setupCell(_ order : OrderViewModel){
        nameLbl.text = order.name
        emailLbl.text = order.email
        typeLbl.text = order.type
        sizeLbl.text = order.size
    }
}
