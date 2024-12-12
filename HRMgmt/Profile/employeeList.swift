//
//  employeeList.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 22/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import  UIKit
class employeeCell : UITableViewCell {
    
    var contactImage : UIImageView  = {
        let label = UIImageView(image: UIImage(named: "ProfilePicture") )
        return label
    }()
    
    var name : UILabel =  {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont(name: "Futura-MediumItalic", size: 18)!
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        return label
    }()
    
    var department : UILabel =  {
        let label = UILabel()
        label.text = "Position"
        label.textColor = .gray
        label.adjustsFontSizeToFitWidth = true
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
        let ccBorder = self.layoutMarginsGuide
        self.selectionStyle = .none
        self.addSubview(contactImage)
        self.addSubview(name)
        self.addSubview(department)
        contactImage.layer.masksToBounds = true
        contactImage.anchor(top: ccBorder.topAnchor, leading: ccBorder.leadingAnchor, bottom: ccBorder.bottomAnchor, trailing: nil, padding: UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0) , size: CGSize.init(width: 60, height: 0))
        contactImage.layer.cornerRadius = 60.0/2
        name.anchor(top: ccBorder.topAnchor, leading: contactImage.trailingAnchor, bottom: nil, trailing: ccBorder.trailingAnchor, padding: UIEdgeInsets.init(top: 5, left: 10, bottom: 30, right: 150))
        department.anchor(top: name.bottomAnchor, leading: contactImage.trailingAnchor, bottom: ccBorder.bottomAnchor, trailing: ccBorder.trailingAnchor , padding: UIEdgeInsets.init(top: 0, left: 10, bottom: 5, right: 0))
    }
    
}
