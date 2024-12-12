//
//  MoreView.swift
//  zpeople
//
//  Created by vel-pt2332 on 06/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class LeaveTracker : UIViewController, UITableViewDelegate, UITableViewDataSource  , LeaveTrackerViewProtocol{
    func showLeaveDates(dates: [leaveDates]) {
        self.leaveDates = dates
    }
    
    var leaveDates : [leaveDates]?
    var empUuid  : String?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let x = leaveDates?.count {
            return x
        }
        else{
          return 0
        }
    }
    var totalDays = 0
    var startDate : Double?
    var endDate : Double?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            totalDays = 0
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaveTrackerCell
        let animation = AnimationFactory.makeMoveUpWithFade(rowHeight: cell.frame.height, duration: 0.5, delayFactor: 0.05)
        let animator = Animator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
        if leaveDates![indexPath.row].startDate! == leaveDates![indexPath.row].endDate!{
        cell.leaveType.text = "\(leaveDates![indexPath.row].leaveType)"
        cell.date.text = "\(DateController.getDateFromTimeStamp(timeStamp: Double(leaveDates![indexPath.row].startDate!)))"
        }else{
            cell.leaveType.text = "\(leaveDates![indexPath.row].leaveType) "
            cell.date.text = "\(DateController.getDateFromTimeStamp(timeStamp: Double(leaveDates![indexPath.row].startDate!))) - \(DateController.getDateFromTimeStamp(timeStamp: Double(leaveDates![indexPath.row].endDate!)))"
        }
        totalDays = totalDays+((leaveDates![indexPath.row].endDate! - leaveDates![indexPath.row].startDate!)/86400)+1
        cell.day.text = String(((leaveDates![indexPath.row].endDate! - leaveDates![indexPath.row].startDate!)/86400) + 1 )
        if leaveDates![indexPath.row].leaveType != "Absent"{
            cell.leaveConvertButton.isHidden = true
        }
        cell.selectionStyle = .none
        cell.leaveConvertButton.tag = indexPath.row
        cell.leaveConvertButton.addTarget(self, action: #selector(leaveButtonPressed), for: .touchUpInside)
        if indexPath.row == (leaveDates?.count)! - 1 {
            totalAbsentDays.text = "Total Number of Absent days : \(totalDays)"
        }
        return cell
    }
    var totalAbsentDays : UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    var tableView = UITableView()
    var presenter : LeaveTrackerPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        LeaveTrackerRouter.createLeaveTrackerModule(leaveTrackerRef: self)
        presenter?.getLeaveDates(empUuid: empUuid!)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LeaveTrackerCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        view.addSubview(totalAbsentDays)
        setConstrains()
        view.backgroundColor = .white
       // tableView.backgroundColor =  UIColor(red: 137/255.0, green: 196/255.0, blue: 244/255.0, alpha: 0.2)
        self.tableView.separatorStyle = .none
        navigationItem.title = "Leave Tracker"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonPressed))
        totalAbsentDays.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 0))
        setTotalDays()
        
    }
    func setTotalDays()  {
        totalAbsentDays.text = "Total Number of Absent days : \(totalDays)"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.presenter?.getLeaveDates(empUuid: empUuid!)
        tableView.reloadData()
    }
    
    @objc func buttonPressed(sender : UIButton) {
        let applyLeave = ApplyLeaveView()        
        applyLeave.empUuid = empUuid
        self.navigationController?.pushViewController( applyLeave , animated: true)

    }
    
    private func setConstrains(){
        tableView.rowHeight = 60
        
        tableView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
    }
    @objc func leaveButtonPressed(sender : UIButton){
        
        
        startDate = Double(leaveDates![sender.tag].startDate!)
        endDate = Double(leaveDates![sender.tag].endDate!)
        presenter?.presentApplyLeave(from: self, with: startDate!, with: endDate! , with: empUuid!)
//        let leave = ApplyLeaveView()
//        leave.selectFromDate.text = DateController.getDateFromTimeStamp(timeStamp: presentDay!)
//        leave.selectToDate.text = DateController.getDateFromTimeStamp(timeStamp: presentDay!)
//        self.navigationController?.pushViewController(leave, animated: true)
    }
    
    
    
}

class LeaveTrackerCell : UITableViewCell {
    let day : UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.text = "H"
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 25
        label.textAlignment = .center
        label.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    let leaveType : UILabel = {
        let label = UILabel()
        label.text = "HOLIDAY"
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.thin)
        
        return label
    }()
    let date : UILabel = {
        let label = UILabel()
        label.text = "June 6, 2019"
        label.font = UIFont(name: "Futura-MediumItalic", size: 15)!
        return label
    }()
    
    let leaveConvertButton : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "leaveConvert"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func  setupViews(){
        let ccBorder = self.layoutMarginsGuide
        self.addSubview(day)
        self.addSubview(date)
        self.addSubview(leaveType)
        self.addSubview(leaveConvertButton)
        self.backgroundColor = .clear
        day.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: UIEdgeInsets.init(top: 5, left: 10, bottom: 5, right: 0) , size: CGSize.init(width: 50, height: 0))
        day.layer.cornerRadius = 50.0/2
        date.anchor(top: self.topAnchor, leading: day.trailingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0))
        leaveType.anchor(top: date.bottomAnchor, leading: date.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        leaveConvertButton.anchor(top: nil, leading: nil, bottom: ccBorder.bottomAnchor, trailing: ccBorder.trailingAnchor , padding: UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 10), size: CGSize.init(width: 25, height: 25))
        
        leaveConvertButton.layer.cornerRadius = 12.5
        
    }
    
    
    
}

struct leaveDates {
    var startDate : Int?
    var endDate : Int?
    var leaveType : String
    init(startDate : Int, endDate : Int, leaveType : String) {
        self.startDate = startDate
        self.endDate = endDate
        self.leaveType = leaveType
    }
}



