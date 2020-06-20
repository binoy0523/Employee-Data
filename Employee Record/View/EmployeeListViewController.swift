//
//  ViewController.swift
//  Employee Record
//
//  Created by user on 20/06/20.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit

class EmployeeListTableViewController: UITableViewController {
    
    
    private var viewModel :EmployeeListViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Employees"
        setUpViewModel()
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
    }
    
    func setUpViewModel() {
        viewModel = EmployeeListViewModel(withViewDelegate: self)
        viewModel.fetchList()
    }
    
    
    
//MARK:-    UITableView DataSource & Delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.employeeList?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath)
        
        if let cell = cell as? EmployeeTableViewCell, let employeeVM = viewModel.employeeList?[indexPath.row] {
            cell.setUp(withEmployeeVM: employeeVM)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVc = self.storyboard?.instantiateViewController(identifier: "EmployeeDetailTableViewController") as! EmployeeDetailTableViewController
        detailVc.viewModel =  viewModel.didSelectEmployee(atIndex: indexPath.row)
        self.navigationController?.pushViewController(detailVc, animated: true)
        
    }
}


//MARK:-    View Delegate
extension EmployeeListTableViewController:EmployeeListViewDelegate {
    
    func didLoadEmployeeList(viewModel: EmployeeListViewModelProtocol) {
        self.tableView.reloadData()
    }
    
    func didUpdatedSearch() {
        
    }
    
}


//MARK:-   Search updating Delegate
extension EmployeeListTableViewController:UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        viewModel.searchFor(key: text)
    }
}
