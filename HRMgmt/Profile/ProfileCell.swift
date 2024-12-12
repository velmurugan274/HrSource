//
//  ProfileCell.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 22/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import  UIKit
class commonProfileCell : UITableViewCell {
    
    var titleName : UILabel = {
        let label = UILabel()
        label.text = "e-mail"
        label.font = UIFont(name: "Futura-MediumItalic", size: 20)!
        label.textColor = .gray
        return label
    }()
    
    var titleDetail : UILabel = {
        let label = UILabel()
        label.text = "vel@zohocorp.com"
        label.font = UIFont(name: "Futura-MediumItalic", size: 18)!
        //  label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCells()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCells(){
        self.addSubview(titleName)
        self.addSubview(titleDetail)
        self.selectionStyle = .none
        titleName.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0), size: CGSize(width: 0, height: self.frame.height/2))
        titleDetail.anchor(top: titleName.bottomAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0))
    }
}
