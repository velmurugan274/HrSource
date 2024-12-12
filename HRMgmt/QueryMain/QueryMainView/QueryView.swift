//
//  queryMainView.swift
//  zpeople
//
//  Created by vel-pt2332 on 16/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class QueryMainView : UIViewController, UITableViewDelegate, UITableViewDataSource , QueryMainViewProtocol{
    func isQueryIncharge(queryIncharge: Bool) {
        self.isQueryIncharge = queryIncharge
    }
    
    func updatedYourQueries(queries: [Query]) {
        self.query = queries
    }
    
    func updatedRespondQueries(queries: [Query]) {
        self.query = queries
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (query?.count)!
    }
    var query : [Query]?
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TaskCell
            cell.title.text = query![indexPath.row].getQuestionSubject()
            cell.titleDescription.text = query![indexPath.row].getQuestion()
            cell.profileImage.layer.cornerRadius = 25
            cell.selectionStyle = .none
            return cell

    }
    
    var empUuid : String?
    var isQueryIncharge = false
    var yourQueries : UIView = {
        let backView = UIView()
        backView.backgroundColor = .white
        backView.layer.cornerRadius = 15
        return backView
    
    }()
    var respondQueries : UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
        backView.layer.cornerRadius = 15
        return backView
        
    }()
    let yourQueryLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = " Your Queries"
        label.textAlignment = .center
        label.font = UIFont(name: "Futura-MediumItalic", size: 18)
        label.backgroundColor = UIColor(red: 216/255.0, green: 227/255.0, blue: 255/255.0, alpha: 1)
        return label
    }()
    let respondQueryLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Respond Query"
        label.textAlignment = .center
        label.backgroundColor = UIColor(red: 38/255.0, green: 95/255.0, blue: 177/255.0, alpha: 1)
        return label
    }()
    let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    let yourQueryBackLabel : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 38/255.0, green: 95/255.0, blue: 177/255.0, alpha: 1)
        return view
    }()
    let respondQueryBackLabel : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 38/255.0, green: 95/255.0, blue: 177/255.0, alpha: 1)
        return view
    }()
    var respondQueryTable : UITableView?
    var yourQueryTable : UITableView?
    var presenter : QueryMainPresenterProtocol?
    
    var blueLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 216/255.0, green: 227/255.0, blue: 255/255.0, alpha: 1)
        label.layer.masksToBounds = true
        return label
    }()
    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Your queries ", "Respond to queries"])
        sc.selectedSegmentIndex = 0
        sc.layer.masksToBounds = true
        //  sc.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        return sc
    }()
    var thinkView : UIImageView = {
        let thinkView = UIImageView(image: UIImage(named: "ThinkingEmoji"))
        thinkView.contentMode = .scaleAspectFit
        thinkView.isHidden = true
        thinkView.alpha = 0.5
        return thinkView
    }()
    
    var thinkText : UILabel = {
        let label = UILabel()
        label.text = "Sorry, Nothing to Show"
        label.font = UIFont(name: "Futura-Medium", size: 15)!
        label.isHidden = true
        label.textColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        return label
    }()
    let tableView = UITableView()
    
    @objc  func handleSegmentChange() {
        print(segmentedControl.selectedSegmentIndex)
        switch segmentedControl.selectedSegmentIndex {
            
        case 0:
            presenter?.getYourQueries(empUuid: empUuid!)
            checkEmpty()
        default:
            presenter?.getRespondingQueries(empUuid: empUuid!)
            checkEmpty()
        }
        
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        QueryMainRouter.createQueryMainModule(queryMainRef: self)
        presenter?.checkQueryIncharge(empUuid: empUuid!)
        
        if isQueryIncharge == false{
            forNormal()
        }else{
            forIncharge()
        }
        checkEmpty()
        navigationItem.title = "Queries "
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonPressed))
        view.addSubview(thinkText)
        view.addSubview(thinkView)
        thinkView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size : CGSize(width: view.frame.width/3, height: view.frame.width/3) )
        thinkView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        thinkView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        thinkText.anchor(top: thinkView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        thinkText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        checkEmpty()
    }
    
    @objc func buttonPressed(sender : UIButton) {
        let createQuery = CreateQuery()
        createQuery.empUuid = empUuid
        let query = UINavigationController(rootViewController: createQuery)
        navigationController?.present(query, animated: true, completion: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isQueryIncharge{
            if segmentedControl.selectedSegmentIndex == 0{
                presenter?.getYourQueries(empUuid: empUuid!)
            }else{
                presenter?.getRespondingQueries(empUuid: empUuid!)
            }
         
        }else{
            presenter?.getYourQueries(empUuid: empUuid!)
        }
        tableView.reloadData()
        checkEmpty()
    }
        
    func forNormal(){
        presenter?.getYourQueries(empUuid: empUuid!)
        tableView.register(TaskCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.backgroundColor =  .clear
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        view.addSubview(yourQueryLabel)
        yourQueryLabel.textColor = .black
        view.addSubview(tableView)
        yourQueryLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: CGSize(width: 0, height: 40))
        tableView.anchor(top: yourQueryLabel.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
    }
    func forIncharge(){
        presenter?.getYourQueries(empUuid: empUuid!)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TaskCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        view.addSubview(blueLabel)
        view.addSubview(segmentedControl)
        
        navigationItem.title = "Notifications"
        view.backgroundColor = .white
        tableView.backgroundColor =  .clear
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        segmentedControl.layer.cornerRadius = 15
        setConstrains()
        navigationController?.navigationBar.prefersLargeTitles = true
        segmentedControl.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        tableView.bounces = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonPressed(sender:)))
        blueLabel.anchor(top: segmentedControl.topAnchor, leading: nil, bottom: segmentedControl.bottomAnchor, trailing: nil, size : CGSize(width: 20, height: 0))
        blueLabel.centerXAnchor.constraint(equalTo: segmentedControl.centerXAnchor).isActive = true
        blueLabel.layer.cornerRadius = 15.0
        setConstrains()
    }
    
    func setConstrains(){
        tableView.rowHeight = 80
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20), size : CGSize(width: 0, height: 30))
        tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.segmentedControl.layer.cornerRadius = 15.0;
        self.segmentedControl.layer.borderColor = UIColor.gray.cgColor
        self.segmentedControl.layer.borderWidth = 1
        segmentedControl.tintColor = UIColor(red: 216/255.0, green: 227/255.0, blue: 255/255.0, alpha: 1)
        segmentedControl.backgroundColor = .clear
        let textAttributes : [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont(name: "Futura-MediumItalic", size: 18)!]
        segmentedControl.setTitleTextAttributes(textAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(textAttributes, for: .selected)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        presenter?.presentSingleQuery(from: self, with: empUuid!, with: query![indexPath.row])

    }
    func checkEmpty(){
        if query?.count == 0  {
            thinkView.isHidden = false
            thinkText.isHidden = false
        }else {
            thinkView.isHidden = true
            thinkText.isHidden = true
        }
    }
    
}


