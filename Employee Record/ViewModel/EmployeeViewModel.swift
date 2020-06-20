//
//  EmployeeViewModel.swift
//  Checking MVVM
//
//  Created by user on 20/06/20.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit

class EmployeeViewModel {

    var employeeName: String?
    var profileImage : String?
    var companyName : String?
    var dataModel : Employee?
    
    init(employeeModel:Employee) {
        self.dataModel = employeeModel
        self.employeeName = employeeModel.name
        self.companyName = employeeModel.company?.name
        self.profileImage = employeeModel.profile_image
    }
    
}
