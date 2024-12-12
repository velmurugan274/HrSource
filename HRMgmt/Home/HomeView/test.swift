//
//  ViewController.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 21/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import UIKit

class test : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    //    func UpdatedActiveHours(activeHours: String) {
    //        self.hoursActive.text = activeHours
    //    }
    //
    let attendanceTitle = ["Summary","Leave Tracker","Apply Leave", "Permission"]

    var scrollView :  UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.isScrollEnabled = true
        return scroll
    }()
    let dateHeading : UILabel = {
        let label = UILabel()
        label.text = "CURRENT DATE"
        label.font = label.font.withSize(14)
        label.textColor = .gray
        return label
    }()
    var hoursActive : UILabel = {
        let label = UILabel()
        label.text = "Hrs Active"
        label.font = label.font.withSize(14)
        label.textColor = .gray
        return label
    }()
    let date : UILabel = {
        let date = UILabel()
        let dates = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-YYYY"
        let result = formatter.string(from: dates)
        date.font = date.font.withSize(16)
        date.text = result
        date.textColor = .darkGray
        date.textAlignment = .center
        //   date.font=UIFont(name: "DBLCDTempBlack", size: 60)
        return date
    }()
    var attendanceSubs : UICollectionView!
    
    let checkInCell : UIView = {
        let cell = UIView()
        cell.backgroundColor = UIColor(red: 72.0/255.0, green: 133/255.0, blue: 237/255.0, alpha: 0.1)
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 15.0
        return cell
    }()
    var attendaneLabel : UILabel = {
        let label = UILabel()
        label.text = " Attendance "
        label.textColor = .black
        //  label.layer.borderColor = UIColor.darkGray.cgColor
        label.layer.masksToBounds = true
        //  label.layer.cornerRadius = 15
        label.font = UIFont(name: "Geeza PRO" , size: 20)
        label.backgroundColor =  UIColor.clear
        
        return label
    }()
    let time : UILabel = {
        let label = UILabel()
        label.text = " 07:35"
        label.font = label.font.withSize(40)
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        // label.backgroundColor = UIColor(red: 68.0/255.0, green: 157.0/255.0, blue: 237.0/255.0, alpha: 0.5)
        return label
    }()
    let button : UIButton = {
        let button = UIButton()
        button.setTitle("CHECK IN", for: .normal)
        button.backgroundColor = UIColor(red: 72.0/255.0, green: 133/255.0, blue: 237/255.0, alpha: 1)
        return button
    }()
    
    let clock : UIImageView = {
        let image = UIImageView(image: UIImage(named: "Clock"))
        return image
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // HomeRouter.createHomeModule(homeRef: self)
        view.addSubview(scrollView)
        scrollView.addSubview(checkInCell)
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 500)
        view.backgroundColor = .red
        scrollView.backgroundColor =  .green
        setConstrains()
        setupCheckInCell()
        setupAttendanceCell()
        setUpNavigationBar()
    }
    
    
    
    private func setUpNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        let imageView = UIButton(type: .custom)
        imageView.layer.masksToBounds = true
        let img  = resizeImage(image: UIImage(named: "ProfilePicture")!, targetSize: CGSize(width: 34, height: 34))
        imageView.setImage(img, for: .normal)
        imageView.contentHorizontalAlignment = .fill
        imageView.contentVerticalAlignment = .fill
        imageView.imageView?.contentMode = .scaleAspectFit
     //   imageView.addTarget(self, action: #selector(pressProfileImage), for: .touchUpInside)
        imageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
        imageView.layer.cornerRadius = 17
        //        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressSearch))
        
        let notifButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        notifButton.setBackgroundImage(resizeImage(image: UIImage(named: "notifButton")!, targetSize: CGSize(width: 25, height: 25)), for: .normal)
        notifButton.addTarget(self, action: #selector(pressNotifButton), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: notifButton)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    @objc func pressNotifButton(){
        let vc = NotificationView()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func setupCheckInCell(){
        checkInCell.addSubview(dateHeading)
        checkInCell.addSubview(date)
        checkInCell.addSubview(button)
        checkInCell.addSubview(clock)
        checkInCell.addSubview(time)
        checkInCell.addSubview(hoursActive)
        dateHeading.anchor(top: checkInCell.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))
        dateHeading.centerXAnchor.constraint(equalTo: checkInCell.centerXAnchor).isActive = true
        date.anchor(top: dateHeading.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0))
        date.centerXAnchor.constraint(equalTo: checkInCell.centerXAnchor).isActive = true
        clock.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size : CGSize(width: 80, height: 80) )
        clock.centerXAnchor.constraint(equalTo: checkInCell.centerXAnchor).isActive = true
        clock.centerYAnchor.constraint(equalTo: checkInCell.centerYAnchor, constant : -25).isActive = true
        time.anchor(top: clock.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        time.centerXAnchor.constraint(equalTo: checkInCell.centerXAnchor).isActive = true
        hoursActive.anchor(top: time.bottomAnchor, leading: nil, bottom: nil, trailing: nil)
        hoursActive.centerXAnchor.constraint(equalTo: checkInCell.centerXAnchor).isActive = true
        button.anchor(top: nil, leading: checkInCell.leadingAnchor, bottom: checkInCell.bottomAnchor, trailing: checkInCell.trailingAnchor, size : CGSize(width: 0, height: 50))
        button.addTarget(self, action: #selector(checkInChanged), for: .touchUpInside)
    }
    
    func setupAttendanceCell(){
        let frame = self.view.frame
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 30, bottom: 10, right: 30)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 20
        attendanceSubs = UICollectionView(frame: frame, collectionViewLayout: layout)
        attendanceSubs.backgroundColor = .white
        scrollView.addSubview(attendanceSubs)
        attendanceSubs.register(ServicesCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        attendanceSubs.delegate = self
        attendanceSubs.dataSource = self
        attendanceSubs.layer.cornerRadius = 15
        //        attendanceSubs.layer.borderColor = UIColor.black.cgColor
        //        attendanceSubs.layer.borderWidth = 0.5
    }
    
    func setConstrains(){
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        checkInCell.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: nil , trailing: view.trailingAnchor, padding: UIEdgeInsets.init(top: 30, left: 20, bottom: 0, right: 20),size: CGSize.init(width: 0, height: 300))
        attendanceSubs.anchor(top: checkInCell.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 30, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 300))
        //   attendaneLabel.anchor(top: attendanceSubs.topAnchor, leading: attendanceSubs.leadingAnchor, bottom: nil, trailing: nil, padding:  UIEdgeInsets.init(top: -15, left: 30, bottom: 0, right: 0) ,  size: CGSize.init(width: 0, height: 30))
    }
    

    @objc func checkInChanged(){
        if button.titleLabel?.text == "CHECK IN" {
            button.backgroundColor = UIColor(red: 219.0/255.0, green: 50.0/255.0, blue: 54.0/255.0, alpha: 1)
            button.setTitle("CHECK OUT", for: .normal)
        }
        else{
            button.backgroundColor = UIColor(red: 72.0/255.0, green: 133.0/255.0, blue: 237.0/255.0, alpha: 1)
            button.setTitle("CHECK IN", for: .normal)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ServicesCollectionViewCell
        print("hell")
        cell.backgroundColor = .clear
        cell.label.text = attendanceTitle[indexPath.row]
        cell.image.image = UIImage(named: attendanceTitle[indexPath.row])
        return cell
    }
}


