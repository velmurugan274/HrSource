//
//  PerformanceCell.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 27/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class PerformanceCell: UITableViewCell {
    var rating : RatingControl!
    var backView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
      //  view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    var PerformanceTitle : UILabel = {
        let label = UILabel()
        label.text = "Performance"
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.font = UIFont(name: "Futura-Medium", size: 18)!
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
        self.addSubview(backView)
        rating = RatingControl()
        rating.starSize = CGSize(width: 25, height: 25)
        self.addSubview(PerformanceTitle)
        self.addSubview(rating)
        
        self.backgroundColor = .clear
        backView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor , padding: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
        PerformanceTitle.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil,padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0) , size : CGSize(width: 0, height: 35))
        rating.anchor(top: PerformanceTitle.bottomAnchor, leading: nil, bottom: nil, trailing: nil , padding: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0))
        rating.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
}
