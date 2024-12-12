//
//  Attendance.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 21/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class Attendance : UIViewController ,UITableViewDelegate, UITableViewDataSource, AttendanceWeekViewProtocol {
    func updatedStartAndEndTime(startTime: Int, endTime: Int) {
        self.startTime = startTime
        self.endTime = endTime
    }
    
    
    var empUuid : String!
    var activeTextField : UITextField!
    var datePicker = UIDatePicker()
    var days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    var dayDetails : calDates!
    var startTime : Int?
    var endTime : Int?
    var presenter : AttendancePresenterProtocol?
    var attendanceTable : UITableView!
    var scrollView :  UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.isScrollEnabled = true
        return scroll
    }()
    var contentRect = CGRect.zero
    let summaryTitle : UILabel = {
        let label = UILabel()
        label.text = "Summary of Hours"
        label.font = UIFont(name: "Futura-Medium", size: 20)!
        label.textColor = UIColor(red: 5.0/255.0, green: 60/255.0, blue: 73/255.0, alpha: 1)
        return label
    }()

    
    var chooseDate : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
        textField.text = nil
        textField.tintColor = .clear
       // textField.isEnabled = false
     //   textField.placeholder = "   Enter "
        textField.font = UIFont(name: "Futura-MediumItalic", size: 20)!
        textField.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        textField.textAlignment = .center
        textField.layer.masksToBounds = false
        textField.layer.cornerRadius = 20
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 0.5
        return textField
    }()
    
    let totalHours : UILabel = {
        let label = UILabel()
        label.text = " TOTAL HOURS "
        label.textAlignment = .center
        return label
    }()
    
    var hoursCount : UILabel = {
        let label = UILabel()
        label.text = "18:20"
        label.font = label.font.withSize(40)
        label.textAlignment = .center
        return label
    }()
    var previousWeek : UIButton = {
        let button = UIButton()
        button.setTitle("next", for: .normal)
        button.setImage(UIImage(named: "leftArrow") , for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    var nextWeek : UIButton = {
        let button = UIButton()
        button.setTitle("next", for: .normal)
        button.setImage(UIImage(named: "rightArrow") , for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let greenColour : UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.backgroundColor = UIColor(red: 60/255.0, green: 186/255.0, blue: 84/255.0, alpha: 0.7)
        return label
    }()
    
    let greenTitle : UILabel = {
        let headerText = UILabel()
 
        headerText.adjustsFontSizeToFitWidth = true
        headerText.text = "Present"
        headerText.font = UIFont.systemFont(ofSize: 12)

      //  headerText.font = UIFont(name: "Futura-MediumItalic", size: 18)!
        return headerText
    }()
    
    let yellowColour : UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 5
        label.backgroundColor = UIColor(red: 244/255.0, green: 194/255.0, blue: 13/255.0, alpha: 0.7)
        label.layer.masksToBounds = true
        return label
    }()
    
    let yellowTitle : UILabel = {
        let headerText = UILabel()
      //  headerText.textColor = UIColor.blue
        headerText.text = "Holiday"
        headerText.adjustsFontSizeToFitWidth = true
      //  headerText.textColor = UIColor(red: 0/255.0, green: 46/255.0, blue: 110/255.0, alpha: 1)
        headerText.textAlignment = .left
        headerText.font = UIFont.systemFont(ofSize: 12)
       // headerText.font = UIFont(name: "Futura-MediumItalic", size: 18)!
        return headerText
    }()
    
    let redColour : UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 5
        label.backgroundColor = UIColor(red: 219/255.0, green: 50/255.0, blue: 54/255.0, alpha: 0.7)
        label.layer.masksToBounds = true
        return label
    }()
    
    let redTitle : UILabel = {
        let headerText = UILabel()
       // headerText.textColor = UIColor.blue
        headerText.adjustsFontSizeToFitWidth = true
      //  headerText.textColor = UIColor(red: 219/255.0, green: 50/255.0, blue: 54/255.0, alpha: 0.7)
        headerText.text = "Absent"
        headerText.textAlignment = .left
        headerText.font = UIFont.systemFont(ofSize: 12)
       // headerText.font = UIFont(name: "Futura-MediumItalic", size: 12)!
        return headerText
    }()
    
    let color = [ UIColor(red: 60/255.0, green: 186/255.0, blue: 84/255.0, alpha: 0.7) , UIColor(red: 219/255.0, green: 50/255.0, blue: 54/255.0, alpha: 0.7) , UIColor(red: 244/255.0, green: 194/255.0, blue: 13/255.0, alpha: 0.7), UIColor(red: 72/255.0, green: 133/255.0, blue: 237/255.0, alpha: 0.7)]
    let heading = ["Present" , "Absent", "holiday"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == colourDetails {
            return 3
        }else {
        return 7
        }
    }
    let blackView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        view.isHidden = true
        return view
    }()
    var presentStatus = [String]()
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == colourDetails {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AttendacneDayDetails
            cell.titleColour.backgroundColor = color[indexPath.row]
            cell.titleColour.layer.cornerRadius = 10
            cell.title.textColor = .black
            cell.title.text = heading[indexPath.row]
            cell.title.font = UIFont.systemFont(ofSize: 15)
            cell.details.text = ""
            cell.backgroundColor = .clear
            return cell
        }
        else {
            if indexPath.row == 0{
            presentStatus.removeAll()
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "attendCell", for: indexPath) as! AttendanceCell
          //  print(dayDetails.dates[indexPath.row])
          //  print(dayDetails.dateStamp[indexPath.row])
            cell.day.text = days[indexPath.row]
            cell.date.text = String(dayDetails.dates[indexPath.row])
            cell.month.text = dayDetails.months[indexPath.row]
            cell.hoursCount.text = dayDetails.hoursCount[indexPath.row]
           // cell.backgroundColor = UIColor(red: 137/255.0, green: 196/255.0, blue: 244/255.0, alpha: 0.5)
            if(indexPath.row == 0 || indexPath.row == 6 || dayDetails.holiday[indexPath.row]){
            cell.activeStatus.backgroundColor = UIColor(red: 244/255.0, green: 194/255.0, blue: 13/255.0, alpha: 0.7)
                presentStatus.append("Holiday")
            }else if(cell.hoursCount.text == "00:00"){
                cell.activeStatus.backgroundColor = UIColor(red: 219/255.0, green: 50/255.0, blue: 54/255.0, alpha: 0.7)
                presentStatus.append("Absent")
            }
            else {
                cell.activeStatus.backgroundColor = UIColor(red: 60/255.0, green: 186/255.0, blue: 84/255.0, alpha: 0.7)
                presentStatus.append("Present")
            }
            if indexPath.row%2 == 0{
                cell.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
            }else{
                cell.backgroundColor = .white
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        presenter?.getStartAndEndTime(date: dayDetails.dateStamp[indexPath.row], empUuid: empUuid)
        print(dayDetails.dateStamp[indexPath.row])
       // presenter?.pushAttendanceDay(view: self, startTime: startTime!, endTime: endTime!, date: dayDetails.dateStamp[indexPath.row])
        attendancePopup.showPopup(startTime: startTime!, endTime: endTime!, date: dayDetails.dateStamp[indexPath.row], presentStatus: presentStatus[indexPath.row])
    }
   
    let attendancePopup = AttendancePopUp()
    
    
    var totHours = 0
    var totMins = 0
   
    var colourDetails : UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        var x = Int(date.timeIntervalSince1970)
       // x = x - (x%86400) - 19800
        date = NSDate(timeIntervalSince1970: Double(x)) as Date
      //  dayDetails = AttendanceWeekInteractor.setDates(date: Date())
        AttendanceWeekRouter.createAttendanceWeekModule(attendacneWeekRef: self)
        
        presenter?.getDateDetails(date: date, empUuid: empUuid)
        chooseDate.text = dayDetails.headDates
        colourDetails = UITableView()
        colourDetails!.register(AttendacneDayDetails.self, forCellReuseIdentifier: "cell")
        colourDetails!.delegate = self
        colourDetails!.dataSource = self
        colourDetails?.separatorStyle = .none
        scrollView.contentSize = CGSize(width: view.frame.width, height: 750)
        navigationItem.title = "Attendance"
        attendanceTable = UITableView()
        view.addSubview(scrollView)
        attendanceTable.rowHeight = 70
      //  view.backgroundColor = UIColor(red: 231.0/255.0, green: 243/255.0, blue:253/255.0, alpha: 1)
        view.backgroundColor = .white
        scrollView.backgroundColor = .clear
        attendanceTable.register(AttendanceCell.self, forCellReuseIdentifier: "attendCell")
        attendanceTable.delegate = self
        attendanceTable.dataSource = self
        scrollView.addSubview(chooseDate)
        scrollView.addSubview(totalHours)
        scrollView.addSubview(summaryTitle)
        scrollView.addSubview(hoursCount)
        scrollView.addSubview(attendanceTable)
        scrollView.addSubview(previousWeek)
        scrollView.addSubview(nextWeek)
        scrollView.addSubview(colourDetails!)
        scrollView.addSubview(greenTitle)
        scrollView.addSubview(greenColour)
        scrollView.addSubview(yellowColour)
        scrollView.addSubview(yellowTitle)
        scrollView.addSubview(redTitle)
        scrollView.addSubview(redColour)
        colourDetails?.backgroundColor = .clear
        attendanceTable.layer.cornerRadius = 10
        previousWeek.addTarget(self, action: #selector(previousDates), for: .touchUpInside)
        nextWeek.addTarget(self, action: #selector(nextDates), for: .touchUpInside)
        attendanceTable.layer.masksToBounds = true
        attendanceTable.layer.borderWidth = 0.1
        
        setupConstrains()
        chooseDate.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .allEditingEvents)
        print(dayDetails.previousDate)
        print(dayDetails.nextDate)
        getTotalHoursCount()
        scrollView.addSubview(blackView)
        hideKeyboardWhenTapped()
        blackView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
    }
    func hideKeyboardWhenTapped() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissPicker))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissPicker(){
        // self.blackBack.isHidden = true
        view.endEditing(true)
        self.blackView.isHidden = true
    }
    
    func getTotalHoursCount(){
        totHours = 0
        totMins = 0
        for i in dayDetails.hoursCount {
            totHours = totHours + Int(i.prefix(2))!
            totMins = totMins + Int(i.suffix(2))!
        }
        totHours = totHours + (totMins/60)
        totMins = (totMins%60)
        hoursCount.text = ( String(format: "%02d", totHours)+":"+String(format: "%02d", totMins))
    }
    var date = Date()
    var previousDate = Date()
    var nextDate = Date()
    var headDates = ""
    
    
    @objc func previousDates(){
        date = Calendar.current.date(byAdding: .day, value: -1, to: dayDetails.previousDate)!
        //  print(date)
        headDates = ""
        presenter?.getDateDetails(date: date, empUuid:  empUuid)
        getTotalHoursCount()
        chooseDate.text = dayDetails.headDates
        attendanceTable.reloadData()
    }
    
    func updatedDayDetails(date dayDetails : calDates){
        self.dayDetails = dayDetails
    }
    
    @objc func nextDates(){
        date = Calendar.current.date(byAdding: .day, value: 1, to: dayDetails.nextDate)!
        headDates = ""
      //  dayDetails = AttendanceWeekInteractor.setDates(date: date)
        presenter?.getDateDetails(date: date, empUuid: empUuid)
        getTotalHoursCount()
        chooseDate.text = dayDetails.headDates
        attendanceTable.reloadData()
    }
    
    
    
    func setupConstrains(){
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        chooseDate.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets.init(top: 20, left: 80, bottom: 0, right: 80), size: CGSize.init(width: 0, height: 40))
        totalHours.anchor(top: chooseDate.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: UIEdgeInsets(top: 10, left: 0 , bottom: 0, right: 0),size: CGSize(width: 200, height: 30))
        totalHours.centerXAnchor.constraint(equalTo : view.centerXAnchor).isActive = true
        hoursCount.anchor(top: totalHours.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: UIEdgeInsets(top: 0, left: 0 , bottom: 0, right: 0),size: CGSize(width: 200, height: 40))
        hoursCount.centerXAnchor.constraint(equalTo : view.centerXAnchor).isActive = true
        summaryTitle.anchor(top: hoursCount.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))
        summaryTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        attendanceTable.anchor(top: summaryTitle.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 490))
        previousWeek.anchor(top: chooseDate.topAnchor, leading: chooseDate.leadingAnchor, bottom: chooseDate.bottomAnchor, trailing: nil, size: CGSize(width: 25, height: 0))
        nextWeek.anchor(top: chooseDate.topAnchor, leading: nil, bottom: chooseDate.bottomAnchor, trailing: chooseDate.trailingAnchor, size: CGSize(width: 25, height: 0))
        
        greenColour.anchor(top: attendanceTable.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 23, left: 80, bottom: 0, right: 0), size: CGSize(width: 10, height: 10))
        greenTitle.anchor(top: attendanceTable.bottomAnchor, leading: greenColour.trailingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 20, left: 5, bottom: 0, right: 0))
        
        yellowTitle.anchor(top: attendanceTable.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))
        yellowTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        yellowColour.anchor(top: attendanceTable.bottomAnchor, leading: nil, bottom: nil, trailing: yellowTitle.leadingAnchor, padding: UIEdgeInsets(top: 23, left: 0, bottom: 0, right: 5), size: CGSize(width: 10, height: 10))
        redTitle.anchor(top: attendanceTable.bottomAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 80))
        redColour.anchor(top: attendanceTable.bottomAnchor, leading: nil, bottom: nil, trailing: redTitle.leadingAnchor, padding: UIEdgeInsets(top: 23, left: 0, bottom: 0, right: 5), size: CGSize(width: 10, height: 10))
        
        

    }

    
    @objc func dateSelected(){
        
        
    }
    
    func pickUpDate(forField Field : UITextField){
        
        // DatePicker
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker.backgroundColor = UIColor(red: 233.0/255.0, green: 233.0/255.0, blue: 233/255.0, alpha: 1)
        self.datePicker.datePickerMode = UIDatePicker.Mode.date
        self.datePicker.tintColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        Field.inputView = self.datePicker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = false
        toolBar.tintColor = .white
        toolBar.barTintColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ApplyLeaveView.doneClick ))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(ApplyLeaveView.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        Field.inputAccessoryView = toolBar
        
    }
    
    @objc func doneClick() {
        blackView.isHidden = true
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        date = datePicker.date
        presenter?.getDateDetails(date: date, empUuid: empUuid)
        activeTextField.text = dayDetails.headDates
        attendanceTable.reloadData()
        activeTextField.resignFirstResponder()
    }
    
    @objc func cancelClick() {
        
        activeTextField.resignFirstResponder()
        blackView.isHidden = true
    }
    override  func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc private func textFieldDidBeginEditing(textField : UITextField) {
        blackView.isHidden = false
        pickUpDate(forField: textField)
        activeTextField = textField
        
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get{
            return .landscape
        }
    }
    
}

struct calDates {
    var dateStamp = [1,2]
    var dates = [1,2]
    var months = ["Hi", "HEllo"]
    var hoursCount = [String]()
    var headDates : String = ""
    var previousDate : Date = Date()
    var nextDate : Date = Date()
    var holiday = [false]
}


