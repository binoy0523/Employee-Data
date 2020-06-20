//
//  EmployeeDetailViewModel.swift
//  Employee Record
//
//  Created by user on 20/06/20.
//  Copyright © 2020 user. All rights reserved.
//

import Foundation
class EmployeeDetailviewModel {
    
    var employeeName: String?
    var profileImage : String?
    var userName:String?
    var email:String?
    var address:String?
    var phone:String?
    var website:String?
    var companyName : String?
    var dataModel : Employee?
    init(employeeModel:Employee) {
          self.dataModel = employeeModel
          self.employeeName = employeeModel.name
          self.companyName = employeeModel.company?.name
          self.profileImage = employeeModel.profile_image
        self.userName = employeeModel.username
        self.email = employeeModel.email
        self.phone = employeeModel.phone
        self.website = employeeModel.website
        if let addressData = employeeModel.address {
            self.address = "\(addressData.suite!) \n \(addressData.street!), \(addressData.city!) \n \(addressData.zipcode!)"
        }
      
      }
}
