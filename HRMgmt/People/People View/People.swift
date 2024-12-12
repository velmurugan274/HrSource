//
//  People.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 22/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class PeopleView : UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate , PeopleViewProtocol{
    var presenter: PeoplePresenterProtocol?
    var peopleList : [People]  = [People]()
    
    func updatedList(peopleDetails: [People]) {
        self.peopleList = peopleDetails
    }
    
    func updatedDeptUuid(deptUuid: String) {
        self.deptUuid = deptUuid
    }

    var empUuid : String?
    var deptUuid : String?
    
    var searchedCountry = [String]()
    var searchBar = UISearchBar()
    
    
    var blueLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 216/255.0, green: 227/255.0, blue: 255/255.0, alpha: 1)
        label.layer.masksToBounds = true
        return label
    }()
    var searching = false
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return peopleList.count
        } else {
            return peopleList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath) as! employeeCell
        
        cell.backgroundColor = .clear
        let animation = AnimationFactory.makeMoveUpWithFade(rowHeight: cell.frame.height, duration: 0.5, delayFactor: 0.05)
        let animator = Animator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
            cell.name.text = peopleList[indexPath.row].name
            cell.department.text = peopleList[indexPath.row].position+" - "+peopleList[indexPath.row].department
 
        return cell
        
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let call = UIContextualAction(style: .normal, title: "Call") { (action, view, nil) in
            print("yes")
        }
        return UISwipeActionsConfiguration(actions: [call])
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.showProfile(from: self, with: empUuid!, with: peopleList[indexPath.row].empUuid)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        segmentedControl.isHidden = false
        blueLabel.isHidden = false
    }
    
    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["   Contacts   ", " Departments   "])
        sc.selectedSegmentIndex = 0
      //  sc.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        return sc
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        segmentedControl.isHidden = true
        blueLabel.isHidden = true
    }
    
    @objc  func handleSegmentChange() {
        print(1)
        print(segmentedControl.selectedSegmentIndex)
        searchBar.text = nil
        searching = false
        switch segmentedControl.selectedSegmentIndex {
            
        case 0:
            searchBar.resignFirstResponder()
            presenter?.getCompleteList()
        default:
            searchBar.resignFirstResponder()
            presenter?.getDepartmentList(deptUuid: deptUuid!)
        }
        
        tableView.reloadData()
    }
    
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PeopleRouter.createPeopleModule(peopleRef : self)
        presenter?.getDeptUuid(empUuid: empUuid!)
        presenter?.getCompleteList()
        tableView.dataSource = self
        tableView.delegate = self
       // view.backgroundColor = UIColor(red: 231.0/255.0, green: 243/255.0, blue:253/255.0, alpha: 1)
       // navigationItem.title = "Organisation"
        view.backgroundColor = .white
        tableView.register(employeeCell.self, forCellReuseIdentifier: "cells")
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search by name, phone, mail"
      
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
 //       tableView.separatorStyle = .none
  //      view.addSubview(segmentedControl)
        
        
        navigationController?.navigationBar.addSubview(segmentedControl)
        navigationController?.navigationBar.addSubview(blueLabel)
        
        view.addSubview(tableView)
        view.addSubview(searchBar)
   //     view.addSubview(blueLabel)
        searchBar.delegate = self
        segmentedControl.tintColor = UIColor(red: 216/255.0, green: 227/255.0, blue: 255/255.0, alpha: 1)
        segmentedControl.backgroundColor = .white
        let textAttributes : [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont(name: "Futura-MediumItalic", size: 20)!]
        segmentedControl.setTitleTextAttributes(textAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(textAttributes, for: .selected)
       



        searchBar.searchBarStyle = UISearchBar.Style.minimal

       segmentedControl.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        
        
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant : 50).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.backgroundColor = .clear
        
        self.segmentedControl.layer.masksToBounds = true
        tableView.rowHeight = 80
        self.segmentedControl.layer.cornerRadius = 15.0;
        self.segmentedControl.layer.borderColor = UIColor.gray.cgColor
        self.segmentedControl.layer.borderWidth = 1
        segmentedControl.centerXAnchor.constraint(equalTo: (navigationController?.navigationBar.centerXAnchor)!).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant : 30).isActive = true
        blueLabel.anchor(top: segmentedControl.topAnchor, leading: nil, bottom: segmentedControl.bottomAnchor, trailing: nil, size : CGSize(width: 20, height: 0))
        blueLabel.centerXAnchor.constraint(equalTo: segmentedControl.centerXAnchor).isActive = true
        blueLabel.layer.cornerRadius = 15.0
        tableView.tableFooterView = UIView(frame: .zero)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        presenter?.getSearchedList(search: searchText)
        searching = true
        tableView.reloadData()
        view.reloadInputViews()
    }
}
