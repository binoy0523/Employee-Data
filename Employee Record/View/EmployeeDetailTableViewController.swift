//
//  EmployeeDetailTableViewController.swift
//  Employee Record
//
//  Created by user on 20/06/20.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit

class EmployeeDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var profileImage: CustomImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var websiteLable: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    var viewModel:EmployeeDetailviewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableView.automaticDimension

        self.setUI()
    }
    
    private func setUI(){
        self.title = viewModel?.employeeName
        if let profileImg = viewModel?.profileImage, let imgUrl = URL(string: profileImg) {
            self.profileImage.sd_setImage(with: imgUrl, placeholderImage:UIImage(named: "placeholder"))
        }
        self.nameLabel.text = viewModel?.employeeName
        self.userNameLabel.text = viewModel?.userName
        self.emailLabel.text = viewModel?.email
        self.phoneLabel.text = viewModel?.phone
        self.companyLabel.text = viewModel?.companyName
        self.websiteLable.text = viewModel?.website
        self.addressLabel.text = viewModel?.address
        
        
    }
    
    
//    Setting Height of Cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
      }
    
}
