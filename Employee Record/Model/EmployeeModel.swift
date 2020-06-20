//
//  EmployeeModel.swift
//  Checking MVVM
//
//  Created by user on 19/06/20.
//  Copyright © 2020 user. All rights reserved.
//

import Foundation
protocol EmployeeModelProtocol {
    func fetchEmployee(completion: @escaping (Result<[Employee], Error>) -> Void)
    func searchForEmployee(withKey key:String) -> [Employee]?
    var employees:[Employee]? {get set}
    
    
}
class EmployeeModel:EmployeeModelProtocol {
    var employees: [Employee]?
    let kbaseUrl = "http://www.mocky.io/v2/5d565297300000680030a986";
    func searchForEmployee(withKey key: String) -> [Employee]? {
        if key.count > 0 {
            return employees?.filter({(($0.name?.lowercased().contains(key))! || ($0.email?.lowercased().contains(key))!)})
        } else {
            return employees
        }
    }
    func fetchEmployee(completion: @escaping (Result<[Employee], Error>) -> Void) {
        if EmployeeLocalDBManager.sharedManager.entityIsEmpty() {
            self.getEmployeeFromServer(completion: completion)
        } else {
            self.getEmployeeFromLocal(completion: completion)
        }
    }
    
    private  func getEmployeeFromServer(completion:@escaping(Result<[Employee],Error>)->Void) {
        guard let url = URL(string: kbaseUrl) else { return }
        ApiManager.request(url: url) { [weak self] (employees:[EmployeeData]?, error) in
            if error == nil {
                guard let employeelist = employees else {return}
                
                EmployeeLocalDBManager.sharedManager.save(employees: employeelist) { (status) in
                    if status {
                        self?.getEmployeeFromLocal(completion: completion)
                    }
                }
                
            } else {
                completion(.failure(error!))
            }
            
        }
    }
    
    private func getEmployeeFromLocal(completion:@escaping(Result<[Employee],Error>)->Void) {
        
        EmployeeLocalDBManager.sharedManager.getFromLocal { [weak self] (employees, error) in
            if let employees = employees , error == nil {
                self?.employees = employees
                completion(.success(employees))
            }
            else{
                completion(.failure(error!))
            }
        }
    }
    
    
}
