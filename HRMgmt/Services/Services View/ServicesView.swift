//
//  ServicesView.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 24/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class ServicesView : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var empUuid : String?
    
    var servicesList = ["Tasks","Performance","Announce","Queries", "Payroll" , "Insurance", "Files", "Feedback"]
    var personalList = ["Payroll", "Insurance" , "Files" , "Feedback"]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    var presenter : ServicesPresenterProtocol?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ServicesCollectionViewCell
       // cell.backgroundColor = UIColor(red: 137/255.0, green: 196/255.0, blue: 244/255.0, alpha: 0.2)
      //  cell.backgroundColor = .clear
        if collectionView == self.servicesCollection{
        cell.label.text = servicesList[indexPath.row]
        cell.image.image = UIImage(named:  servicesList[indexPath.row])
        }
        else {
            cell.label.text = personalList[indexPath.row]
            cell.image.image = UIImage(named:  personalList[indexPath.row])
        }
        return cell
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    var scrollView :  UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.isScrollEnabled = true
        return scroll
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ServicesRouter.createServicesModule(servicesRef: self)
        setupServicesCell()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(servicesCollection)
        servicesCollection.isScrollEnabled = true
     //   scrollView.contentSize = CGSize(width: view.frame.height, height: 800)
        setConstrains()
        
    }
    var servicesCollection : UICollectionView!
    var personalCollection : UICollectionView!
    func setupServicesCell(){
        let frame = self.view.frame
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width/2-55, height: view.frame.width/2-55)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 40, bottom: 10, right: 40)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 20
        servicesCollection = UICollectionView(frame: frame, collectionViewLayout: layout)
        servicesCollection.backgroundColor = .white
     //   servicesCollection.layer.borderWidth = 1
    //    scrollView.addSubview(attendanceSubs)
        servicesCollection.register(ServicesCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        servicesCollection.delegate = self
        servicesCollection.dataSource = self
        servicesCollection.layer.cornerRadius = 15
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .clear
        servicesCollection.showsVerticalScrollIndicator = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
    }
    
    
    func setConstrains(){
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        servicesCollection.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
     //   personalCollection.anchor(top: servicesCollection.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: UIEdgeInsets(top: 20, left: 30, bottom: 0, right: 20), size: CGSize(width: 0, height: 280))
        
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        if collectionView == servicesCollection {
            presenter?.presentServicesModules(from: self, with: indexPath.row, with: empUuid!)
            print("yes")
        }
        else {
            if(indexPath.row == 0) {
                self.navigationController?.pushViewController( PaySlipView(), animated: true)
            }
            else if(indexPath.row == 1){
                self.navigationController?.pushViewController( InsuranceView() , animated: true)
            }
            else if(indexPath.row == 2){
                self.navigationController?.pushViewController( FilesView() , animated: true)
            }
            else if(indexPath.row == 3){
                self.navigationController?.pushViewController( FeedBack() , animated: true)
            }
            
        }
    }
}
