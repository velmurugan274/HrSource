//
//  CreateQuery.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 27/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.


import Foundation
import UIKit
class CreateQuery : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate ,CreateQueryViewProtocol{
    func setQueryIncharge(queryIncharge: [queryIncharge]) {
        self.queryIncharge = queryIncharge
    }
    var queryIncharge : [queryIncharge]?
    var datePicker = UIDatePicker()
    var constraint : NSLayoutConstraint!
    var scrollView :  UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.isScrollEnabled = true
        return scroll
    }()
    var sendQueryTo : UILabel = {
        let label = UILabel()
        label.text = "Query Type  "
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        //   label.backgroundColor = UIColor(red: 137/255.0, green: 196/255.0, blue: 244/255.0, alpha: 0.2)
        label.font = UIFont(name: "Futura-MediumItalic", size: 18)!
        // label.isHidden = true
        return label
    }()
    var querySubject : UILabel = {
        let label = UILabel()
        label.text = "Query Subject "
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        //   label.backgroundColor = UIColor(red: 137/255.0, green: 196/255.0, blue: 244/255.0, alpha: 0.2)
        label.font = UIFont(name: "Futura-MediumItalic", size: 18)!
        // label.isHidden = true
        return label
    }()
    var selectSendQueryTo : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.text = "SELECT"
        textField.layer.masksToBounds = false
        textField.layer.cornerRadius = 5
        textField.textAlignment = .left
        textField.tintColor = .clear
        return textField
    }()
    var typeQuerySubject : UITextView = {
        let textView = UITextView()
        textView.text = " Query Subject "
      //  textView.backgroundColor = UIColor(red: 231.0/255.0, green: 243/255.0, blue:253/255.0, alpha: 1)
        textView.textColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
        textView.layer.masksToBounds = false
        textView.font = UIFont(name: textView.font!.fontName, size: 18)
        
        return textView
    }()
    var typeQueryDetail : UITextView = {
        let textView = UITextView()
        textView.text = " Query Description "
    //    textView.backgroundColor = UIColor(red: 231.0/255.0, green: 243/255.0, blue:253/255.0, alpha: 1)
        textView.textColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
        textView.layer.masksToBounds = false
        textView.font = UIFont(name: textView.font!.fontName, size: 18)
        
        return textView
    }()
    var queryDetail : UILabel = {
        let label = UILabel()
        label.text = "Query Description "
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        //   label.backgroundColor = UIColor(red: 137/255.0, green: 196/255.0, blue: 244/255.0, alpha: 0.2)
        label.font = UIFont(name: "Futura-MediumItalic", size: 18)!
        // label.isHidden = true
        return label
    }()
    
    
    var submitButton : UIButton = {
        let button = UIButton()
        button.setTitle("SUBMIT", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        return button
    }()
    let line : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    let line1 : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    let line2 : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    var arrowImage :  UIImageView = {
        let imageview = UIImageView(image: UIImage(named: "arrowImage"))
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    func hideKeyboardWhenTapped() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissPicker))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissPicker(){
        // self.blackBack.isHidden = true
        view.endEditing(true)
        self.blackBack.isHidden = true
    }
    let blackBack : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        view.isHidden = true
        view.isUserInteractionEnabled = true
        return view
    }()
    let loadingView : UIImageView = {
        let gif = UIImageView()
        gif.loadGif(name: "loading")
        gif.contentMode = .scaleAspectFit
        gif.isHidden = true
        return gif
    }()
    let whiteback : UIView = {
        let view  = UIView()
        view.backgroundColor = .white
        view.alpha = 0.5
        view.isHidden = true
        return view
    }()
    var presenter : CreateQueryPresenterProtocol?
    var empUuid : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        //     self.tabBarController?.tabBar.isHidden = true
        CreateQueryRouter.createCreateQueryModule(createQueryRef: self)
        presenter?.getQueryIncharge()
        scrollView.contentSize = view.frame.size
        view.backgroundColor = .white
        view.addSubview(scrollView)
        
        scrollView.addSubview(selectSendQueryTo)
        scrollView.addSubview(sendQueryTo)
        scrollView.addSubview(line)
        scrollView.addSubview(arrowImage)
        
        scrollView.addSubview(typeQuerySubject)
        scrollView.addSubview(querySubject)
        scrollView.addSubview(line1)
        
        scrollView.addSubview(typeQueryDetail)
        scrollView.addSubview(queryDetail)
        scrollView.addSubview(line2)
        adjustUITextViewHeight(arg: typeQueryDetail)
        adjustUITextViewHeight(arg: typeQuerySubject)
        
        view.addSubview(submitButton)
        //  scrollView.backgroundColor = UIColor(red: 239.0/255.0, green: 240.0/255.0, blue: 244.0/255.0, alpha: 1)
        navigationItem.title = "Create Query"
        //  selectFromDate.delegate = self
        submitButton.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
        
        selectSendQueryTo.addTarget(self, action: #selector(textButton), for: .allEditingEvents)
        
        //    cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        
        view.addSubview(whiteback)
        view.addSubview(loadingView)
        setConstrains()
        typeQueryDetail.delegate = self
        typeQuerySubject.delegate = self
        hideKeyboardWhenTapped()
        scrollView.addSubview(blackBack)
        blackBack.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        whiteback.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)

        loadingView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 120, bottom: 0, right: 120), size: CGSize(width: 0, height: 80))
        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
       
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain , target: self, action: #selector(cancelTask))
        
    }
    
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }

    @objc func cancelTask(){
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func setConstrains(){
        
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        sendQueryTo.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 0) , size: CGSize(width: 0, height: 20))
        selectSendQueryTo.anchor(top: sendQueryTo.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) , size: CGSize(width: 0, height: 40))
        line.anchor(top: selectSendQueryTo.bottomAnchor , leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size : CGSize(width: 0, height: 0.5))
        arrowImage.anchor(top: selectSendQueryTo.topAnchor, leading: nil, bottom: selectSendQueryTo.bottomAnchor, trailing: selectSendQueryTo.trailingAnchor, size : CGSize(width: 25, height: 0))

        
        querySubject.anchor(top: line.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 0) , size: CGSize(width: 0, height: 20))
        typeQuerySubject.anchor(top: querySubject.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) , size: CGSize(width: 0, height: 0))
        line1.anchor(top: typeQuerySubject.bottomAnchor , leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size : CGSize(width: 0, height: 0.5))
        
        
        queryDetail.anchor(top: line1.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 0) , size: CGSize(width: 0, height: 20))
        typeQueryDetail.anchor(top: queryDetail.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) , size: CGSize(width: 0, height: 0))
        line2.anchor(top: typeQueryDetail.bottomAnchor , leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size : CGSize(width: 0, height: 0.5))

        
        submitButton.anchor(top: typeQueryDetail.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets.init(top: 50, left: 120, bottom: 0, right: 120), size: CGSize.init(width: 0, height: 50))
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc func submitButtonPressed(){
        let query = Query(queryId: UUID().uuidString, senderId: empUuid!, recieverId: queryInchargeId!, question: typeQueryDetail.text!, questionSubject: typeQuerySubject.text!, date: Int(Date().timeIntervalSince1970))
        presenter?.updateQuery(query: query)
        sucessView.isHidden = true
        self.view.addSubview(sucessView)
        addSuccessView()
        sucessView.translatesAutoresizingMaskIntoConstraints = false
        sucessView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sucessView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        sucessView.widthAnchor.constraint(equalToConstant: view.frame.width/2.5).isActive = true
        sucessView.heightAnchor.constraint(equalToConstant: view.frame.width/2.5).isActive = true

        loadingView.isHidden = false
        whiteback.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
            // self.navigationController?.pushViewController(profileView(), animated: true)
          //  self.whiteback.isHidden = false
            self.whiteback.backgroundColor = .black
            self.loadingView.isHidden = true
            self.sucessView.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.presenter?.presentHomeTab(from: self, with: self.empUuid!)
        }
        
    }
    let sucessView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    func addSuccessView(){
        let img = UIImageView(image: UIImage(named: "Success"))
        let successLabel = UILabel()
        successLabel.text = "Successful"
        successLabel.textAlignment = .center
        sucessView.addSubview(img)
        sucessView.addSubview(successLabel)
        successLabel.anchor(top: nil, leading: sucessView.leadingAnchor, bottom: sucessView.bottomAnchor, trailing: sucessView.trailingAnchor, size: CGSize(width: 0, height: 50))
        img.anchor(top: sucessView.topAnchor, leading: sucessView.leadingAnchor, bottom: successLabel.topAnchor, trailing: sucessView.trailingAnchor)
        img.contentMode = .scaleAspectFit
    }
    
    @objc func  sendQuerySelected(){
        sendQueryTo.isHidden = false
        selectSendQueryTo.layer.borderColor = UIColor(red: 33.0/255.0, green: 150.0/255.0, blue: 243.0/250.0, alpha: 1).cgColor
        selectSendQueryTo.placeholder = ""
        selectSendQueryTo.layer.borderWidth = 2
        sendQueryTo.textColor =  UIColor(red: 33.0/255.0, green: 150.0/255.0, blue: 243.0/250.0, alpha: 1)
    }
    
    @objc func sendQueryRejected(){
        selectSendQueryTo.layer.borderColor = UIColor.darkGray.cgColor
        selectSendQueryTo.layer.borderWidth = 0.5
        sendQueryTo.textColor = .darkGray
        if(selectSendQueryTo.text == "" ){
            sendQueryTo.isHidden = true
            selectSendQueryTo.placeholder = "Task Name"
            
        }
    }
    
    
    
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        
        if (textView.textColor == UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22))
        {
            textView.text = ""
            textView.textColor = .black
            textView.layer.borderColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1).cgColor
        }
        
        textView.becomeFirstResponder() 
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if (textView.text == "")
        {
            if textView == typeQuerySubject{
            textView.text = " Query Subject "
            }else {
                textView.text = " Query Details "
            }
            textView.textColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
        }
        textView.resignFirstResponder()
    }
    
    @objc func textButton(sender: AnyObject) {
        blackBack.isHidden = false
        let picker: UIPickerView
        picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        picker.backgroundColor = UIColor(red: 233.0/255.0, green: 233.0/255.0, blue: 233/255.0, alpha: 1)
        
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.barTintColor = UIColor(red: 0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        toolBar.tintColor = .white
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(CreateQuery.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(CreateQuery.cancelPicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        selectSendQueryTo.inputView = picker
        selectSendQueryTo.inputAccessoryView = toolBar
    }
    
    
    var queryInchargeId : String?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return queryIncharge!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return queryIncharge![row].queryType
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectSendQueryTo.text = queryIncharge![row].queryType
        queryInchargeId = queryIncharge![row].empUuid
    }
    
    @objc func cancelPicker(){
        selectSendQueryTo.text = "SELECT"
        selectSendQueryTo.resignFirstResponder()
        blackBack.isHidden = true
    }
    
    @objc func donePicker() {
        
        selectSendQueryTo.resignFirstResponder()
        blackBack.isHidden = true
    }
}
