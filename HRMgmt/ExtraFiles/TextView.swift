//
//  TextView.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 26/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class TextView : UIViewController, UITextViewDelegate{
    let textView : UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .green
        textView.textColor = .blue
        textView.text = "hii"
        return textView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        textView.delegate = self
        view.addSubview(textView)
        
//        textView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 100, left: 50, bottom: 0, right: 50))
        adjustUITextViewHeight(arg: textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant : -200).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        
        
    }
    func adjustUITextViewHeight(arg : UITextView)
    {
            arg.translatesAutoresizingMaskIntoConstraints = true
            arg.sizeToFit()
            arg.isScrollEnabled = false
    }
    func textViewDidChange(_ textView: UITextView) {
        print(textView.contentSize.height)
        if textView.contentSize.height > 100{
            textView.isScrollEnabled = true
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 50, bottom: 200, right: 50), size: CGSize(width: 0, height: 100))
        }else{
            textView.translatesAutoresizingMaskIntoConstraints = true
            textView.sizeToFit()
            textView.isScrollEnabled = false
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant : -200).isActive = true
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
            
        }
    }
}
