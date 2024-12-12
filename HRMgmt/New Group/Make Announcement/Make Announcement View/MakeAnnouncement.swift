//
//  SetNotification.swift
//  zpeople
//
//  Created by vel-pt2332 on 10/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class MakeAnnouncementView: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource , UITextViewDelegate, MakeAnnouncementViewProtocol {
    func setDeptId(deptId: String) {
        self.deptId = deptId
    }
    
    func setAllDept(allDept: [String]) {
        self.allDeptId = allDept
    }
    
    var deptId : String?
    var empUuid : String?
    var allDeptId : [String]?
    var scrollView :  UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.isScrollEnabled = true
        return scroll
    }()
    var notificationTitle : UILabel = {
        let label = UILabel()
        label.text = "Notification Title"
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.font = UIFont(name: "Futura-MediumItalic", size: 15)!
        return label
    }()
    
    var setNotificationTitle : UITextField = {
        let textField = UITextField()
        textField.text = nil
        textField.placeholder = "Enter Title"
    //    label.font = UIFont(name: "Futura-MediumItalic", size: 15)!
        textField.layer.masksToBounds = false
        return textField
    }()
    var notificationDescription : UILabel = {
        let label = UILabel()
        label.text = "Enter details"
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.font = UIFont(name: "Futura-MediumItalic", size: 15)!
        return label
    }()
    
    var setNotificationDescription : UITextView = {
        let textView = UITextView()
        textView.text = "Notification Description "
        textView.textColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
        textView.font = UIFont(name: textView.font!.fontName, size: 18)
        textView.layer.masksToBounds = false
        textView.backgroundColor = .clear
        return textView
    }()
    
    var notificationType : UILabel = {
        let label = UILabel()
        label.text = "Notification Type"
        label.font = UIFont(name: "Futura-MediumItalic", size: 15)!
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
      //  label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    var setNotificationType : UITextField = {
        let textField = UITextField()
        textField.text = "Select"
        textField.textAlignment = .left
        textField.layer.masksToBounds = false
        textField.layer.cornerRadius = 5
        textField.tintColor = .clear
        return textField
    }()
    
    var submitButton : UIButton = {
        let button = UIButton()
        button.setTitle("SUBMIT", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        button.layer.cornerRadius = 5
        return button
    }()
    let sucessView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    var arrowImage :  UIImageView = {
        let imageview = UIImageView(image: UIImage(named: "arrowImage"))
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    var calendarImage :  UIImageView = {
        let imageview = UIImageView(image: UIImage(named: "calendarImage"))
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    let line : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    let line1 : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    let line2 : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    let blackBack : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        view.isHidden = true
        view.isUserInteractionEnabled = true
        return view
    }()

    
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    var presenter : MakeAnnouncementPresenterProtocol?
    
    func hideKeyboardWhenTapped() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissPicker))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissPicker(){
        // self.blackBack.isHidden = true
        view.endEditing(true)
        self.blackBack.isHidden = true
    }
    
    var notificationTypeList = ["Everyone", "Department"]
    override func viewDidLoad() {
        super.viewDidLoad()
        makeAnnouncementRouter.createMakeAnnouncementModule(makeAnnouncementRef: self)
        presenter?.getDeptId(empUuid: empUuid!)
        navigationController?.navigationBar.prefersLargeTitles = true
       // view.backgroundColor = UIColor(red: 231.0/255.0, green: 243/255.0, blue:253/255.0, alpha: 1)
        view.backgroundColor = .white
        view.addSubview(scrollView)
        
        
        scrollView.addSubview(notificationType)
        scrollView.addSubview(setNotificationType)
        setNotificationType.addSubview(arrowImage)
        scrollView.addSubview(line)
        
        scrollView.addSubview(notificationTitle)
        scrollView.addSubview(setNotificationTitle)
        scrollView.addSubview(line1)
        
        
        scrollView.addSubview(notificationDescription)
        scrollView.addSubview(setNotificationDescription)
        scrollView.addSubview(line2)
        
        scrollView.addSubview(submitButton)
        adjustUITextViewHeight(arg: setNotificationDescription)
       // scrollView.addSubview(blackBack)
        
        // scrollView.backgroundColor = .white
        // scrollView.backgroundColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 244.0/255.0, alpha: 1)
        self.navigationItem.title = "Make Announcement"
        setNotificationDescription.delegate = self
        setConstrains()
        scrollView.addSubview(blackBack)
        blackBack.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        setNotificationType.addTarget(self, action: #selector(textButton), for: .allEditingEvents)
        submitButton.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
        
        self.hideKeyboardWhenTapped()
        
    }
    func setConstrains(){
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        notificationType.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 0) , size: CGSize(width: 0, height: 20))
        setNotificationType.anchor(top: notificationType.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) , size: CGSize(width: 0, height: 40))
        line.anchor(top: setNotificationType.bottomAnchor , leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size : CGSize(width: 0, height: 0.5))
        arrowImage.anchor(top: setNotificationType.topAnchor, leading: nil, bottom: setNotificationType.bottomAnchor, trailing: setNotificationType.trailingAnchor, size : CGSize(width: 25, height: 0))

        notificationTitle.anchor(top: line.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 0) , size: CGSize(width: 0, height: 20))
        setNotificationTitle.anchor(top: notificationTitle.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) , size: CGSize(width: 0, height: 40))
        line1.anchor(top: setNotificationTitle.bottomAnchor , leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size : CGSize(width: 0, height: 0.5))
        
        
        notificationDescription.anchor(top: line1.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 0) , size: CGSize(width: 0, height: 20))
        setNotificationDescription.anchor(top: notificationDescription.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) , size: CGSize(width: 0, height: 0))
        line2.anchor(top: setNotificationDescription.bottomAnchor , leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size : CGSize(width: 0, height: 0.5))
        
        submitButton.anchor(top: setNotificationDescription.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets.init(top: 20, left: 100, bottom: 0, right: 100), size: CGSize.init(width: 0, height: 50))
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: 500)
        
     //   blackBack.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: view.trailingAnchor)
        
        
    }
    var beforeText : String?
    @objc func textButton(sender: AnyObject) {
        beforeText = sender.text
        
        blackBack.isHidden = false
        let picker: UIPickerView
        picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        picker.backgroundColor = UIColor(red: 233.0/255.0, green: 233.0/255.0, blue: 233/255.0, alpha: 1)
        
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = false
        toolBar.tintColor = .white
        toolBar.barTintColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain , target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelPicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        setNotificationType.inputView = picker
        setNotificationType.inputAccessoryView = toolBar
        
    }
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        
        if (textView.textColor == UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22))
        {
            textView.text = ""
            textView.textColor = .black
            textView.layer.borderColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1).cgColor
        }
        
        textView.becomeFirstResponder() //Optional
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if (textView.text == "")
        {
            textView.text = "Notification Description"
            textView.textColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
        }
        textView.resignFirstResponder()
    }
    
    
    
    let progressHUD = ProgressHUD(text: "Making Announcement")
    let blackView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        return view
    }()
    @objc func submitButtonPressed(){
        if setNotificationTitle.text == "" || setNotificationType.text == "" || setNotificationDescription.text == "" || setNotificationType.text == "Select" {
            showToast(message: "Please enter all valid fields")
        }
        else{
        if setNotificationType.text == "Everyone"{
            presenter?.getAllDept()
            for department in allDeptId!{
            let announcement = MakeAnnouncement(announcementType: setNotificationType.text!, announcementTitle: setNotificationTitle.text!, announcementDetails: setNotificationDescription.text, announcementDeptUuid: department)
            presenter?.updateAnnoucement(announcement: announcement, empUuid: empUuid!)
            }
        }else{
                let announcement = MakeAnnouncement(announcementType: setNotificationType.text!, announcementTitle: setNotificationTitle.text!, announcementDetails: setNotificationDescription.text, announcementDeptUuid: deptId!)
                presenter?.updateAnnoucement(announcement: announcement, empUuid: empUuid!)
            }
          //  blackView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.view.addSubview(blackView)
            self.view.addSubview(sucessView)
            sucessView.isHidden = true
            
            self.view.addSubview(progressHUD)
            addSuccessView()
            blackView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
          //  sucessView.backgroundColor = .black
            sucessView.translatesAutoresizingMaskIntoConstraints = false
            sucessView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            sucessView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            sucessView.widthAnchor.constraint(equalToConstant: view.frame.width/2.5).isActive = true
            sucessView.heightAnchor.constraint(equalToConstant: view.frame.width/2.5).isActive = true
          //  blackView.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: view.trailingAnchor)
           // blackView.backgroundColor = .black
            print("Enachu")
            blackView.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
               // self.navigationController?.pushViewController(profileView(), animated: true)
                self.blackView.isHidden = false
                self.progressHUD.isHidden = true
                self.sucessView.isHidden = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func addSuccessView(){
        let img = UIImageView(image: UIImage(named: "Success"))
        let successLabel = UILabel()
        successLabel.text = "Successful"
        successLabel.textAlignment = .center
        sucessView.addSubview(img)
        sucessView.addSubview(successLabel)
        successLabel.anchor(top: nil, leading: sucessView.leadingAnchor, bottom: sucessView.bottomAnchor, trailing: sucessView.trailingAnchor, size: CGSize(width: 0, height: 50))
        img.anchor(top: sucessView.topAnchor, leading: sucessView.leadingAnchor, bottom: successLabel.topAnchor, trailing: sucessView.trailingAnchor)
        img.contentMode = .scaleAspectFit
    }
    
    @objc func blueBorder(textField : UITextField){
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(red: 33.0/255.0, green: 150.0/255.0, blue: 251.0/250.0, alpha: 1).cgColor
    }
    
    @objc func grayBorder(textField : UITextField){
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return notificationTypeList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return notificationTypeList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenText = notificationTypeList[row]
    }
    var chosenText : String?
    
    @objc func donePicker() {
        
        setNotificationType.text = chosenText
        setNotificationType.resignFirstResponder()
        blackBack.isHidden = true
        
    }
    
    @objc func cancelPicker(){
        setNotificationType.resignFirstResponder()
        blackBack.isHidden = true
    }

}

struct MakeAnnouncement {
    var announcementType : String
    var announcementTitle : String
    var announcementDetails : String
    var announcementDeptUuid : String
    init(announcementType : String, announcementTitle : String, announcementDetails : String, announcementDeptUuid : String) {
        self.announcementType = announcementType
        self.announcementTitle = announcementTitle
        self.announcementDetails = announcementDetails
        self.announcementDeptUuid = announcementDeptUuid
    }
}
