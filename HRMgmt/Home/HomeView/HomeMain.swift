//
//  ViewController.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 21/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import UIKit

class HomeView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource , HomeViewProtocol {
    func updatedNotifStatus(notifCheck: Bool) {
        print(!notifCheck)
        self.notifPresentLabel.isHidden = !notifCheck
    }
    
    func currentStatus(status: String) {
        button.setTitle(status, for: .normal)
        print(status)
    }
    
    func UpdatedActiveHours(activeHours: String) {
        self.time.text = activeHours
        print(activeHours)
    }
    
    let attendanceTitle = ["Attendance","Leave Tracker","Permission", "Holidays" ]
    var empUuid : String?
    
    var presenter : HomePresenterProtocol?
    var scrollView :  UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.isScrollEnabled = true
        return scroll
    }()
    let dateHeading : UILabel = {
        let label = UILabel()
        label.text = "TODAY"
        label.font = label.font.withSize(14)
        label.textColor = .darkGray
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
        date.textColor = .black
        date.textAlignment = .center
        //   date.font=UIFont(name: "DBLCDTempBlack", size: 60)
        return date
    }()
    var attendanceSubs : UICollectionView!
    var notificationButton : UIButton = {
        let button   = UIButton()
        button.setImage(UIImage(named: "notifButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let checkInCell : UIView = {
        let cell = UIView()
        cell.backgroundColor = UIColor(red: 137/255.0, green: 196/255.0, blue: 244/255.0, alpha: 0.2)
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 15.0
      //  cell.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!.alpha(0.2))
        cell.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
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
        label.font = UIFont(name: "Futura-Medium", size: 40)! 

        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
       // label.backgroundColor = UIColor(red: 68.0/255.0, green: 157.0/255.0, blue: 237.0/255.0, alpha: 0.5)
        return label
    }()
    let button : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 72.0/255.0, green: 133/255.0, blue: 237/255.0, alpha: 1)
        button.titleLabel?.font = UIFont(name: "Futura-Medium", size: 20)!
        return button
    }()
    
    let clock : UIImageView = {
        let image = UIImageView(image: UIImage(named: "Clock"))
        return image
    }()
    
    let notifPresentLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 158/255.0, green: 186/255.0, blue: 240/255.0, alpha: 1)
        label.layer.masksToBounds = true
        return label
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        HomeRouter.createHomeModule(homeRef: self)
        presenter?.getActiveHours(empUuid: empUuid!)
        presenter?.getCurrentStatus(empUuid: empUuid!)
        presenter?.checkNotification(empUuid: empUuid!)
        view.addSubview(scrollView)
        navigationController?.navigationBar.addSubview(notificationButton)
        scrollView.addSubview(checkInCell)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(width: view.frame.width, height: 800)
      //  view.backgroundColor = .white
        self.definesPresentationContext = true
        setupCheckInCell()
        setupAttendanceCell()
        setUpNavigationBar()
        setConstrains()
        if button.titleLabel?.text == "CHECK IN" {
            button.backgroundColor = UIColor(red: 219.0/255.0, green: 50.0/255.0, blue: 54.0/255.0, alpha: 1)
            button.setTitle("CHECK OUT", for: .normal)
        }
        else{
            button.backgroundColor = UIColor(red: 72.0/255.0, green: 133.0/255.0, blue: 237.0/255.0, alpha: 1)
            button.setTitle("CHECK IN", for: .normal)
        }
        navigationController?.navigationBar.addSubview(notifPresentLabel)
        notificationButton.anchor(top: navigationController?.navigationBar.topAnchor, leading: nil, bottom: nil, trailing: navigationController?.navigationBar.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 20), size: CGSize(width: 24, height: 24))
        notifPresentLabel.anchor(top: notificationButton.topAnchor, leading: nil, bottom: nil, trailing: notificationButton.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -2), size :CGSize(width: 12, height: 12))
        notificationButton.addTarget(self, action:#selector(pressNotificationButton(sender:)) , for: .touchUpInside)
        notifPresentLabel.layer.cornerRadius = 6
    }
    @objc func notifKey(){
        print("yes")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notificationButton.isHidden = true
        notifPresentLabel.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notificationButton.isHidden = false
        presenter?.checkNotification(empUuid: empUuid!)
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
        imageView.addTarget(self, action: #selector(pressProfileImage), for: .touchUpInside)
        imageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
        imageView.layer.cornerRadius = 17
        
       
    }
    @objc func pressNotificationButton(sender : UIButton){
        print("yes")
        presenter?.showNotification(from: self, with: empUuid!)
    }
    func setupCheckInCell(){
        checkInCell.addSubview(dateHeading)
        checkInCell.addSubview(date)
        checkInCell.addSubview(button)
        checkInCell.addSubview(clock)
        checkInCell.addSubview(time)
        checkInCell.addSubview(hoursActive)
      //  checkInCell.backgroundColor = UIColor(red: 255/255.0, green: 253/255.0, blue: 245/255.0, alpha: 1)
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
        layout.itemSize = CGSize(width: view.frame.width-40, height: 60)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 20
        attendanceSubs = UICollectionView(frame: frame, collectionViewLayout: layout)
        attendanceSubs.backgroundColor = .white
        scrollView.addSubview(attendanceSubs)
        attendanceSubs.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        attendanceSubs.backgroundColor = .clear
        attendanceSubs.isScrollEnabled = false
        attendanceSubs.delegate = self
        attendanceSubs.dataSource = self
        attendanceSubs.layer.cornerRadius = 15
    }
    
    func setConstrains(){
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        checkInCell.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: nil , trailing: view.trailingAnchor, padding: UIEdgeInsets.init(top: 30, left: 20, bottom: 0, right: 20),size: CGSize.init(width: 0, height: 300))
        attendanceSubs.anchor(top: checkInCell.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 30, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 4*100))
    }
    
    @objc func pressProfileImage(pressProfileImage : UIButton){
        presenter?.showProfile(from: self, with: empUuid!)
    }
    
    @objc func checkInChanged(){
        presenter?.getActiveHours(empUuid: empUuid!)
        presenter?.updateCurrentStatus(empUuid: empUuid!)
        presenter?.getCurrentStatus(empUuid: empUuid!)
       
        if button.titleLabel?.text == "CHECK IN" {
            button.backgroundColor = UIColor(red: 219.0/255.0, green: 50.0/255.0, blue: 54.0/255.0, alpha: 1)
            button.setTitle("CHECK OUT", for: .normal)
        }
        else{
            button.backgroundColor = UIColor(red: 72.0/255.0, green: 133.0/255.0, blue: 237.0/255.0, alpha: 1)
            button.setTitle("CHECK IN", for: .normal)
        }
         presenter?.getActiveHours(empUuid: empUuid!)
 
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        presenter?.presentHomeModules(from: self, with: indexPath.row, with: empUuid!)
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionViewCell

      //  cell.backgroundColor = .clear
        cell.label.text = attendanceTitle[indexPath.row]
        cell.image.image = UIImage(named: attendanceTitle[indexPath.row])
        return cell
    }
    
    

}

