//
//  PreformanceMain.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 10/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class PerformanceMain : UIViewController, UITableViewDelegate, UITableViewDataSource, PerformanceViewProtocol {
    var presenter: PerformancePresenterProtocol?
    
    func updatedPerformanceDetails(PerformanceDetails: Performance) {
        self.recentPeformance = PerformanceDetails
    }
    
    func updatedDirectReportingDetails(reporterDetails: [People]) {
        self.directReporters = reporterDetails
    }
    
    
    var empUuid : String?
    var directReporters = [People]()
    var recentPeformance : Performance?
    
    var scrollView :  UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.isScrollEnabled = true
        return scroll
    }()
    var recentReview : UILabel = {
        let label = UILabel()
        label.text = " Your Recent Review "
       // label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Futura-MediumItalic", size: 20)!
        label.backgroundColor =  UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
        return label
    }()
    var commentsLabel : UILabel = {
        let label = UILabel()
        label.text = "Comments"
        label.backgroundColor = .white
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.font = UIFont(name: "Futura-MediumItalic", size: 18)!
        label.sizeToFit()
        return label
    }()
   
    var commentsBackView : UIView = {
        let backView = UIView()
        backView.backgroundColor = .white
        backView.layer.cornerRadius = 10
        return backView
    }()
    var comment : UITextView = {
        let textView = UITextView()
      //  textView.text = " aalaporan tamizhan ulagan elamey vetri maga vazhi dan inimey elamey veeran   "
        textView.textColor = .black
        textView.font = UIFont.systemFont(ofSize: 15)
 //       textView.layer.masksToBounds = false
//        textView.font = UIFont(name: textView.font!.fontName, size: 17)
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        //  textView.layer.cornerRadius = 5
        //   textView.layer.borderColor = UIColor.darkGray.cgColor
        textView.backgroundColor = .clear
        //   textView.layer.borderWidth = 0.5
      
        return textView
        
    }()
    var giveReviewLabel : UILabel = {
        let label = UILabel()
        label.text = " Give Review to"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Futura-MediumItalic", size: 20)!
        label.backgroundColor =  UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
        return label
    }()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == reportersList{
            return directReporters.count
            
        }else{
        return 5
        }
    }
    let performanceTitle = ["Responsiveness" , "Spontanity", "Time Management" , "Enthusaism" , "Overall Performance"]
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == lastPerformance{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PerformanceMainCell
            cell.PerformanceTitle.text = performanceTitle[indexPath.row]
            cell.selectionStyle = .none
            if(indexPath.row==0){
                cell.rating.rating =  (recentPeformance?.getResponsiveness())!
            }
            else if(indexPath.row==1){
                cell.rating.rating =  (recentPeformance?.getSpontanity())!
            }
            else if(indexPath.row==2){
                cell.rating.rating =  (recentPeformance?.getTimeManagement() )!
            }
            else if(indexPath.row==3){
                cell.rating.rating =  (recentPeformance?.getEnthusaism())!
            }
            else{
                cell.rating.rating =  (recentPeformance?.getOverallPerformance())!
            }
        return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! employeeCell
            cell.name.text = directReporters[indexPath.row].name
            cell.backgroundColor = .clear
            cell.department.text = directReporters[indexPath.row].position+"- "+directReporters[indexPath.row].department
            cell.selectionStyle = .none
            return cell
        }
    }
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    var lastPerformance : UITableView?
    var reportersList : UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        performanceMainRouter.createPerformanceModule(perfRef: self)
        presenter?.getPerformanceDetails(empUuid: empUuid!)
        presenter?.getDirectReportingDetails(empUuid: empUuid!)
        view.addSubview(scrollView)
        lastPerformance = UITableView()
        reportersList = UITableView()
        lastPerformance?.register(PerformanceMainCell.self, forCellReuseIdentifier: "cell")
        lastPerformance?.delegate = self
        lastPerformance?.dataSource = self
        lastPerformance?.backgroundColor = .clear
        lastPerformance?.separatorStyle = .none
        lastPerformance?.rowHeight = 50
        lastPerformance?.isScrollEnabled = false
        reportersList = UITableView()
       // reportersList?.register(employeeCell.self, forCellReuseIdentifier: "cell1")
        reportersList?.register(employeeCell.self, forCellReuseIdentifier: "cell1")
        reportersList?.delegate = self
        reportersList?.dataSource = self
        reportersList?.backgroundColor = .clear
        reportersList?.rowHeight = 80
        lastPerformance?.isScrollEnabled = false
        scrollView.addSubview(recentReview)
        scrollView.addSubview(lastPerformance!)
        scrollView.addSubview(commentsBackView)
        scrollView.addSubview(commentsLabel)
        scrollView.addSubview(comment)
        scrollView.addSubview(giveReviewLabel)
        scrollView.addSubview(reportersList!)
        scrollView.backgroundColor = .clear
        adjustUITextViewHeight(arg: comment)
        navigationItem.title = "Performance"
        comment.text = recentPeformance?.getComments()
        comment.isEditable = false
       
        reportersList?.delegate = self
        reportersList?.dataSource = self
       //    navigationController?.navigationBar.prefersLargeTitles = true
        comment.text = recentPeformance?.getComments()
        setConstrains()
        navigationController?.navigationBar.prefersLargeTitles = true
        scrollView.contentSize = CGSize(width: view.frame.width, height: 500+CGFloat(directReporters.count*80))
        
    }
    func setConstrains(){
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        recentReview.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size : CGSize(width: 0, height: 40))
        lastPerformance?.anchor(top: recentReview.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size : CGSize(width: 0, height: 250))
         commentsBackView.anchor(top: lastPerformance?.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 10))
        commentsLabel.anchor(top: commentsBackView.topAnchor, leading: commentsBackView.leadingAnchor, bottom: nil, trailing: commentsBackView.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 0) , size: CGSize(width: 0, height: 30))
        comment.anchor(top: commentsLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5) , size: CGSize(width: 0, height: 0))
        commentsBackView.bottomAnchor.constraint(equalTo: comment.bottomAnchor, constant: 5).isActive = true
    
        giveReviewLabel.anchor(top: commentsBackView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0), size : CGSize(width: 0, height: 40))
        reportersList?.anchor(top: giveReviewLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size : CGSize(width: 0, height: directReporters.count*80))
        reportersList?.isScrollEnabled = false
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if tableView == reportersList {
            presenter?.showGivePerformance(from: self, with: empUuid!, with: directReporters[indexPath.row].empUuid)
        }
    }
}



import Foundation
import UIKit
class PerformanceMainCell: UITableViewCell {
    var rating : RatingControl!

    var PerformanceTitle : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        //   label.backgroundColor = UIColor(red: 137/255.0, green: 196/255.0, blue: 244/255.0, alpha: 0.2)
        //label.font = UIFont.systemFont(ofSize: 15)
        label.font = UIFont(name: "Futura-MediumItalic", size: 18)!
        label.sizeToFit()
        return label
    }()
    var backView : UIView = {
        let backView = UIView()
        backView.backgroundColor = .white
        backView.layer.cornerRadius = 10
        return backView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCells()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCells(){

        rating = RatingControl()
        rating.starSize = CGSize(width: 25, height: 25)
        self.addSubview(backView)
        self.addSubview(PerformanceTitle)
        self.addSubview(rating)
        self.selectionStyle = .none
        rating.stopEditing()
        self.backgroundColor = .clear
        backView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
        PerformanceTitle.anchor(top: nil, leading: self.leadingAnchor, bottom: nil, trailing: nil,padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0) , size : CGSize(width: (self.frame.width/2)+25, height: 25))
        rating.anchor(top: nil, leading: nil, bottom: nil, trailing: self.trailingAnchor , padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 25))
        rating.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        PerformanceTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    }
}

