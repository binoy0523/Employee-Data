//
//  EmployeeModel.swift
//  Checking MVVM
//
//  Created by user on 19/06/20.
//  Copyright © 2020 user. All rights reserved.
//

import Foundation
protocol EmployeeModelProtocol {
    func fetchEmployee(completion: @escaping (Result<[Employees], Error>) -> Void)
    func searchForEmployee(withName name:String) -> [Employees]?
    var employees:[Employees]? {get set}
    
}
class EmployeeModel:EmployeeModelProtocol {
    var employees: [Employees]?
    
    func searchForEmployee(withName name: String) -> [Employees]? {
        if name.count > 0 {
            return employees?.filter({($0.employee_name?.lowercased().contains(name))!})
        } else {
            return employees
        }
    }
    func fetchEmployee(completion: @escaping (Result<[Employees], Error>) -> Void) {
        if LocalStorageManager.sharedManager.entityIsEmpty() {
            self.getEmployeeFromServer(completion: completion)
        } else {
            self.getEmployeeFromLocal(completion: completion)
        }
    }

   private  func getEmployeeFromServer(completion:@escaping(Result<[Employees],Error>)->Void) {
        
        ApiManager.request(endPoint: .Employee) { [weak self] (employees:[Employee]?, error) in
            if error == nil {
                guard let employeelist = employees else {return}
                
                LocalStorageManager.sharedManager.save(employees: employeelist) { (status) in
                    if status {
                        self?.getEmployeeFromLocal(completion: completion)
                    }
                }
               
            } else {
                completion(.failure(error!))
            }
            
        }
    }
    
    private func getEmployeeFromLocal(completion:@escaping(Result<[Employees],Error>)->Void) {
        
        LocalStorageManager.sharedManager.getFromLocal { [weak self] (employees, error) in
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
