import Foundation
import UIKit
class PermissionView : UIViewController, UITextViewDelegate, PermissionViewProtocol{
    func setReporterId(empUuid: String) {
        self.reporterId = empUuid
    }
    
    
    var empUuid : String?
    var shiftChangeStatus = false
    var reporterId : String?
    var presenter : PermissionPresenterProtocol?
    var activeTextField : UITextField!
    var datePicker = UIDatePicker()
    var scrollView :  UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.isScrollEnabled = true
        return scroll
    }()
    var permissionDate : UILabel = {
        let label = UILabel()
        label.text = "Date "
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
      //  label.backgroundColor = UIColor(red: 231.0/255.0, green: 243/255.0, blue:253/255.0, alpha: 1)
        label.font = UIFont(name: "Futura-MediumItalic", size: 18)!
        // label.isHidden = true
        return label
    }()
    var shiftChange : UILabel = {
        let label = UILabel()
        label.text = "Shift change? "
        label.sizeToFit()
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
     //   label.backgroundColor = UIColor(red: 231.0/255.0, green: 243/255.0, blue:253/255.0, alpha: 1)
        label.font = UIFont(name: "Futura-MediumItalic", size: 18)!
        return label
    }()
    var entryTime : UILabel = {
        let label = UILabel()
        label.text = "Est. CheckIn Time "
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
     //   label.backgroundColor = UIColor(red: 231.0/255.0, green: 243/255.0, blue:253/255.0, alpha: 1)
        label.font = UIFont(name: "Futura-MediumItalic", size: 18)!
        // label.isHidden = true
        return label
    }()
    var reason : UILabel = {
        let label = UILabel()
        label.text = "Reason "
    //    label.backgroundColor = UIColor(red: 231.0/255.0, green: 243/255.0, blue:253/255.0, alpha: 1)
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.font = UIFont(name: "Futura-MediumItalic", size: 18)!
        //   label.isHidden = true
        return label
    }()
    var permissionDateText : UITextField = {
        let textField = UITextField()
        textField.text = DateController.getDateFromTimeStamp(timeStamp: Double(Date().timeIntervalSince1970))
        textField.tintColor = .clear
        textField.layer.masksToBounds = false
        textField.layer.cornerRadius = 5
        textField.textAlignment = .left
        return textField
    }()
    var yesButton : UIButton = {
        let button = UIButton()
        button.layer.masksToBounds  = false
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 5
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.borderColor = UIColor.white.cgColor
        button.sizeToFit()
        button.backgroundColor = UIColor.white
        return button
    }()
    var noButton : UIButton = {
        let button = UIButton()
        button.layer.masksToBounds  = false
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 5
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.borderColor = UIColor.white.cgColor
        button.sizeToFit()
        button.backgroundColor = UIColor.black
        return button
    }()
    var yesLabel : UILabel = {
        let label = UILabel()
        label.text = "Yes"
       // label.backgroundColor = UIColor(red: 231.0/255.0, green: 243/255.0, blue:253/255.0, alpha: 1)
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        //   label.isHidden = true
        return label
    }()
    var noLabel : UILabel = {
        let label = UILabel()
        label.text = "No"
      //  label.backgroundColor = UIColor(red: 231.0/255.0, green: 243/255.0, blue:253/255.0, alpha: 1)
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    var entryTimeText : UITextField = {
        let textField = UITextField()
        textField.text = nil
        textField.text = "12:00 PM"
        textField.tintColor = .clear
        textField.layer.masksToBounds = false
        textField.layer.cornerRadius = 5
        textField.textAlignment = .left
        textField.allowsEditingTextAttributes = false
        return textField
    }()
    var typeReason : UITextView = {
        let textView = UITextView()
        textView.text = " Reason "
        textView.textColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
        textView.layer.masksToBounds = false
        textView.font = UIFont(name: textView.font!.fontName, size: 18)
        textView.layer.cornerRadius = 5
        textView.backgroundColor = .clear
        return textView
        
    }()
    
    var submitButton : UIButton = {
        let button = UIButton()
        button.setTitle("SUBMIT", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
      
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
    let line3 : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    var clockImage :  UIImageView = {
        let imageview = UIImageView(image: UIImage(named: "clockImage"))
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    var calendarImage :  UIImageView = {
        let imageview = UIImageView(image: UIImage(named: "calendarImage"))
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    let blackBack : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        view.isHidden = true
        view.isUserInteractionEnabled = true
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PermissionRouter.createPermissionModule(permissionRef: self)
        presenter?.getReporterId(empUuid: empUuid!)
        scrollView.contentSize = CGSize(width: view.frame.width, height: 600)
        //navigationController?.navigationBar.isTranslucent = false
        view.backgroundColor = .white
        scrollView.backgroundColor = .clear
        view.addSubview(scrollView)
        
        scrollView.addSubview(permissionDate)
        scrollView.addSubview(permissionDateText)
        scrollView.addSubview(line)
        permissionDateText.addSubview(calendarImage)
        
        scrollView.addSubview(shiftChange)
        scrollView.addSubview(yesButton)
        scrollView.addSubview(yesLabel)
        scrollView.addSubview(noButton)
        scrollView.addSubview(noLabel)
        scrollView.addSubview(line1)
        
        scrollView.addSubview(entryTime)
        scrollView.addSubview(entryTimeText)
        scrollView.addSubview(line2)
        entryTimeText.addSubview(clockImage)
        
        scrollView.addSubview(typeReason)
        scrollView.addSubview(reason)
        scrollView.addSubview(line3)
        
        scrollView.addSubview(submitButton)
        navigationItem.title = "Permission "
        navigationController?.navigationBar.prefersLargeTitles = true
        typeReason.delegate = self
        adjustUITextViewHeight(arg: typeReason)
        entryTimeText.addTarget(self, action: #selector(textFieldDidBeginEditing(textField:)), for: .allEditingEvents)
        permissionDateText.addTarget(self, action: #selector(textFieldDidBeginEditing(textField:)), for: .allEditingEvents)
      //  adjustUITextViewHeight(arg: typeReason)
        setConstrains()
        scrollView.addSubview(blackBack)
        blackBack.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        submitButton.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
        
       // self.hideKeyboardWhenTappedAround()
        hideKeyboardWhenTapped()
        
    }
    
    func setConstrains(){
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        permissionDate.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 0) , size: CGSize(width: 0, height: 20))
        permissionDateText.anchor(top: permissionDate.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) , size: CGSize(width: 0, height: 40))
        line.anchor(top: permissionDateText.bottomAnchor , leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size : CGSize(width: 0, height: 0.5))
        calendarImage.anchor(top: permissionDateText.topAnchor, leading: nil, bottom: permissionDateText.bottomAnchor, trailing: permissionDateText.trailingAnchor, size : CGSize(width: 25, height: 0))
        
        shiftChange.anchor(top: line.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 15, left: 20, bottom: 0, right: 0) , size: CGSize(width: view.frame.width/2, height: 20))
        yesButton.anchor(top: line.bottomAnchor, leading: shiftChange.trailingAnchor, bottom: nil, trailing: nil , padding: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0), size: CGSize(width: 20, height: 20))
        yesLabel.anchor(top: line.bottomAnchor, leading: yesButton.trailingAnchor, bottom: nil, trailing: nil , padding: UIEdgeInsets(top: 15, left: 10, bottom: 0, right: 0))
        noButton.anchor(top: line.bottomAnchor, leading: yesLabel.trailingAnchor, bottom: nil, trailing: nil , padding: UIEdgeInsets(top: 15, left: 20, bottom: 0, right: 0), size: CGSize(width: 20, height: 20))
        noLabel.anchor(top: line.bottomAnchor, leading: noButton.trailingAnchor, bottom: nil, trailing: nil , padding: UIEdgeInsets(top: 15, left: 10, bottom: 0, right: 0))
        line1.anchor(top: shiftChange.bottomAnchor , leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0) ,size : CGSize(width: 0, height: 0.5))
        
        
        entryTime.anchor(top: line1.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 0) , size: CGSize(width: 0, height: 20))
        entryTimeText.anchor(top: entryTime.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) , size: CGSize(width: 0, height: 40))
        line2.anchor(top: entryTimeText.bottomAnchor , leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size : CGSize(width: 0, height: 0.5))
        clockImage.anchor(top: entryTimeText.topAnchor, leading: nil, bottom: entryTimeText.bottomAnchor, trailing: entryTimeText.trailingAnchor, size : CGSize(width: 25, height: 0))
        

        
        reason.anchor(top: line2.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 0))
        typeReason.anchor(top: reason.bottomAnchor , leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding:  UIEdgeInsets.init(top: 10, left: 20, bottom: 0, right: 20) ,  size: CGSize.init(width: 0, height: 0))
        line3.anchor(top: typeReason.bottomAnchor , leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size : CGSize(width: 0, height: 0.5))
        
        submitButton.anchor(top: typeReason.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets.init(top: 20, left: 100, bottom: 0, right: 100), size: CGSize.init(width: 0, height: 50))
        
        yesButton.addTarget(self, action: #selector(yesButtonTarget), for: .touchUpInside)
        noButton.addTarget(self, action: #selector(noButtonTarget), for: .touchUpInside)
        
        
        
    }
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
    @objc func blueBorder(textField : UITextField){
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1).cgColor
    }
    @objc func yesButtonTarget(){
        yesButton.backgroundColor = .black
        shiftChangeStatus = true
        noButton.backgroundColor = .white
    }
    @objc func noButtonTarget(){
        noButton.backgroundColor = .black
        shiftChangeStatus = false
        yesButton.backgroundColor = .white
    }
    
    @objc func grayBorder(textField : UITextField){
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.darkGray.cgColor
    }
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
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
    
    @objc func pickUpDate(forField Field : UITextField){
        
        // DatePicker
        self.blackBack.isHidden = false
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker.backgroundColor = UIColor(red: 233.0/255.0, green: 233.0/255.0, blue: 233/255.0, alpha: 1)
        if Field == entryTimeText{
        self.datePicker.datePickerMode = UIDatePicker.Mode.time
        }
        else{
            self.datePicker.datePickerMode = UIDatePicker.Mode.date
        }
        Field.inputView = self.datePicker
        
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = false
        toolBar.tintColor = .white
        toolBar.barTintColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        toolBar.sizeToFit()

        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick ))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        Field.inputAccessoryView = toolBar
     //   self.blackBack.isHidden = true

    }
    
    var beforeText : String?
    var permissionDateValue = Int(Date().timeIntervalSince1970) - (Int(Date().timeIntervalSince1970)%86400) - 19800
    var entryTimeValue = (43200-19800)
    @objc func doneClick() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateStyle = .none
        dateFormatter2.timeStyle = .short
        if activeTextField == permissionDateText {
        activeTextField.text = dateFormatter1.string(from: datePicker.date)
        permissionDateValue = Int(datePicker.date.timeIntervalSince1970) - (Int(datePicker.date.timeIntervalSince1970)%86400) - 19800
        }
        else {
            
            activeTextField.text = dateFormatter2.string(from: datePicker.date)
            entryTimeValue = ((Int(datePicker.date.timeIntervalSince1970)%86400) - 19800)
        }
        activeTextField.resignFirstResponder()
        self.blackBack.isHidden = true

    }
    
    @objc func cancelClick() {
        activeTextField.text = beforeText!
        activeTextField.resignFirstResponder()
        self.blackBack.isHidden = true

    }
    
    @objc private func textFieldDidBeginEditing(textField : UITextField) {
        beforeText = textField.text
        pickUpDate(forField: textField)
        activeTextField = textField
        
        
    }
    let sucessView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let progressHUD = ProgressHUD(text: "Applying Permission")
    let blackView = UIView()
    
    @objc func submitButtonPressed(){
        //    navigationController?.navigationBar.prefersLargeTitles = false
       // print(reporterId)
        if typeReason.text == "" ||  typeReason.textColor ==  UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22) {
            showToast(message: "Enter all fields")
        }
        else{
            let permission = Permission(date: permissionDateValue, shiftChange: shiftChangeStatus, time: entryTimeValue, reason: typeReason.text, empUuid: empUuid!, reporterId: reporterId!)
            presenter?.updatePermission(permission: permission)
            
            addingProgress()
            addSuccessView()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                // self.navigationController?.pushViewController(profileView(), animated: true)
                self.blackView.isHidden = false
                self.progressHUD.isHidden = true
                self.sucessView.isHidden = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                // self.navigationController?.pushViewController(profileView(), animated: true)
              
                }
                self.presenter?.presentHomeTab(from : self, with: self.empUuid!)
        }
       
    }
    func addingProgress()  {
        blackView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.addSubview(blackView)
        view.addSubview(sucessView)
        sucessView.isHidden = true
        
        self.view.addSubview(progressHUD)
        addSuccessView()
        sucessView.translatesAutoresizingMaskIntoConstraints = false
        sucessView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sucessView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        sucessView.widthAnchor.constraint(equalToConstant: view.frame.width/2.5).isActive = true
        sucessView.heightAnchor.constraint(equalToConstant: view.frame.width/2.5).isActive = true
        blackView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        blackView.isHidden = true
    }
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
    
    
   
}

