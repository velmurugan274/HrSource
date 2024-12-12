//
//  Performance.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 27/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import  UIKit
class PerformanceMainView: UIViewController  , UITableViewDelegate , UITableViewDataSource , UITextViewDelegate , PerformanceMainViewProtocol{
    var presenter: PerformanceMainPresenterProtocol?
    var empUuid : String?
    var selectUuid : String?
    var rating : [Int] = []
    var scrollView :  UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.isScrollEnabled = true
        return scroll
    }()
    
    var commentsTitle : UILabel = {
        let label = UILabel()
        label.text = "Comments"
        label.textColor = UIColor(red: 38/255.0, green: 95/255.0, blue: 177/255.0, alpha: 1)
        label.font = UIFont(name: "Futura-MediumItalic", size: 20)!
        return label
    }()
    
    var comments : UITextView = {
        let textView = UITextView()
        textView.text = " Enter Comments"
        textView.textColor = .lightGray
        //textView.layer.masksToBounds = false
        textView.font = UIFont(name: textView.font!.fontName, size: 18)
        textView.layer.cornerRadius = 5
        textView.layer.borderColor = UIColor.darkGray.cgColor
        textView.layer.borderWidth = 0.5
        return textView
    }()
    
    var submitButton : UIButton = {
        let button = UIButton()
        button.setTitle("SUBMIT", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 72.0/255.0, green: 133/255.0, blue: 237/255.0, alpha: 1)
        return button
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
    
    var calendarImage1 :  UIImageView = {
        let imageview = UIImageView(image: UIImage(named: "calendarImage"))
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    let performanceTitle = ["Responsiveness" , "Spontanity", "Time Management" , "Enthusaism" , "Overall Performance"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PerformanceCell
        cell.PerformanceTitle.text = performanceTitle[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    var performanceTable : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        performanceGiveRouter.createPerformanceMainModule(performanceMainRef: self)
        navigationItem.title = "Preformance Review"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        scrollView.backgroundColor = .clear
        scrollView.contentSize = CGSize(width: view.frame.width, height: 1000)
        performanceTable = UITableView()
        performanceTable.register(PerformanceCell.self, forCellReuseIdentifier: "cell")
        performanceTable.delegate = self
        performanceTable.dataSource = self
        performanceTable.rowHeight = 100
        // performanceTable.isScrollEnabled = false
        view.addSubview(scrollView)
        performanceTable.backgroundColor = .clear
        performanceTable.separatorStyle = .none
        scrollView.addSubview(performanceTable)
        scrollView.addSubview(commentsTitle)
        scrollView.addSubview(comments)
        scrollView.addSubview(submitButton)
        //scrollView.contentSize = CGSize(width: view.frame.width, height: 1000)
        submitButton.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
        comments.delegate = self
        setConstrains()
        comments.isScrollEnabled = true
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboard), name: UIResponder.keyboardWillHideNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboard), name: UIResponder.keyboardWillChangeFrameNotification , object: nil)
        scrollView.contentSize = CGSize(width: self.view.frame.height, height: 1000)
    }
    func setConstrains(){
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        performanceTable.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 30, left: 30, bottom: 0, right: 30), size: CGSize(width: 0, height: 500))
        commentsTitle.anchor(top: performanceTable.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 30, bottom: 0, right: 30), size: CGSize(width: 0, height: 35))
        comments.anchor(top: commentsTitle.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 30, bottom: 0, right: 30), size: CGSize(width: 0, height: 200))
        submitButton.anchor(top: comments.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets.init(top: 20, left: 90, bottom: 0, right: 90), size: CGSize.init(width: 0, height: 50))
    }
    
    @objc func submitButtonPressed(){
        for n in 0...4 {
            let indexPath = IndexPath(row: n, section: 0)
            let cell = performanceTable.cellForRow(at: indexPath) as! PerformanceCell
            rating.append(cell.rating.rating)
            print(cell.rating.rating)
        }
        
        if(rating[0] == 0 || rating[1] == 0 || rating[2] == 0 || rating[3] == 0 || rating[4] == 0  || comments.textColor == .lightGray ){
            showToast(message: "Enter all Mandatory Fields")
            
        }
        
        else{
            let performance = Performance(empUuid: selectUuid!, responsiveness:  rating[0], spontanity: rating[1], timeManagement: rating[2], enthusaism: rating[3], overallPerformance: rating[4], comments: comments.text!)
            print(comments.text!)
            presenter?.updatePerformance(performance: performance)
            print(performance.getComments())
            scrollView.isUserInteractionEnabled = false
            addingProgress()
            addSuccessView()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                // self.navigationController?.pushViewController(profileView(), animated: true)
                self.blackView.isHidden = false
                self.progressHUD.isHidden = true
                self.sucessView.isHidden = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                // self.navigationController?.pushViewController(profileView(), animated: true)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    let sucessView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let progressHUD = ProgressHUD(text: "Applying Permission")
    
    let blackView : UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blackView = UIVisualEffectView(effect: blurEffect)
        blackView.alpha = 0.5
        return blackView
    }()
    
    
    
    func addingProgress()  {
        blackView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.addSubview(blackView)
        view.addSubview(sucessView)
        sucessView.isHidden = true
        
        self.view.addSubview(progressHUD)
        addSuccessView()
        sucessView.translatesAutoresizingMaskIntoConstraints = false
        sucessView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sucessView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        sucessView.widthAnchor.constraint(equalToConstant: view.frame.width/2.5).isActive = true
        sucessView.heightAnchor.constraint(equalToConstant: view.frame.width/2.5).isActive = true
        blackView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        blackView.isHidden = true
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
    
    
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        textView.layer.borderColor = UIColor(red: 33.0/255.0, green: 150.0/255.0, blue: 251.0/250.0, alpha: 1).cgColor
        textView.layer.borderWidth = 2
        if (textView.textColor == .lightGray)
        {
            textView.text = ""
            textView.textColor = .black
            textView.layer.borderColor = UIColor(red: 33.0/255.0, green: 150.0/255.0, blue: 251.0/250.0, alpha: 1).cgColor
        }

      //  textView.resignFirstResponder() //Optional
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        textView.layer.borderColor = UIColor.darkGray.cgColor
        textView.layer.borderWidth = 0.5
        if (textView.text == "")
        {
            textView.text = " Notification Description "
            textView.textColor = .lightGray
        }
      //  textView.resignFirstResponder()
    }
    

   
    @objc func keyboard(notification: Notification){
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = ((userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue))?.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame!, to: view.window)
        if notification.name == UIResponder.keyboardWillHideNotification{
            scrollView.contentInset = UIEdgeInsets.zero
        }else{
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: (comments.frame.height), right: 0)
            let bottomOffset = CGPoint(x: 0, y: keyboardViewEndFrame.height)
            scrollView.setContentOffset(bottomOffset, animated: true)
        }
        
        
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    
}


