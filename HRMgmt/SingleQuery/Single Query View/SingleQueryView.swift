//
//  SingleQueryView.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 17/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class SingleQueryView : UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SingleQueryViewProtocol , UITextViewDelegate{
    func setQuerySenderName(name: String) {
        self.senderName = name
    }
    
    func setQueryReplies(replies: [QueryReplies]) {
        self.queryReplies = replies
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return queryReplies.count
    }
    var empUuid : String?
    var senderName : String?
    var queryReplies = [QueryReplies]()
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! chatCell
        cell.messageView.text = queryReplies[indexPath.item].getReply()
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: queryReplies[indexPath.item].getReply()).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18)], context: nil)
        if queryReplies[indexPath.item].getRepliedBy() != empUuid{
        cell.messageView.frame = CGRect(x: 40+8, y: 0, width: estimatedFrame.width+18, height: estimatedFrame.height+20)
        }else {
            cell.messageView.frame = CGRect(x: view.frame.width - estimatedFrame.width-18-10, y: 0, width: estimatedFrame.width+18, height: estimatedFrame.height+20)
            cell.imageView.isHidden = true

        }
        return cell
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
    
    
    let notificationSender : UILabel  =  {
        let label = UILabel()
        label.text = "Velmurugan "
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
   
    
    
    var notificationTitle : UITextView = {
        let textView = UITextView()
        textView.text = "Have a look at products currently in progress "
     //   textView.layer.masksToBounds = false
        textView.font = UIFont.boldSystemFont(ofSize: 18)
        textView.isUserInteractionEnabled = false
        //  textView.layer.cornerRadius = 5
        //   textView.layer.borderColor = UIColor.darkGray.cgColor
        textView.backgroundColor = .clear
        //   textView.layer.borderWidth = 0.5
        return textView
        
    }()
    var replyView : UITextView = {
        let textView = UITextView()
        textView.text = " Enter Reply..."
        textView.textColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
       // textView.layer.masksToBounds = false
        textView.font = UIFont(name: textView.font!.fontName, size: 18)
        //  textView.layer.cornerRadius = 5
        //   textView.layer.borderColor = UIColor.darkGray.cgColor
        textView.backgroundColor = .clear
        textView.isScrollEnabled = true
        //   textView.layer.borderWidth = 0.5
        return textView
        
    }()
    var downTextView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()

    
    var notificationDetail : UITextView = {
        let textView = UITextView()
      //  textView.layer.masksToBounds = false
        textView.font = UIFont.systemFont(ofSize: 15, weight: .thin)
        textView.text = "Hi guys im here to check the details of the product that is current used"
        if let fontDescriptor = UIFontDescriptor
            .preferredFontDescriptor(withTextStyle: UIFont.TextStyle.body)
            .withSymbolicTraits(UIFontDescriptor.SymbolicTraits.traitLooseLeading) {
            let looseLeadingFont = UIFont(descriptor: fontDescriptor, size: 0)
            textView.font = looseLeadingFont
        }
        textView.isScrollEnabled = true
        textView.isEditable = false
        //  textView.layer.cornerRadius = 5
        //   textView.layer.borderColor = UIColor.darkGray.cgColor
        textView.backgroundColor = .clear
        //   textView.layer.borderWidth = 0.5
        return textView
        
    }()
   
    
    var sendButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "SendImage"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
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
    var bottomConstrains : NSLayoutConstraint?
    var replies : UICollectionView?
    var query : Query?
    var presenter : SingleQueryPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        SingleQueryRouter.createSingleQueryModule(singleQueryRef: self)
        presenter?.getQuerySenderName(empUuid: (query?.getSenderId())!)
        presenter?.getQueryReplies(queryUuid: (query?.getQueryId())!)
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.backgroundColor = .clear
        scrollView.addSubview(backView)
        scrollView.addSubview(senderImage)
        scrollView.addSubview(notificationSender)
        scrollView.addSubview(notificationDate)
        backView.addSubview(notificationTitle)
        
        adjustUITextViewHeight(arg: notificationTitle)
        backView.addSubview(notificationDetail)
        adjustUITextViewHeight(arg: notificationDetail)
        notificationDate.text = DateController.getDateTimeFromTimeStamp(timeStamp: Double((query?.getDate())!))
        notificationTitle.text = query?.getQuestionSubject()
        notificationDetail.text = query?.getQuestion()
        notificationSender.text = senderName!
        
        senderImage.layer.cornerRadius = 25.0
        navigationItem.title = "Query View"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let frame = self.view.frame
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 10
        replies = UICollectionView(frame: frame, collectionViewLayout: layout)
        replies!.backgroundColor = .clear
        replies?.register(chatCell.self, forCellWithReuseIdentifier: "cell")
        replies?.delegate = self
        replies?.dataSource = self
        downTextView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        
        scrollView.addSubview(replies!)
        
        scrollView.addSubview(downTextView)
        downTextView.addSubview(replyView)
        downTextView.addSubview(sendButton)
        downTextView.layer.cornerRadius = 20
        
        
        setConstrains()
        bottomConstrains = NSLayoutConstraint(item: downTextView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -5)
        view.addConstraint(bottomConstrains!)
       // hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification , object: nil)
        sendButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
       // replies?.scrollToLast()
        hideKeyboardWhenTappedArounds()
        scrollView.contentSize = CGSize(width: view.frame.width, height: 800)
        replyView.delegate = self
        
    }
    func hideKeyboardWhenTappedArounds() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        replies!.addGestureRecognizer(tap)
      //  sendButton.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        replies?.scrollToLast()
    }
    @objc func handleKeyboardNotification(notification : NSNotification){
        if let userInfo = notification.userInfo{
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
           // downTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -keyboardFrame.height).isActive = true
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            bottomConstrains?.constant = isKeyboardShowing ? -keyboardFrame.height+80 : -5
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {self.view.layoutIfNeeded()}, completion: {(completed) in})
            
        }
        
    }
    
    
    func setConstrains(){
        
      //  tabBarController?.tabBar.isHidden = true
     //   self.hidesBottomBarWhenPushed = true
        
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        senderImage.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding : UIEdgeInsets.init(top: 20, left: 23, bottom: 0, right: 0), size: CGSize.init(width: 50, height: 50))
        backView.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 10), size: CGSize(width: 0, height: view.frame.height/3.5))
        notificationSender.anchor(top: scrollView.topAnchor, leading: senderImage.trailingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets.init(top: 20, left: 10, bottom: 25, right: 0))
        notificationDate.anchor(top: nil, leading: senderImage.trailingAnchor, bottom: senderImage.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets.init(top: 0, left: 10, bottom: 8, right: 0))
        notificationTitle.anchor(top: senderImage.bottomAnchor, leading: backView.leadingAnchor, bottom: nil, trailing: backView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 5))

         notificationDetail.anchor(top: notificationTitle.bottomAnchor, leading: backView.leadingAnchor, bottom: backView.bottomAnchor, trailing: backView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 5))
        replies?.anchor(top: backView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 48, right: 0))
        replies?.backgroundColor = .clear
        downTextView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing:  view.trailingAnchor ,padding: UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 3) , size : CGSize(width: 0, height: 40))
        replyView.anchor(top: downTextView.topAnchor, leading: downTextView.leadingAnchor, bottom: downTextView.bottomAnchor, trailing: downTextView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30))
        sendButton.anchor(top: replyView.topAnchor, leading: nil, bottom: replyView.bottomAnchor, trailing: view.trailingAnchor,  padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5), size :CGSize(width: 30, height: 0))
        
      //  scrollView.contentSize =  CGSize(width: <#T##CGFloat#>, height: <#T##CGFloat#>)
 
       
    }
    @objc func sendButtonPressed(){
        if replyView.text != "" && replyView.textColor != UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22) {
            let queryReply = QueryReplies(replyId: (query?.getQueryId())!, reply: replyView.text, repliedBy: empUuid!)
            presenter?.updateQueryReply(queryReply: queryReply)
            self.dismissKeyboard()
            self.queryReplies.append(queryReply)
            replyView.text = ""
            let indexPath = IndexPath(item: (queryReplies.count-1), section: 0)
            replies?.insertItems(at: [indexPath])
            replies?.scrollToLast()
            textViewDidEndEditing(replyView)

        }
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: queryReplies[indexPath.item].getReply() ).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18)], context: nil)
  
        return CGSize(width: view.frame.width, height: estimatedFrame.height+20)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
        if textView.text == ""
        {
            textView.text = " Enter Reply.... "
            textView.textColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
        }
        textView.resignFirstResponder()
    }
    
}

class chatCell : UICollectionViewCell {
    let messageView : UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.text = "Sample Message"
        textView.backgroundColor = UIColor(red: 233.0/255.0, green: 233.0/255.0, blue: 233/255.0, alpha: 1)
        textView.isScrollEnabled = false
        textView.isEditable = false
        return textView
    }()
    
    let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ProfilePicture")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCells()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupCells(){
        self.addSubview(messageView)
        self.addSubview(imageView)
        
        messageView.layer.cornerRadius = 10
        messageView.layer.masksToBounds = true
        messageView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
//        messageView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
        imageView.anchor(top: nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0), size: CGSize(width: 30, height: 30) )
        imageView.backgroundColor = .green
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 15
        //messageView.anchor(top: nil, leading: imageView.trailingAnchor, bottom: self.bottomAnchor, trailing: nil)
    }
}
