//
// EmployeeTableViewCell.swift
//  Checking MVVM
//
//  Created by user on 20/06/20.
//  Copyright © 2020 user. All rights reserved.
//
import UIKit
import SDWebImage
class EmployeeTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    Setup UI
    func setUp(withEmployeeVM employeeVM:EmployeeViewModel) {
        self.nameLabel.text = employeeVM.employeeName
        self.companyLabel.text = employeeVM.companyName
        if let profileImg = employeeVM.profileImage, let imgUrl = URL(string: profileImg) {
             self.profileImage.sd_setImage(with: imgUrl, placeholderImage:UIImage(named: "placeholder"))
        }


    }
}
