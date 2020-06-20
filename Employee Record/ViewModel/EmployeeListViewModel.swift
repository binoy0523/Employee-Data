//
//  EmployeeListViewModel.swift
//  Checking MVVM
//
//  Created by user on 20/06/20.
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
    func didSelectEmployee(atIndex index:Int)->EmployeeDetailviewModel?
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
    
    
    //    MARK:- Protocol Conform of EmployeeListViewModelProtocol
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
        let filteredEmployees = model?.searchForEmployee(withKey: key.lowercased())
        self.setUpEmployeeVm(localList: filteredEmployees)
    }
    
    func didSelectEmployee(atIndex index: Int)->EmployeeDetailviewModel? {
        let selectedVm = self.employeeList?[index]
        if let datamodel = selectedVm?.dataModel {
            return  EmployeeDetailviewModel(employeeModel: datamodel)
        } else {
            return nil
        }
    }
    
    
    
    private  func setUpEmployeeVm(localList:[Employee]?=nil) {
        guard let localList = localList else {
            
            return
        }
        
        let vmList =  localList.map({ (employee) -> EmployeeViewModel in
            return EmployeeViewModel(employeeModel: employee)
        })
        
        self.employeeList = vmList
        
        
    }
}
