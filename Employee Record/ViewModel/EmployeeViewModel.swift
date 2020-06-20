//
//  EmployeeViewModel.swift
//  Checking MVVM
//
//  Created by user on 19/06/20.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit

class EmployeeViewModel {

    var employeeName: String?
    var employeeAge : String?
    var employeeSal : String?
    
    init(name:String?,age:String?,salary:String?) {
        self.employeeName = name
        self.employeeAge = age
        self.employeeSal = salary
    }
    
}
