//
//  File.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 21/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import  UIKit
class AttendanceDayView : UIViewController , UITableViewDelegate, UITableViewDataSource , AttendanceDayViewProtocol{
    func UpdatedAttendanceDay(AttendanceDay: AttendanceDay) {
        self.attendanceDay = AttendanceDay
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AttendacneDayDetails
        cell.titleColour.backgroundColor = color[indexPath.row]
        cell.title.text = heading[indexPath.row]
        if indexPath.row%2 == 1 {
            cell.backgroundColor = .clear
        }
        if indexPath.row == 0{
            cell.details.text = attendanceDay?.checkInTime
            cell.details.textAlignment = .center
        }else if indexPath.row == 1 {
            cell.details.text = attendanceDay?.checkOutTime
            cell.details.textAlignment = .center
        }else if indexPath.row == 2 {
            cell.details.text = "\(String(format: "%02d", (attendanceDay?.activeHours)!)):\(String(format: "%02d", (attendanceDay?.activeMinutes)!)) HRS"
        }else{
            cell.details.text = attendanceDay?.overTime
        }
     //   cell.backgroundColor = self.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
        return cell
    }
    
    let shapeLayer = CAShapeLayer()
    
    let color = [ UIColor(red: 60/255.0, green: 186/255.0, blue: 84/255.0, alpha: 0.7) , UIColor(red: 219/255.0, green: 50/255.0, blue: 54/255.0, alpha: 0.7) , UIColor(red: 244/255.0, green: 194/255.0, blue: 13/255.0, alpha: 0.7), UIColor(red: 72/255.0, green: 133/255.0, blue: 237/255.0, alpha: 0.7)]
    let heading = ["CHECK-IN TIME", "CHECK-OUT TIME" , "ACTIVE HOURS" , "OVER-TIME"]
    let timings = ["09:30 AM" ,"02:50 PM", "07:35 HRS" , "00:00 HRS"]
    var x = 5
    var y = 35
    var degree = 0.0
    var z = 0.0
    let viewBack : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.clear.cgColor
        return view
    }()
    let time : UILabel = {
        let label = UILabel()
        label.text = " 07:35"
        label.font = label.font.withSize(60)
        return label
    }()
    
    var timingDetails : UITableView!
    var presenter : AttendanceDayPresenterProtocol?
    var attendanceDay : AttendanceDay?
    var startTime :Int?
    var endTime : Int?
    var date :Int?
    
    override  func viewDidLoad() {
        super.viewDidLoad()
        AttendanceDayRouter.createAttendanceDayModule(attendanceDayRef: self)
        presenter?.getAttendanceDay(startTime: startTime!, endTime: endTime!, date: date!)
        navigationController?.navigationBar.prefersLargeTitles = false
        timingDetails = UITableView()
        view.backgroundColor = .white
        timingDetails.register(AttendacneDayDetails.self, forCellReuseIdentifier: "cell")
        timingDetails.delegate = self
        timingDetails.dataSource = self
        timingDetails.layer.masksToBounds = true
        timingDetails.layer.borderColor = UIColor.gray.cgColor
        timingDetails.layer.borderWidth = 0.1
        z = Double(( (attendanceDay?.activeHours)! + ((attendanceDay?.activeMinutes)!/60)))/9.0
        time.text = "\(String(format: "%02d", (attendanceDay?.activeHours)!)):\(String(format: "%02d", (attendanceDay?.activeMinutes)!))"
        //view.backgroundColor = .white
        
        view.addSubview(viewBack)
        view.addSubview(time)
        view.addSubview(timingDetails)
        navigationItem.title = DateController.getDateFromTimeStamp(timeStamp: Double(date!))
        addCircularPath()
       // navigationController?.navigationBar.prefersLargeTitles = true
        addConstrains()
    }
    
    
    func addCircularPath(){
     let center = CGPoint(x: 150, y: 150)
        // let center = CGPoint(x: viewBack.frame.width/4, y: viewBack.frame.height / 2)
       // view.backgroundColor = .white
        let trackLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: center, radius: 150, startAngle: -3.14/2, endAngle: CGFloat((2*3.14*(z)) - (3.14/2)), clockwise: true)
        let trackPath = UIBezierPath(arcCenter: center, radius: 150, startAngle: -CGFloat.pi/2, endAngle:  2*CGFloat.pi , clockwise: true)
        trackLayer.path = trackPath.cgPath
        trackLayer.strokeColor = UIColor(red: 235.0/255.0, green: 235/255.0, blue: 235.0/255.0, alpha: 1).cgColor
        trackLayer.lineCap = .round
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineWidth = 10
        viewBack.layer.addSublayer(trackLayer)
        
        
        
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor(red: 72.0/255.0, green: 133/255.0, blue: 237/255.0, alpha: 1).cgColor
        shapeLayer.lineCap = .round
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.strokeEnd = 0
        viewBack.layer.addSublayer(shapeLayer)
        addAnimation()
        

    }
    
    func addAnimation(){
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
    
    func addConstrains(){
        viewBack.translatesAutoresizingMaskIntoConstraints = false
        viewBack.centerXAnchor.constraint(equalTo : view.centerXAnchor).isActive = true
      //  viewBack.centerYAnchor.constraint(equalTo : view.centerYAnchor).isActive = true
        viewBack.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil , padding: UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0), size :CGSize(width: 300, height: 300))
        time.translatesAutoresizingMaskIntoConstraints = false
        time.centerXAnchor.constraint(equalTo: viewBack.centerXAnchor).isActive = true
        time.centerYAnchor.constraint(equalTo: viewBack.centerYAnchor).isActive = true
        timingDetails.anchor(top: viewBack.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 50, left: 50, bottom: 0, right: 50), size: CGSize(width: 0, height: 160))
        timingDetails.rowHeight = 40
        timingDetails.isScrollEnabled = false
        
        
    }
}

class AttendacneDayDetails : UITableViewCell {
    
    let titleColour : UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 2
        label.layer.masksToBounds = true
        return label
    }()
    
    let title : UILabel = {
        let headerText = UILabel()
        headerText.textColor = UIColor.blue
        headerText.adjustsFontSizeToFitWidth = true
        headerText.textColor = UIColor(red: 0/255.0, green: 46/255.0, blue: 110/255.0, alpha: 1)
        headerText.textAlignment = .left
        headerText.font = UIFont(name: "Futura-MediumItalic", size: 18)!
        return headerText
    }()
    
    let details : UILabel = {
        let headerText = UILabel()
        headerText.textColor = UIColor.blue
        headerText.adjustsFontSizeToFitWidth = true
        headerText.text = " 09:15 AM"
        headerText.textColor = .black
        headerText.textAlignment = .center
       // headerText.font = UIFont.boldSystemFont(ofSize: 12.0)
        headerText.backgroundColor = .clear
        return headerText
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCells()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCells(){
        self.addSubview(titleColour)
        self.addSubview(title)
        self.addSubview(details)
        self.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
        titleColour.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0), size: CGSize(width: 20, height: 0))
        title.anchor(top: self.topAnchor, leading: titleColour.trailingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0), size: CGSize(width: self.frame.width/2, height: 0))
        details.anchor(top: self.topAnchor, leading: title.trailingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0))
        self.selectionStyle = .none
    }
    
}
struct AttendanceDay {
    var activeHours : Int?
    var activeMinutes : Int?
    var checkInTime : String?
    var checkOutTime : String?
    var overTime :  String?
    var date : String?
    init(activeHours : Int, activeMinutes: Int, checkInTime : String, checkOutTime : String, overTime : String, date : String) {
        self.activeHours = activeHours
        self.activeMinutes = activeMinutes
        self.checkInTime = checkInTime
        self.checkOutTime = checkOutTime
        self.overTime = overTime
        self.date = date
    }
}
