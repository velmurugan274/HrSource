//
//  employeeList.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 22/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import  UIKit
class TaskCell : UITableViewCell {
    
    let profileImage : UIImageView  = {
        let label = UIImageView(image: UIImage(named: "ProfilePicture") )
        return label
    }()
    
    var title : UILabel =  {
        let label = UILabel()
        label.text = "COMPLETING THE SAMPLE APP"
        label.textColor = UIColor(red: 0/255.0, green: 46/255.0, blue: 110/255.0, alpha: 1)
        label.font = UIFont(name: "Futura-MediumItalic", size: 18)!

        return label
    }()
    
    var titleDescription : UILabel =  {
        let label = UILabel()
        label.text = "Hey guys you have the compete your internship program before you start the main"
      //  label.textColor = .darkGray
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func  setupViews(){
       // let ccBorder = self.layoutMarginsGuide
        self.addSubview(profileImage)
        self.addSubview(title)
        self.addSubview(titleDescription)
        profileImage.layer.masksToBounds = true
        profileImage.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: UIEdgeInsets.init(top: 15, left: 10, bottom: 15, right: 0) , size: CGSize.init(width: 50, height: 0))
        title.anchor(top: self.topAnchor, leading: profileImage.trailingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets.init(top: 15, left: 10, bottom: 0, right: 5))
        titleDescription.anchor(top: title.bottomAnchor, leading: profileImage.trailingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets.init(top: 0, left: 10, bottom: 15, right: 0))
        
    }
    
}
