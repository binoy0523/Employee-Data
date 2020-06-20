//
// EmployeeTableViewCell.swift
//  Checking MVVM
//
//  Created by user on 20/06/20.
//  Copyright © 2020 user. All rights reserved.
//
import UIKit

class EmployeeTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUp(withEmployeeVM employeeVM:EmployeeViewModel) {
        self.nameLabel.text = employeeVM.employeeName
    }
}
