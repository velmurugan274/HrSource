//
//  FeedBackView.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 27/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class FeedBack : UIViewController, UITextViewDelegate{
    
    var scrollView :  UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.isScrollEnabled = true
        return scroll
    }()
    
    var feedbackTitle : UILabel = {
        let label = UILabel()
        label.text = "Please rate our app"
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.font = UIFont(name: "Futura-MediumItalic", size: 20)!
        return label
    }()
    
    var commentsTitle : UILabel = {
        let label = UILabel()
        label.text = "Comments"
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.font = UIFont(name: "Futura-MediumItalic", size: 20)!
        return label
    }()
    
    var comments : UITextView = {
        let textView = UITextView()
        textView.text = " Comment if any (optional)"
        textView.textColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10);
       // textView.layer.masksToBounds = false
        textView.font = UIFont(name: textView.font!.fontName, size: 18)
        textView.layer.cornerRadius = 5
        textView.layer.borderColor = UIColor.darkGray.cgColor
        textView.layer.borderWidth = 0.5
        return textView
    }()
    
    var submitButton : UIButton = {
        let button = UIButton()
        button.setTitle("SUBMIT", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        return button
    }()

    var rating : RatingControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Feedback"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
      //  scrollView.backgroundColor = UIColor(red: 137/255.0, green: 196/255.0, blue: 244/255.0, alpha: 0.2)
        view.backgroundColor = .white
        rating = RatingControl()
        rating.contentMode = .scaleAspectFit
        view.addSubview(scrollView)
        scrollView.addSubview(feedbackTitle)
        scrollView.addSubview(rating)
        scrollView.addSubview(commentsTitle)
        scrollView.addSubview(comments)
        scrollView.addSubview(submitButton)
        
        comments.delegate = self
        
        
        scrollView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        feedbackTitle.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: UIEdgeInsets(top: 20, left: 30, bottom: 0, right: 30),  size :CGSize(width: 0, height: 35))
        rating.anchor(top: feedbackTitle.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))
        rating.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        print(rating.rating)
      
        commentsTitle.anchor(top: rating.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 30, bottom: 0, right: 30), size: CGSize(width: 0, height: 35))
        comments.anchor(top: commentsTitle.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 30, bottom: 0, right: 30), size: CGSize(width: 0, height: 200))
        submitButton.anchor(top: comments.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets.init(top: 20, left: 100, bottom: 0, right: 100), size: CGSize.init(width: 0, height: 50))
        submitButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        hideKeyboardWhenTappedAround()
        
    }
    @objc func buttonPressed(){
        print(rating.rating)
        navigationController?.popViewController(animated: true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        
        if (textView.textColor == UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22))
        {
            textView.text = ""
            textView.textColor = .black
            textView.layer.borderColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1).cgColor
        }
        
        textView.becomeFirstResponder() //Optional
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if (textView.text == "")
        {
            textView.text = " Reason "
            textView.textColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
        }
        textView.resignFirstResponder()
    }
}
