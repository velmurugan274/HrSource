//
//  iconsView.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 23/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class ServicesCollectionViewCell : UICollectionViewCell {
    
    var label: UILabel!
    var roundView = UIView()
    var image = UIImageView()
    var shadowView = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        label = UILabel(frame: contentView.frame)
        self.addSubview(label)
        self.addSubview(image)
        self.addSubview(shadowView)
        self.layer.masksToBounds = false
        label.font = UIFont(name: "Futura-Medium", size: 25)!
     //   self.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
        self.backgroundColor = .clear
        shadowView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)

        image.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets.init(top: 0, left: 30, bottom: 0, right: 0), size: CGSize(width: (self.frame.width/2)-20, height: (self.frame.width/2)-20))
        image.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        image.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant : -10).isActive = true
        label.anchor(top: image.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor,padding: UIEdgeInsets.init(top: 20, left: 10, bottom: 0, right: 10))
        
        image.contentMode = .scaleAspectFit
        label.textAlignment = .center
        label.font = UIFont(name: label.font.fontName, size: 18)
        self.layer.cornerRadius = 10
//        self.layer.borderWidth = 0.5
//        self.layer.borderColor  = UIColor.black.cgColor
//        self.layer.shadowOpacity = 1
//        self.layer.shadowOffset = .zero
//        self.layer.shadowRadius = 1
        
        self.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
    }
    
    
}
