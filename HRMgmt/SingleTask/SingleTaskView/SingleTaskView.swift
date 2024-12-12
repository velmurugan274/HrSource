//
//  SingleTaskView.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 14/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class SingleTaskView : UIViewController, SingleTaskViewProtocol{
    func setReporterName(name: String) {
        self.senderName = name
    }
    
    let backView : UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
        backView.layer.cornerRadius = 15
        return backView
        
    }()
    
    let scrollView :  UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    let senderImage : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ProfilePicture"))
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    var senderName : String?
    
    let notificationSender : UILabel  =  {
        let label = UILabel()
        label.text = "Velmurugan "
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
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
    
    let line3 : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    var From : UILabel = {
        let label = UILabel()
        label.text = "From  "
       label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        //   label.backgroundColor = UIColor(red: 137/255.0, green: 196/255.0, blue: 244/255.0, alpha: 0.2)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        // label.isHidden = true
        return label
    }()
    
    var fromDate : UILabel = {
        let label = UILabel()
        label.text = "15-Jun-2019 "
      //  label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        //   label.backgroundColor = UIColor(red: 137/255.0, green: 196/255.0, blue: 244/255.0, alpha: 0.2)

        return label
    }()
    var to : UILabel = {
        let label = UILabel()
        label.text = "To  "
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        //   label.backgroundColor = UIColor(red: 137/255.0, green: 196/255.0, blue: 244/255.0, alpha: 0.2)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        // label.isHidden = true
        return label
    }()
    var toDate : UILabel = {
        let label = UILabel()
        label.text = "15-Jun-2019 "
      //  label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
       
        return label
    }()
    
    var status : UILabel = {
        let label = UILabel()
        label.text = "Status  "
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        //   label.backgroundColor = UIColor(red: 137/255.0, green: 196/255.0, blue: 244/255.0, alpha: 0.2)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        // label.isHidden = true
        return label
    }()
    var statusText : UILabel = {
        let label = UILabel()
        label.text = "Incomplete"
        return label
    }()


    
    
    
    
    var notificationTitle : UITextView = {
        let textView = UITextView()
        textView.text = "Have a look at products currently in progress "
        textView.layer.masksToBounds = false
        textView.font = UIFont.boldSystemFont(ofSize: 18)
        //  textView.layer.cornerRadius = 5
        //   textView.layer.borderColor = UIColor.darkGray.cgColor
        textView.backgroundColor = .clear
        //   textView.layer.borderWidth = 0.5
        return textView
        
    }()
    var calendarImage :  UIImageView = {
        let imageview = UIImageView(image: UIImage(named: "calendarImage"))
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    var calendarImage1 :  UIImageView = {
        let imageview = UIImageView(image: UIImage(named: "calendarImage"))
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    var notificationDetail : UITextView = {
        let textView = UITextView()
        textView.text = "Have a look at products currently in progress and so that it will help us to ensure the current progress and help to lead a sucessful action to be in progress and hope so everthing wil be done soon. Checking the product asap heheh to that of the great"
        textView.layer.masksToBounds = false
        textView.font = UIFont.systemFont(ofSize: 15, weight: .thin)
        if let fontDescriptor = UIFontDescriptor
            .preferredFontDescriptor(withTextStyle: UIFont.TextStyle.body)
            .withSymbolicTraits(UIFontDescriptor.SymbolicTraits.traitLooseLeading) {
            let looseLeadingFont = UIFont(descriptor: fontDescriptor, size: 0)
            textView.font = looseLeadingFont
        }
        //  textView.layer.cornerRadius = 5
        //   textView.layer.borderColor = UIColor.darkGray.cgColor
        textView.backgroundColor = .clear
        //   textView.layer.borderWidth = 0.5
        return textView
        
    }()
    
    var notificationDate : UILabel = {
        let label = UILabel()
        label.text = "9 May, 12:13 PM"
        label.textColor = UIColor.gray
        label.font = label.font.withSize(15)
        return label
    }()
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    
    var submitButton : UIButton = {
        let button = UIButton()
        button.setTitle("MARK AS COMPLETED", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        button.layer.cornerRadius = 5
        return button
    }()
    
    var task : Task?
    var presenter : SingleTaskPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SingleTaskRouter.createSingleTaskModule(singleTaskRef: self)
        presenter?.getReporterName(empUuid: (task?.getEmpId())!)
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.backgroundColor = .clear
        scrollView.addSubview(backView)
        scrollView.addSubview(senderImage)

        scrollView.addSubview(notificationSender)
        scrollView.addSubview(notificationDate)
        scrollView.addSubview(line)
        scrollView.addSubview(notificationTitle)
        
        
        scrollView.addSubview(From)
        scrollView.addSubview(line1)
        scrollView.addSubview(calendarImage)
        scrollView.addSubview(fromDate)
        
        scrollView.addSubview(to)
        scrollView.addSubview(line2)
        scrollView.addSubview(calendarImage1)
        scrollView.addSubview(toDate)

        scrollView.addSubview(status)
        scrollView.addSubview(statusText)
        scrollView.addSubview(line3)
        
        scrollView.addSubview(submitButton)
        
        adjustUITextViewHeight(arg: notificationTitle)
        scrollView.addSubview(notificationDetail)
        adjustUITextViewHeight(arg: notificationDetail)
        setConstrains()
        senderImage.layer.cornerRadius = 25.0
        navigationItem.title = "Your Task"
        navigationController?.navigationBar.prefersLargeTitles = true
        statusText.text = task?.getTaskStatus().rawValue
        notificationTitle.text = task?.getTaskName()
        notificationDetail.text = task?.getTaskDetails()
        fromDate.text = DateController.getDateFromTimeStamp(timeStamp: Double((task?.getStartDate())!))
        toDate.text = DateController.getDateFromTimeStamp(timeStamp: Double((task?.getEndDate())!))
        submitButton.addTarget(self, action: #selector(changeTaskStatus), for: .touchUpInside)
        print(backView.frame.size.height)
        scrollView.contentSize = CGSize(width: view.frame.width , height: notificationTitle.frame.height+notificationDetail.frame.height+300)
      
    }

    @objc func changeTaskStatus(){
        let alert = UIAlertController(title: "Completed?", message: "Are You Sure you have completed the task?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
        }))
        let otherAction = UIAlertAction(title: "Yes", style: .destructive){action in
            // I know I need to put something in here.
            self.presenter?.markAsCompleted(taskId: (self.task?.getTaskId())!)
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(otherAction)
        self.present(alert, animated: true, completion: nil)

        
    }
    
    func setConstrains(){
        
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        senderImage.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding : UIEdgeInsets.init(top: 20, left: 23, bottom: 0, right: 0), size: CGSize.init(width: 50, height: 50))
        notificationSender.anchor(top: scrollView.topAnchor, leading: senderImage.trailingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets.init(top: 20, left: 10, bottom: 25, right: 0))
        
        notificationDate.anchor(top: nil, leading: senderImage.trailingAnchor, bottom: senderImage.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets.init(top: 0, left: 10, bottom: 8, right: 0))
        line.anchor(top: senderImage.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 15), size: CGSize(width: 0, height: 0.5))
        
        calendarImage.anchor(top: line.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 5, left: 23, bottom: 0, right: 15) , size: CGSize(width: 35, height: 0))
        From.anchor(top: calendarImage.topAnchor, leading: calendarImage.trailingAnchor, bottom: calendarImage.bottomAnchor, trailing: nil, size : CGSize(width: 0, height: 20))
        line1.anchor(top: From.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 15), size: CGSize(width: 0, height: 0.5))
        
        calendarImage1.anchor(top: line1.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 5, left: 23, bottom: 0, right: 15) , size: CGSize(width: 35, height: 0))
        to.anchor(top: calendarImage1.topAnchor, leading: calendarImage1.trailingAnchor, bottom: calendarImage1.bottomAnchor, trailing: nil, size : CGSize(width: 0, height: 20))
        line2.anchor(top: to.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 15), size: CGSize(width: 0, height: 0.5))
        
        status.anchor(top: line2.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 5, left: 28, bottom: 0, right: 15) , size: CGSize(width: 0, height: 20))
        line3.anchor(top: status.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 15), size: CGSize(width: 0, height: 0.5))
        
        fromDate.anchor(top: line.bottomAnchor, leading: status.trailingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 5, left: 28, bottom: 0, right: 15) , size: CGSize(width: 0, height: 20))
        toDate.anchor(top: line1.bottomAnchor, leading: status.trailingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 5, left: 28, bottom: 0, right: 15) , size: CGSize(width: 0, height: 20))
        
        statusText.anchor(top: line2.bottomAnchor, leading: status.trailingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 5, left: 28, bottom: 0, right: 15) , size: CGSize(width: 0, height: 20))

        
        notificationTitle.anchor(top: line3.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 23, bottom: 0, right: 10))
        notificationDetail.anchor(top: notificationTitle.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 23, bottom: 0, right: 10))
      //  print(notificationTitle.frame.height+notificationDetail.frame.height)
        
        backView.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: notificationDetail.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 15, bottom: -25, right: 15))
        submitButton.anchor(top: backView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0), size: CGSize(width: 200, height: 50))
        submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
}
