//
//  ShowNotification.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 11/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import  UIKit
class ShowNotification : UIViewController, ShowNotificationViewProtocol{
    func likeStatus(liked: Bool) {
        self.likeStatus = liked
    }
    
    
    let backView : UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
        backView.layer.cornerRadius = 15
        return backView
       
    }()
    
    let scrollView :  UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    let senderImage : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ProfilePicture"))
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let likeButton : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "unlikePlus"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    let notificationSender : UILabel  =  {
        let label = UILabel()
        label.text = "Velmurugan "
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.font = UIFont(name: "Futura-MediumItalic", size: 18)!
        label.numberOfLines = 0
        return label
    }()
    
    var likeCountBackView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        view.alpha = 0.1
        view.layer.cornerRadius = 15
        return view
    }()
    
    var likesCountImage : UIImageView = {
        let image = UIImageView(image: UIImage(named: "likePlus"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var likesCountText : UILabel = {
        let label = UILabel()
        label.text = "3"
        label.textColor = .darkGray
        return label
    }()
    
    
    var notificationTitle : UITextView = {
        let textView = UITextView()
        textView.text = "Have a look at products currently in progress "
        textView.layer.masksToBounds = false
        textView.font = UIFont(name: "Futura-MediumItalic", size: 18)!
        //  textView.layer.cornerRadius = 5
        //   textView.layer.borderColor = UIColor.darkGray.cgColor
        textView.backgroundColor = .clear
        //   textView.layer.borderWidth = 0.5
        return textView
        
    }()
    
    var notificationDetail : UITextView = {
        let textView = UITextView()
        textView.layer.masksToBounds = false
        textView.font = UIFont.systemFont(ofSize: 15, weight: .thin)
        if let fontDescriptor = UIFontDescriptor
            .preferredFontDescriptor(withTextStyle: UIFont.TextStyle.body)
            .withSymbolicTraits(UIFontDescriptor.SymbolicTraits.traitLooseLeading) {
            let looseLeadingFont = UIFont(descriptor: fontDescriptor, size: 0)
            textView.font = looseLeadingFont
        }
        textView.isEditable = false
        //  textView.layer.cornerRadius = 5
        //   textView.layer.borderColor = UIColor.darkGray.cgColor
        textView.backgroundColor = .clear
        //   textView.layer.borderWidth = 0.5
        return textView
        
    }()
    
    var notificationDate : UILabel = {
        let label = UILabel()
        label.text = "9 May, 12:13 PM"
        label.textColor = UIColor.gray
        label.font = label.font.withSize(15)
        return label
    }()
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    var presenter : ShowNotificationPresenterProtocol?
    var likeStatus : Bool?
    var notification : Notifications?
    var empUuid : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        ShowNotificationRouter.createShowNotificationModule(showNotificationRef: self)
        presenter?.isLiked(empUuid: empUuid!, notiId: (notification?.getNotificationId())!)
        view.addSubview(scrollView)
        scrollView.backgroundColor = .clear
        scrollView.addSubview(backView)
        scrollView.addSubview(senderImage)
        scrollView.addSubview(likeButton)
        scrollView.addSubview(notificationSender)
        scrollView.addSubview(notificationDate)
        scrollView.addSubview(notificationTitle)
        backView.addSubview(likeCountBackView)
        backView.addSubview(likesCountText)
        backView.addSubview(likesCountImage)
        adjustUITextViewHeight(arg: notificationTitle)
        scrollView.addSubview(notificationDetail)
        adjustUITextViewHeight(arg: notificationDetail)
        setConstrains()
        senderImage.layer.cornerRadius = 20.0
        navigationItem.title = "Notification Post"
        navigationController?.navigationBar.prefersLargeTitles = true
        likeButton.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        notificationDetail.text = notification?.getNotificationBody()
        notificationTitle.text = notification?.getNotificationSubject()
        likesCountText.text = "\(notification?.getNotifLikes() ?? 0)"
        notificationDate.text = DateController.getDateTimeFromTimeStamp(timeStamp: Double((notification?.getNotifDate())!))
        if likeStatus == true{
            likeButton.setBackgroundImage(UIImage(named: "likePlus"), for: .normal)
           
        }else{
            likeButton.setBackgroundImage(UIImage(named: "unlikePlus"), for: .normal)
        }
        
        
    }
    
    @objc func likeButtonPressed(){
        if likeStatus == true{
            likeButton.setBackgroundImage(UIImage(named: "unlikePlus"), for: .normal)
            presenter?.updateStatus(empUuid: empUuid!, notifId: (notification?.getNotificationId())!, likeStatus: likeStatus!)
            likesCountText.text = "\((notification?.getNotifLikes())!-1)"
            likeStatus = false
        }else{
            likeButton.setBackgroundImage(UIImage(named: "likePlus"), for: .normal)
            presenter?.updateStatus(empUuid: empUuid!, notifId: (notification?.getNotificationId())!, likeStatus: likeStatus!)
            likesCountText.text = "\((notification?.getNotifLikes())!+1)"
            likeStatus = true
        }
    }
    
    
    func setConstrains(){
  
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        senderImage.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding : UIEdgeInsets.init(top: 20, left: 23, bottom: 0, right: 0), size: CGSize.init(width: 40, height: 40))
        likeButton.anchor(top: scrollView.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor,padding : UIEdgeInsets.init(top: 30, left: 0, bottom: 0, right: 23), size: CGSize.init(width: 30, height: 30))
        notificationSender.anchor(top: scrollView.topAnchor, leading: senderImage.trailingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets.init(top: 20, left: 10, bottom: 25, right: 0))
        notificationDate.anchor(top: notificationSender.bottomAnchor, leading: senderImage.trailingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 0))
        notificationTitle.anchor(top: senderImage.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 23, bottom: 0, right: 10))
        notificationDetail.anchor(top: notificationTitle.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 23, bottom: 0, right: 10))
        
        backView.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: notificationDetail.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 15, bottom: -25, right: 10))
        likeCountBackView.anchor(top: nil, leading: nil, bottom: backView.bottomAnchor, trailing: backView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 20), size: CGSize(width: 60, height: 30))
        likesCountImage.anchor(top: likeCountBackView.topAnchor, leading: likeCountBackView.leadingAnchor, bottom: likeCountBackView.bottomAnchor, trailing: nil , padding: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 0), size: CGSize(width: 25, height: 0))
        likesCountText.anchor(top: likeCountBackView.topAnchor, leading: likesCountImage.trailingAnchor, bottom: likeCountBackView.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 0))
        
    }
    
}
