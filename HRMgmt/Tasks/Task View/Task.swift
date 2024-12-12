//
//  Task.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 26/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class  TaskView : UIViewController, UITableViewDelegate, UITableViewDataSource , TaskViewProtocol{
    func updatedIncompleteList(incomplete: [Task]) {
        print("deoooo")
        self.incompleteList = incomplete
        print(incomplete.count)
        print("Ya")
    }
    
    func updatedCompleteList(complete: [Task]) {
        self.completeList = complete
        print("lol")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getCompleteList(empUuid: empUuid!)
        presenter?.getIncompleteList(empUuid: empUuid!)
        checkEmpty()
        taskTable.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return (incompleteList?.count)!
        }
        else {
            return (completeList?.count)!
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.section == 0){
            presenter?.showTask(from: self, with: incompleteList![indexPath.row], with: false)
        }else{
            presenter?.showTask(from: self, with: completeList![indexPath.row], with:  true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TaskCell
        cell.backgroundColor = .clear
        if(indexPath.section == 0){
            cell.title.text =  incompleteList![indexPath.row].getTaskName()
            cell.titleDescription.text =  incompleteList![indexPath.row].getTaskDetails()
        }else{
            cell.title.text =  completeList![indexPath.row].getTaskName()
            cell.titleDescription.text =  completeList![indexPath.row].getTaskDetails()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if incompleteList?.count == 0{
            if section == 0 {
                return 0.0
            }
        }
        return 35.0
    }
    
    func  tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerText = UILabel()
        headerText.textColor = UIColor.blue
        headerText.adjustsFontSizeToFitWidth = true
        if (section == 1 && (self.completeList?.count) != 0) {
            headerText.text = "Completed"
        }
        else if (section == 0 && (self.incompleteList?.count) != 0){
            headerText.text = "Incomplete"
        }else  {
            tableView.separatorStyle = .none
            return UIView(frame: .zero)
        }
        

        headerText.textColor = .black
        headerText.textAlignment = .center
        headerText.font = UIFont(name: "Futura-MediumItalic", size: 20)!
        headerText.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)

        return headerText
    }
    
    var taskTable : UITableView!
    var presenter : TaskPresenterProtocol?
    var empUuid : String?
    var completeList : [Task]?
    var incompleteList : [Task]?
    var thinkView : UIImageView = {
        let thinkView = UIImageView(image: UIImage(named: "ThinkingEmoji"))
        thinkView.contentMode = .scaleAspectFit
        thinkView.isHidden = true
        thinkView.alpha = 0.5
        return thinkView
    }()
    
    var thinkText : UILabel = {
        let label = UILabel()
        label.text = "Sorry, Nothing to Show"
        label.font = UIFont(name: "Futura-Medium", size: 15)!
        label.isHidden = true
        label.textColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskRouter.createTaskModule(taskRef: self)
        presenter?.getCompleteList(empUuid: empUuid!)
        presenter?.getIncompleteList(empUuid: empUuid!)
        view.backgroundColor = .white
        taskTable = UITableView()
        taskTable.register(TaskCell.self, forCellReuseIdentifier: "cell")
        taskTable.dataSource = self
        taskTable.delegate = self
        view.addSubview(taskTable)
        view.addSubview(thinkText)
        taskTable.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        taskTable.rowHeight = 80
        navigationItem.title = " Task "
        navigationController?.navigationBar.prefersLargeTitles = true
        taskTable.backgroundColor = .clear
        taskTable.tableFooterView = UIView(frame: .zero)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonPressed))
        view.addSubview(thinkView)
        thinkView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size : CGSize(width: view.frame.width/3, height: view.frame.width/3) )
        thinkView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        thinkView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        thinkText.anchor(top: thinkView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        thinkText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        checkEmpty()
    }
    
    @objc func buttonPressed() {
        presenter?.presentCreateTask(from: self, with: empUuid!)
    }
    func checkEmpty(){
        if incompleteList?.count == 0 && completeList?.count == 0 {
            thinkView.isHidden = false
            thinkText.isHidden = false
        }else {
            thinkView.isHidden = true
            thinkText.isHidden = true
        }
    }

}
