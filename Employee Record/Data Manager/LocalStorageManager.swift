//
//  LocalStorageManager.swift
//  Checking MVVM
//
//  Created by user on 19/06/20.
//  Copyright © 2020 user. All rights reserved.
//
import CoreData
import Foundation
import UIKit
class EmployeeLocalDBManager {
    static let sharedManager = EmployeeLocalDBManager()
    
    var appdelegate:AppDelegate  {
        let appDelegate: AppDelegate
        if Thread.current.isMainThread {
            appDelegate = UIApplication.shared.delegate as! AppDelegate
        } else {
            appDelegate = DispatchQueue.main.sync {
                return UIApplication.shared.delegate as! AppDelegate
            }
        }
        return appDelegate
        
    }
    
    func save(employees:[EmployeeData],completion:(Bool)->Void) {
        let viewContext = appdelegate.persistentContainer.viewContext
        
        employees.forEach { (employee) in
            let employeeLocal =  Employee(context: viewContext)
            
            employeeLocal.id = Int16(employee.id ?? 0)
            employeeLocal.name = employee.name
            employeeLocal.username = employee.username
            employeeLocal.email = employee.email
            employeeLocal.profile_image = employee.profile_image
            employeeLocal.phone = employee.phone ?? "00000"
            employeeLocal.website = employee.website
            if let address = employee.address, let company = employee.company {
                employeeLocal.address = self.setAddress(address: address, context: viewContext)
                employeeLocal.company = self.setCompany(company: company, context: viewContext)
            }
            
        }
        do {
            try viewContext.save()
            completion(true)
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            completion(false)
        }
    }
    
    func getFromLocal(completion:@escaping(_ result:[Employee]?,_ status:Error?)->Void)
    {
        let context = appdelegate.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<Employee>  = Employee.fetchRequest()
        let nameSort = NSSortDescriptor(key:"name", ascending:true)
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.sortDescriptors = [nameSort]
        do {
            
            let result =  try context.fetch(fetchRequest)
            completion(result, nil)
        } catch let error {
            print("error: \(error)")
            completion(nil,error)
        }
        
    }
    
    func entityIsEmpty() -> Bool
    {
        let context = appdelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee")
        
        do {
            let count = try context.count(for: fetchRequest)
            if count == 0
            {
                return true
            }
            else
            {
                return false
            }
        }
        catch{
            
            return false
        }
        
    }
    
    // MARK:- Private Methods for setting address and company
    
    private func setAddress(address:AddressData,context:NSManagedObjectContext) -> Address {
        
        let addresslocal = Address(context: context)
        addresslocal.street = address.street
        addresslocal.suite = address.suite
        addresslocal.city = address.city
        addresslocal.zipcode = address.zipcode
        
        return addresslocal
        
    }
    
    private func setCompany(company:CompanyData,context:NSManagedObjectContext) -> Company {
        
        let companylocal = Company(context: context)
        companylocal.name = company.name
        companylocal.bs = company.bs
        companylocal.catchPhrase = company.catchPhrase
        
        return companylocal
        
    }
    
    
    
    
    
}
