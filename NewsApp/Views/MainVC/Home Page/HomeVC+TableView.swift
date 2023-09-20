//
//  HomeVC+TableView.swift
//  NewsApp
//
//  Created by Merve Nur Nerkis on 7.09.2023.
//

import UIKit

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.backgroundColor = .clear
        
        self.registerCells()
    }
    
    func registerCells() {
        tableView.register(HomeNewCell.register(), forCellReuseIdentifier: HomeNewCell.identifier)
    }
    
    func reloadTableView() {
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        homeViewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return homeViewModel.numberOfRows(in: section)
        return cellDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeNewCell.identifier, for: indexPath) as! HomeNewCell
        let viewModel = cellDataSource[indexPath.row]

        cell.setupCell(homeViewModel: viewModel)
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNewId = cellDataSource[indexPath.row].title
        self.openDetail(newId: selectedNewId)
    }
    

}
