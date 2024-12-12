//
//  Holiday.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 06/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import  UIKit
class HolidayView : UIViewController, UITableViewDelegate, UITableViewDataSource, HolidayViewProtocol {
    func updatedLeaveDate(leaveDates: [Holiday]) {
        self.holidays = leaveDates
    }
    var holidayList : UITableView?
    var holidays = [Holiday]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return holidays.count
    }
    var chooseDate : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
        textField.text = nil
        textField.isUserInteractionEnabled = false
        textField.font = UIFont.boldSystemFont(ofSize: 20)
        textField.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        textField.textAlignment = .center
        textField.layer.masksToBounds = false
        textField.layer.cornerRadius = 20
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 0.5
        return textField
    }()
    var previousYear : UIButton = {
        let button = UIButton()
        button.setTitle("next", for: .normal)
        button.setImage(UIImage(named: "leftArrow") , for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    var nextYear : UIButton = {
        let button = UIButton()
        button.setTitle("next", for: .normal)
        button.setImage(UIImage(named: "rightArrow") , for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!HolidayCell
        cell.leaveDate.text = holidays[indexPath.row].date
        cell.leaveName.text = holidays[indexPath.row].reason
//        let animation = AnimationFactory.makeSlideIn(duration: 0.3, delayFactor: 0.01)
//        let animator = Animator(animation: animation)
//        animator.animate(cell: cell, at: indexPath, in: tableView)
        if holidays[indexPath.row].type == "OPTIONAL" {
            cell.leaveType.image = UIImage(named: "ques")
        }else {
            cell.leaveType.image = UIImage(named: "tick")
        }
        cell.backgroundColor = .clear
        return cell
    }
    var presenter : HolidayPresenterProtocol?
    var presentYear = 2019
    override func viewDidLoad() {
        super.viewDidLoad()
        holidayList = UITableView()
        HolidayRouter.createHolidayModule(holidayRef: self)
        holidayList?.register(HolidayCell.self, forCellReuseIdentifier: "cell")
        holidayList?.delegate = self
        holidayList?.dataSource = self
        presenter?.getLeaveDates(year: presentYear)
        view.addSubview(chooseDate)
        view.addSubview(previousYear)
        view.addSubview(nextYear)
        view.addSubview(holidayList!)
        chooseDate.text = String(presentYear)
        holidayList?.rowHeight = 80
        holidayList?.backgroundColor = .clear
        holidayList?.separatorStyle = .none
        view.backgroundColor = .white
        setConstrains()
        previousYear.addTarget(self, action: #selector(previousDates), for: .touchUpInside)
        nextYear.addTarget(self, action: #selector(nextDates), for: .touchUpInside)
        navigationItem.title = "Holidays"
        holidayList?.showsVerticalScrollIndicator = false
    }
    func setConstrains(){
        chooseDate.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets.init(top: 0, left: 80, bottom: 0, right: 80), size: CGSize.init(width: 0, height: 40))
         holidayList?.anchor(top: chooseDate.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 15, bottom: 0, right: 15))
        previousYear.anchor(top: chooseDate.topAnchor, leading: chooseDate.leadingAnchor, bottom: chooseDate.bottomAnchor, trailing: nil, size: CGSize(width: 25, height: 0))
        nextYear.anchor(top: chooseDate.topAnchor, leading: nil, bottom: chooseDate.bottomAnchor, trailing: chooseDate.trailingAnchor, size: CGSize(width: 25, height: 0))
        
    }
    @objc func previousDates(){
        if presentYear >= 2019 {
            presentYear = presentYear-1
            presenter?.getLeaveDates(year: presentYear)
            chooseDate.text = String(presentYear)
            holidayList?.reloadData()
        }
    }
    @objc func nextDates(){
        if presentYear <= 2019 {
            presentYear = presentYear+1
            chooseDate.text = String(presentYear)
            presenter?.getLeaveDates(year: presentYear)
            holidayList?.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.01 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })
    }
    
    
}
class HolidayCell : UITableViewCell {
    
    let leaveType : UIImageView = {
        let image = UIImageView()
      //  image.image = UIImage(named: "holidayDate")
      //  image.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "tick")
        return image
    }()
    let leaveTypeBackView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
        return view
    }()
    let leaveName : UILabel = {
        let label = UILabel()
        label.text = "HOLIDAY"
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.thin)
        return label
    }()
    let leaveDate : UILabel = {
        let label = UILabel()
        label.text = "June 6, 2019"
        label.font = UIFont(name: "Futura", size: 18)!
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        self.addSubview(leaveTypeBackView)
        self.addSubview(leaveType)
        self.addSubview(leaveName)
        self.addSubview(leaveDate)
        self.selectionStyle = .none
        
        leaveTypeBackView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 10, left: 0 , bottom: 10, right: 0), size: CGSize(width: 60, height: 0))
        leaveDate.anchor(top: self.topAnchor, leading: leaveTypeBackView.trailingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 0))
        leaveName.anchor(top: leaveDate.bottomAnchor, leading: leaveTypeBackView.trailingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 15, bottom: 0, right: 0))
        leaveType.anchor(top: leaveTypeBackView.topAnchor, leading: leaveTypeBackView.leadingAnchor, bottom: leaveTypeBackView.bottomAnchor, trailing: leaveTypeBackView.trailingAnchor,padding: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
        leaveTypeBackView.layer.cornerRadius = 30
    }
}
