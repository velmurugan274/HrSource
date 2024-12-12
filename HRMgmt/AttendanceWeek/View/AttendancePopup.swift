//
//  AttendancePopup.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 25/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import UIKit
class AttendancePopUp : NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AttendanceDayCell
        cell.ActiveHoursCount.text = " \(String(format: "%02d", (attend?.activeHours)!)):\(String(format: "%02d", (attend?.activeMinutes)!)) Hrs"
        cell.OverTimeHours.text = attend?.overTime
        cell.checkInTime.text = attend?.checkInTime
        cell.checkOutTime.text = attend?.checkOutTime
        cell.TitleDate.text = "\(presentStatus) - \(attend?.date ?? "NIL")"
        print("\(attend?.activeHours)+\(attend?.activeMinutes)")
        let progress = (Float((attend?.activeHours)!)+(Float((attend?.activeMinutes)!)/60))
        print(progress )
        cell.progress.setProgress(progress/9, animated: true)
        return cell
    }
    
    override init() {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AttendanceDayCell.self, forCellWithReuseIdentifier: "cell")
        
    }
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    let blackView = UIView()
    var presentStatus = "Absent"
    func showPopup(startTime : Int, endTime : Int, date : Int, presentStatus : String){
        collectionView.reloadData()
        if let window = UIApplication.shared.keyWindow {
            self.presentStatus = presentStatus
            window.addSubview(blackView)
            blackView.backgroundColor = .black
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            blackView.anchor(top: window.topAnchor, leading: window.leadingAnchor, bottom: window.bottomAnchor, trailing: window.trailingAnchor)
            blackView.alpha = 0.0
            
            window.addSubview(collectionView)
            let height : CGFloat = 200
            let y = window.frame.height - 200
            self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 0.5
                self.collectionView.frame = CGRect(x: 0, y: y, width: window.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
        }
        changePopUpValues(startTime: startTime, endTime: endTime, date: date)
    }
    var attend : AttendanceDay?
    func changePopUpValues(startTime : Int, endTime: Int, date: Int){
        let activeHours = ((endTime-startTime)%86400)/3600
        let activeMinutes = (((endTime-startTime)%86400)%3600)/60
        
        var checkInTime = DateController.getTimeFromTimeStamp(timeStamp: Double(startTime))
        if(startTime == 0){
            checkInTime = "N/A"
        }
        var checkOutTime = DateController.getTimeFromTimeStamp(timeStamp: Double(endTime))
        if endTime == 0 {
            checkOutTime = "N/A"
        }
        let overTime : String?
        if(activeHours>=9){
            overTime = " \(String(format: "%02d", activeHours-9)):\(String(format: "%02d", activeMinutes)) HRS"
        }else {
            overTime = " 00:00 Hrs"
        }
        let date = DateController.getDateFromTimeStamp(timeStamp: Double(date))
        
        attend = AttendanceDay(activeHours: activeHours, activeMinutes: activeMinutes, checkInTime: checkInTime, checkOutTime: checkOutTime, overTime: overTime!, date: date)
        
    }
    @objc func handleDismiss(){
        if let window = UIApplication.shared.keyWindow{
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 0
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200)
    }
    
}

class AttendanceDayCell : UICollectionViewCell {
    
    
    var TitleDate : UILabel = {
        let label = UILabel()
        label.text = "Present - 23 Jun 2019"
        label.font = UIFont(name: "Futura-Medium", size: 18)!
        return label
    }()
    var checkIn : UILabel = {
        let label = UILabel()
        label.text = "CHECK-IN"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    var checkOut : UILabel = {
        let day = UILabel()
        day.text = "CHECK-OUT"
        day.textColor = .black
        day.font = UIFont.boldSystemFont(ofSize: 12)
        return day
    }()
    
    var progress : UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.center = progressView.center
        progressView.setProgress(0.5, animated: true)
        progressView.trackTintColor = UIColor.lightGray
        progressView.tintColor = UIColor(red: 60.0/255.0, green: 186.0/255.0, blue: 84.0/255.0, alpha: 1)
        return progressView
    }()
    
    var checkInTime : UILabel = {
        let label = UILabel()
        label.text = "09:00 AM"
        label.font = label.font.withSize(12)
        label.textColor = .black
        return label
    }()
    
    var checkOutTime : UILabel = {
        let day = UILabel()
        day.text = "03:00 PM"
        day.textColor = .black
        day.font = day.font.withSize(12)
        return day
    }()
    
    var ActiveHours : UILabel = {
        let day = UILabel()
        day.text = "Active Hours :"
        day.textColor = .black
        day.font = UIFont.boldSystemFont(ofSize: 12)
        return day
    }()
    
    var ActiveHoursCount : UILabel = {
        let day = UILabel()
        day.text = " 05:00 Hrs"
        day.textColor = .black
        day.font = day.font.withSize(12)
        return day
    }()
    
    var OverTime : UILabel = {
        let day = UILabel()
        day.text = "Over Time      :"
        day.textColor = .black
        day.font = UIFont.boldSystemFont(ofSize: 12)
        return day
    }()
    
    var OverTimeHours : UILabel = {
        let day = UILabel()
        day.text = " 00:00 Hrs"
        day.textColor = .black
        day.font = day.font.withSize(12)
        return day
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(TitleDate)
        self.addSubview(checkIn)
        self.addSubview(checkOut)
        self.addSubview(progress)
        self.addSubview(checkInTime)
        self.addSubview(checkOutTime)
        self.addSubview(ActiveHours)
        self.addSubview(ActiveHoursCount)
        self.addSubview(OverTime)
        self.addSubview(OverTimeHours)
        setConstrians()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstrians()  {
        TitleDate.anchor(top: self.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        TitleDate.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        checkIn.anchor(top: TitleDate.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 20, left: 50, bottom: 0, right: 0))
        checkOut.anchor(top: TitleDate.bottomAnchor, leading: nil, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 50))
        progress.anchor(top: checkIn.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 70, bottom: 0, right: 70))
        checkInTime.anchor(top: progress.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 60, bottom: 0, right: 0))
        checkOutTime.anchor(top: progress.bottomAnchor, leading: nil, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 60))
        ActiveHours.anchor(top: checkInTime.bottomAnchor, leading: nil, bottom: nil, trailing: self.centerXAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        ActiveHoursCount.anchor(top: checkInTime.bottomAnchor, leading: ActiveHours.trailingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        OverTime.anchor(top: ActiveHours.bottomAnchor, leading: ActiveHours.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        OverTimeHours.anchor(top: ActiveHoursCount.bottomAnchor, leading: OverTime.trailingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
    }

    
}
