//
//  Proile.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 22/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
import CallKit
import MessageUI
class ProfileView: UIViewController , UITableViewDelegate, UITableViewDataSource, ProfileViewProtocol, UIGestureRecognizerDelegate {
    func updatedReporterDetails(reporterDetails: People) {
        self.reporting = reporterDetails
    }
    
    func updatedDirectReportingDetails(reporterDetails: [People]) {
        self.directReporters = reporterDetails
    }
    
    func updatedProfileDetails(profileDetails: Profile) {
        self.profile = profileDetails
    }
    
    var presenter: ProfilePresenterProtocol?
    var profile : Profile?
    var empUuid : String?
    var selectUuid : String?
    var directReporters = [People]()
    var reporting : People?
    var status : UILabel = {
        let label = UILabel()
        label.layer.borderWidth = 1.5
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.layer.borderColor = UIColor(red: 60/255.0, green: 186/255.0, blue: 84/255.0, alpha: 0.9).cgColor
        label.textColor = UIColor(red: 60/255.0, green: 186/255.0, blue: 84/255.0, alpha: 0.9)
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.text = "IN"
        return label
    }()
    
    let profileTitles = ["Employee ID"  ,"Phone" , "E-Mail" , "Location"]
    var profileTitleValues = ["8432" ,"9094569870" , "vembu.s@zohocorp.com" , "Chennai, India"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.infoTabel{
            return 4
        }
        else if tableView == self.reportingTable {
            return 1
        }
        else{
            return directReporters.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.infoTabel{
            print(indexPath)
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! commonProfileCell
            cell.titleName.text  = profileTitles[indexPath.row]
            if indexPath.row == 0{
                cell.titleDetail.text = String(profile!.getEmpId())
            }
            else if indexPath.row == 1{
                cell.titleDetail.text = profile?.getTelNumber()
            }
            else if indexPath.row == 2{
                cell.titleDetail.text = profile?.getMailId()
            }
            else {
                cell.titleDetail.text = profile?.getLocation()
            }
            return cell
        }
        else if tableView == self.reportingTable{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as! employeeCell
            cell.name.text = reporting?.name
            cell.department.text = "\(reporting!.position) - \(reporting!.department)"
            return cell
        }else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as! employeeCell
            cell.name.text = directReporters[indexPath.row].name
            print(directReporters[indexPath.row].name+"iii")
            cell.department.text = directReporters[indexPath.row].position+" - "+directReporters[indexPath.row].department
            return cell
        }
    }
    let backView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
        //  view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    var profileName : UILabel = {
        let label = UILabel()
        label.text = "Velmurugan"
        label.font = UIFont(name: "Futura-MediumItalic", size: 30)!
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        return label
    }()
    
    var department : UILabel = {
        let label = UILabel()
        label.text = "V-Touch - Member LeaderShip Staff"
        label.font = UIFont(name: "Futura-MediumItalic", size: 15)!
        label.textColor = .gray
        return label
    }()
    
    let profilePicture : UIImageView = {
        let backView = UIImageView()
        backView.image = UIImage(named: "ProfilePicture")
        backView.layer.masksToBounds = true
        backView.layer.borderWidth = 1.5
        backView.layer.borderColor = UIColor(red: 137/255.0, green: 196/255.0, blue: 244/255.0, alpha: 0.2).cgColor
        return backView
    }()
    let callButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
        button.setImage(UIImage(named: "call"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return button
    }()
    
    let messageButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
        button.setImage(UIImage(named: "Whatsapp"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return button
    }()
    
    let mailButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
        button.setImage(UIImage(named: "mail"), for: .normal)
        
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return button
    }()
    
    let infoLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
        label.text = "INFO"
        label.font = UIFont(name: "Futura-MediumItalic", size: 20)!
        label.textAlignment = .center
        label.layer.masksToBounds = true
        return label
    }()
    
    let reportingTo : UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
        label.text = "Reporting To"
        label.font = UIFont(name: "Futura-MediumItalic", size: 20)!
        label.textAlignment = .center
        label.layer.masksToBounds = true
        return label
    }()
    
    
    let reporters : UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
        label.text = "Direct Reporters"
        label.font = UIFont(name: "Futura-MediumItalic", size: 20)!
        label.textAlignment = .center
        label.layer.masksToBounds = true
        return label
    }()
    
    var departmentName : String?
    var positionName : String?
    let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    var infoTabel : UITableView?
    let signOut : UIButton = {
        let ent = UIButton()
        ent.translatesAutoresizingMaskIntoConstraints=false
        ent.setTitleColor(.white , for: .normal)
        ent.setTitle("Sign Out" , for: .normal)
        ent.backgroundColor = UIColor(red: 219.0/255.0, green: 50.0/255.0, blue: 54.0/255.0, alpha: 1)
        ent.layer.masksToBounds = true
        ent.layer.cornerRadius = 10
        return ent
    }()
 //   var profileTable = UITableView()
    var reportersTable = UITableView()
    var reportingTable = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        navigationController?.navigationBar.prefersLargeTitles = true
        ProfileRouter.createProfileModule(profileRef: self)
        presenter?.getProfileDetails(empUuid: selectUuid!)
        presenter?.getDirectReportingDetails(empUuid: selectUuid!)
        presenter?.getReporterDetails(empUuid: (profile?.getReportingId())!)
        infoTabel = UITableView()
        infoTabel?.register(commonProfileCell.self, forCellReuseIdentifier: "cell")
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressGesture.minimumPressDuration = 0.5
        longPressGesture.delegate = self
        self.infoTabel!.addGestureRecognizer(longPressGesture)
        reportersTable.register(employeeCell.self, forCellReuseIdentifier: "Cell1")
        reportingTable.register(employeeCell.self, forCellReuseIdentifier: "Cell1")
        infoTabel?.delegate = self
        infoTabel?.dataSource = self
        view.backgroundColor = .white
      //  view.addSubview(scrollView)
        scrollView.addSubview(backView)
        scrollView.addSubview(profilePicture)
        backView.addSubview(profileName)
        backView.addSubview(department)
        scrollView.addSubview(mailButton)
        scrollView.addSubview(callButton)
        scrollView.addSubview(messageButton)
        scrollView.addSubview(infoLabel)
        scrollView.addSubview(infoTabel!)
        scrollView.addSubview(status)
        infoTabel?.isScrollEnabled = false
        infoLabel.layer.cornerRadius = 25
        messageButton.layer.cornerRadius = 30
        callButton.layer.cornerRadius = 30
        mailButton.layer.cornerRadius = 30
        infoTabel?.rowHeight = 60
        profilePicture.layer.cornerRadius = 50
        backView.layer.cornerRadius = 10
       
        if profile?.getStatus() == Status.checkOut{
            status.textColor = UIColor(red: 219/255.0, green: 50/255.0, blue: 54/255.0, alpha: 0.9)
            status.layer.borderColor = UIColor(red: 219/255.0, green: 50/255.0, blue: 54/255.0, alpha: 0.9).cgColor
            status.text = "OUT"
        }
        reportersTable.delegate = self
        reportersTable.dataSource = self
        reportingTable.dataSource = self
        reportingTable.delegate = self

        scrollView.addSubview(reportingTo)
        scrollView.addSubview(reporters)
        scrollView.addSubview(reportingTable)
        scrollView.addSubview(reportersTable)
        scrollView.addSubview(signOut)
        signOut.isHidden = true
        reportingTable.rowHeight = 80
        reportersTable.rowHeight = 80

        set()
        setConstrains()
        if(selectUuid == empUuid){
            let editImage = resizeImage(image: UIImage(named: "EditImage")!, targetSize: CGSize(width: 24, height: 24))
            let rightBarButtonItem = UIBarButtonItem.init(image: editImage, style: .plain, target: self, action: #selector(editButtonPressed) )
            self.navigationItem.rightBarButtonItem = rightBarButtonItem

            
            signOut.isHidden = false
            signOut.addTarget(self, action: #selector(showAlertWithDistructiveButton), for: .touchUpInside)
        }
    }
    @objc func editButtonPressed(){
        
    }
    func set(){
        
        
        profileName.text = profile?.getEmpName()
        department.text = "\(profile?.getDetpartmentName() ?? "Department") - \(profile?.getEmpPosition() ?? "Position")"
        navigationItem.title = profile?.getEmpName()
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == reportingTable{
            if(reporting?.name != "-"){
            presenter?.showProfile(from: self, with: empUuid!, with: (reporting?.empUuid)!)
            }
        }else if tableView == reportersTable {
            presenter?.showProfile(from: self, with: empUuid!, with: directReporters[indexPath.row].empUuid)
        }else {
            sendEmail()
        }
    }
    func setConstrains() {
       // scrollView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        profilePicture.anchor(top: scrollView.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: 100, height: 100) )
        profilePicture.layer.cornerRadius = 50
        backView.layer.cornerRadius = 10
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        profilePicture.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backView.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 60, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 180))
        profileName.anchor(top: profilePicture.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0))
        profileName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        department.anchor(top: profileName.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        department.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        status.anchor(top: department.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0), size : CGSize(width: 70, height: 25))
        status.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        status.layer.cornerRadius = 12.5
        mailButton.anchor(top: backView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0) , size: CGSize(width: 60, height: 60) )
        mailButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        callButton.anchor(top: backView.bottomAnchor, leading: nil, bottom: nil, trailing: mailButton.leadingAnchor, padding: UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20) , size: CGSize(width: 60, height: 60) )
        messageButton.anchor(top: backView.bottomAnchor, leading: mailButton.trailingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20) , size: CGSize(width: 60, height: 60) )
        infoLabel.anchor(top: messageButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 80, bottom: 0, right: 80), size: CGSize(width: 0, height: 50))
        infoTabel?.anchor(top: infoLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 240))
        
        reportingTo.anchor(top: infoTabel!.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 50))
        reportingTable.anchor(top: reportingTo.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets.init(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 80))
        reporters.anchor(top: reportingTable.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 50))
        reportersTable.anchor(top: reporters.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets.init(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: directReporters.count*80))
        signOut.anchor(top: reportersTable.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 30, left: 50, bottom: 0, right: 50), size : CGSize(width: 0, height: 50))
        

        scrollView.contentSize = CGSize(width: view.frame.width, height: (950+CGFloat(directReporters.count*80)))
        mailButton.addTarget(self, action: #selector(sendEmail), for: .touchUpInside)
        messageButton.addTarget(self, action: #selector(sendWhatsapp), for: .touchUpInside)
    }
    @objc func handleLongPress(longPressGesture:UILongPressGestureRecognizer) {
        let p = longPressGesture.location(in: self.infoTabel)
        let indexPath = self.infoTabel!.indexPathForRow(at: p)
        if indexPath == nil {
            print("Long press on table view, not row.")
        }
        else if (longPressGesture.state == UIGestureRecognizer.State.began) {
            let pasteBoard = UIPasteboard.general
            let cell = infoTabel?.cellForRow(at: indexPath!) as! commonProfileCell
             pasteBoard.string =  cell.titleDetail.text
            showToast(message: "Text Copied")
        }
    }
    @objc func showAlertWithDistructiveButton() {
        let alert = UIAlertController(title: "Sign out?", message: "You can always access your content by signing back in", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
        }))
        let otherAction = UIAlertAction(title: "Sign out", style: .destructive){action in
            // I know I need to put something in here.
            let vc = LoginView()
            let navigationController = UINavigationController(rootViewController: vc)
            self.navigationController?.present(navigationController, animated: true, completion: nil)
        }
        alert.addAction(otherAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func callNumber(phoneNumber:String) {
        
        if let phoneCallURL = URL(string: "telprompt://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                    application.openURL(phoneCallURL as URL)
                    
                }
            }
        }
    }
 
    @objc func sendEmail() {
        let email = "foo@bar.com"
        if let url = URL(string: "mailto:\(email)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    @objc func sendWhatsapp(){
        let phoneNumber =  "919094569870"
        let appURL = NSURL(string: "https://api.whatsapp.com/send?phone=\(phoneNumber)")!
        if UIApplication.shared.canOpenURL(appURL as URL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
            }
            else {
                UIApplication.shared.openURL(appURL as URL)
            }
        }
        else {
            print("Whatapp Not Installed")
        }
    }
}
