//
//  DownloadCell.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 24/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class DownloadCell : UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCells()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let border : UIView = {
        let border  = UIView()
        border.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
        border.layer.cornerRadius = 10
        return border
    }()
    var titleImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Downloads")
        imageView.layer.backgroundColor = UIColor.clear.cgColor
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    var title : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura-MediumItalic", size: 20)!
        label.text = "Leave Policy"
        label.textColor = UIColor.black
        return label
    }()
    var titleDescription : UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "this explains the leave policy of the company"
        label.font = label.font.withSize(12)
        label.numberOfLines = 0
        return label
    }()
    let downoadImage : UIButton = {
        let imageView = UIButton()
        imageView.setImage(UIImage(named: "Download"), for: .normal)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    } ()
    func setupCells() {
        self.addSubview(border)
        self.addSubview(titleImage)
        self.addSubview(title)
        self.addSubview(titleDescription)
        self.addSubview(downoadImage)
        self.backgroundColor = .clear
        border.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        titleImage.anchor(top: border.topAnchor, leading: border.leadingAnchor, bottom: border.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0), size: CGSize(width: 80, height: 0))
        title.anchor(top: border.topAnchor, leading: titleImage.trailingAnchor, bottom: nil, trailing: border.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 60))
        titleDescription.anchor(top: title.bottomAnchor, leading: titleImage.trailingAnchor, bottom: nil, trailing: border.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 60))
        downoadImage.anchor(top: nil, leading: nil, bottom: nil, trailing: border.trailingAnchor , padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 50, height: 50))
        downoadImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.selectionStyle = .none
    }
}
