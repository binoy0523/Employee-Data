//
//  EmployeeListViewModel.swift
//  Checking MVVM
//
//  Created by user on 19/06/20.
//  Copyright © 2020 user. All rights reserved.
//

import Foundation
protocol EmployeeListViewDelegate {
    func didLoadEmployeeList(viewModel:EmployeeListViewModelProtocol)
    func didUpdatedSearch()
}


protocol EmployeeListViewModelProtocol {
    func fetchList()
    var employeeList:[EmployeeViewModel]? {get set}
    var filteredEmployees:[EmployeeViewModel]? {get set}
    var viewDelegate: EmployeeListViewDelegate? { get set }
    var model:EmployeeModelProtocol? {get set}
    func searchFor(key:String)
}


class EmployeeListViewModel:EmployeeListViewModelProtocol {
    var filteredEmployees: [EmployeeViewModel]?

    var model: EmployeeModelProtocol?
    var employeeList: [EmployeeViewModel]? {
        didSet {
            self.viewDelegate?.didLoadEmployeeList(viewModel: self)
        }
    }
    var viewDelegate: EmployeeListViewDelegate?
    
    init(withViewDelegate viewDelegate: EmployeeListViewDelegate? = nil, withModel model:EmployeeModelProtocol? = EmployeeModel()) {
        self.viewDelegate = viewDelegate
        self.model = model
    }
    
    func fetchList() {
        self.model?.fetchEmployee( completion: { [weak self] (localResult) in
                switch localResult {
                case .success(let employees):
                    self?.setUpEmployeeVm(localList: employees)
                case .failure(let error):
                    print(error)
                }
        })
    }
    func searchFor(key: String) {
       
        let filteredEmployees = model?.searchForEmployee(withName: key.lowercased())
        self.setUpEmployeeVm(localList: filteredEmployees)
    }
    
    private  func setUpEmployeeVm(localList:[Employees]?=nil, serverList:[Employee]?=nil) {
        guard let localList = localList else {
            guard let serverList = serverList else { return }
            let vmList =  serverList.map({ (employee) -> EmployeeViewModel in
                return EmployeeViewModel(name: employee.employee_name, age: employee.employee_age, salary: employee.employee_salary)
            })
         
              self.employeeList = vmList
             
            return
        }
        
        let vmList =  localList.map({ (employee) -> EmployeeViewModel in
            return EmployeeViewModel(name: employee.employee_name, age: employee.employee_age, salary: employee.employee_salary)
        })
           
          self.employeeList = vmList

        
    }
}
