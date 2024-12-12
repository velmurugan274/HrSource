import Foundation
import UIKit
class ApplyLeaveView : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource , UITextViewDelegate , ApplyLeaveViewProtocol {
    func setDeptId(deptId: String) {
        self.deptUuid = deptId
    }
    
    var empUuid : String?
    var deptUuid : String?
    var fromDate : Int64?
    var toDate  : Int64?
    var activeTextField : UITextField!
    let line : UIView = {
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

    let line1 : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    var leaveTypeList = [LeaveType.compensatoryOff.rawValue, LeaveType.longLeave.rawValue ,LeaveType.teamTrip.rawValue, LeaveType.optionalLeave.rawValue ] 
    var datePicker = UIDatePicker()
    var scrollView :  UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.isScrollEnabled = true
        return scroll
    }()
    var leaveType : UILabel = {
        let label = UILabel()
        label.text = "Leave Type  "
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
     //   label.backgroundColor = UIColor(red: 137/255.0, green: 196/255.0, blue: 244/255.0, alpha: 0.2)
      //  label.font = UIFont(name: "OpenSans", size: 30)
        label.font = UIFont(name: "Futura-MediumItalic", size: 18)!
       // label.isHidden = true
        return label
    }()
    var From : UILabel = {
        let label = UILabel()
        label.text = "From  "
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
     //   label.backgroundColor = UIColor(red: 137/255.0, green: 196/255.0, blue: 244/255.0, alpha: 0.2)
        label.font = UIFont(name: "Futura-MediumItalic", size: 18)!
        
       // label.isHidden = true
        return label
    }()
    var to : UILabel = {
        let label = UILabel()
        label.text = "To  "
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.font = UIFont(name: "Futura-MediumItalic", size: 18)!
        return label
    }()
    var reason : UILabel = {
        let label = UILabel()
        label.text = "Reason "
       // label.backgroundColor = UIColor(red: 137/255.0, green: 196/255.0, blue: 244/255.0, alpha: 0.2)
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.font = UIFont(name: "Futura-MediumItalic", size: 18)!
     //   label.isHidden = true
        return label
    }()
    var arrowImage :  UIImageView = {
        let imageview = UIImageView(image: UIImage(named: "arrowImage"))
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    var calendarImage :  UIImageView = {
        let imageview = UIImageView(image: UIImage(named: "calendarImage"))
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    var calendarImage1 :  UIImageView = {
        let imageview = UIImageView(image: UIImage(named: "calendarImage"))
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    var selectLeaveType : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.text = "SELECT"
        textField.layer.masksToBounds = false
        textField.layer.cornerRadius = 5
        textField.textAlignment = .left
        textField.tintColor = .clear
        return textField
    }()
    var selectFromDate : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.text = "SELECT"
        textField.layer.masksToBounds = false
        textField.layer.cornerRadius = 5
        textField.textAlignment = .left
        textField.tintColor = .clear
        return textField
    }()
    var selectToDate : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.text = "SELECT"
        textField.layer.masksToBounds = false
        textField.layer.cornerRadius = 5
        textField.textAlignment = .left
        textField.tintColor = .clear
        return textField
    }()
    
    var typeReason : UITextView = {
        let textView = UITextView()
        textView.text = " Reason "
        textView.textColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
        textView.layer.masksToBounds = false
        textView.font = UIFont(name: textView.font!.fontName, size: 18)
      //  textView.layer.cornerRadius = 5
     //   textView.layer.borderColor = UIColor.darkGray.cgColor
        textView.backgroundColor = .clear
     //   textView.layer.borderWidth = 0.5
        return textView
        
    }()
    
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    var presenter : ApplyLeavePresenterProtocol? = nil
    
    var submitButton : UIButton = {
        let button = UIButton()
        button.setTitle("SUBMIT", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        return button
    }()
    
    let sucessView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
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
        view.backgroundColor = .white
        
        if selectToDate.text != "" {
            to.isHidden = false
        }
        if selectFromDate.text != "" {
            From.isHidden = false
        }
        ApplyLeaveRouter.createApplyLeaveModule(applyLeaveRef: self)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 600)
        view.addSubview(scrollView)
        
        scrollView.addSubview(selectLeaveType)
        scrollView.addSubview(leaveType)
        scrollView.addSubview(line)
        selectLeaveType.addSubview(arrowImage)
        
        scrollView.addSubview(selectToDate)
        scrollView.addSubview(to)
        scrollView.addSubview(line1)
        selectToDate.addSubview(calendarImage)
        
        scrollView.addSubview(selectFromDate)
        scrollView.addSubview(From)
        scrollView.addSubview(line2)
        selectFromDate.addSubview(calendarImage1)
        
        scrollView.addSubview(typeReason)
        scrollView.addSubview(reason)
        scrollView.addSubview(line3)
        
        adjustUITextViewHeight(arg: typeReason)
        scrollView.addSubview(submitButton)
        
        
        
        navigationItem.title = "Apply Leave "
        typeReason.delegate = self
        selectFromDate.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .allEditingEvents)
        
        selectToDate.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .allEditingEvents)
        
        submitButton.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
        
        setConstrains()
        selectLeaveType.addTarget(self, action: #selector(textButton), for: .allEditingEvents)
       
        scrollView.addSubview(blackBack)
        blackBack.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        //        scrollView.addGestureRecognizer(tap)
        hideKeyboardWhenTapped()

        
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
    

    func setConstrains(){
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        leaveType.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 0) , size: CGSize(width: 0, height: 20))
        selectLeaveType.anchor(top: leaveType.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) , size: CGSize(width: 0, height: 40))
        line.anchor(top: selectLeaveType.bottomAnchor , leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size : CGSize(width: 0, height: 0.5))
        arrowImage.anchor(top: selectLeaveType.topAnchor, leading: nil, bottom: selectLeaveType.bottomAnchor, trailing: selectLeaveType.trailingAnchor, size : CGSize(width: 25, height: 0))
        
        
        From.anchor(top: line.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 0) , size: CGSize(width: 0, height: 20))
        selectFromDate.anchor(top: From.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) , size: CGSize(width: 0, height: 40))
        line1.anchor(top: selectFromDate.bottomAnchor , leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size : CGSize(width: 0, height: 0.5))
        calendarImage.anchor(top: selectFromDate.topAnchor, leading: nil, bottom: selectFromDate.bottomAnchor, trailing: selectFromDate.trailingAnchor, size : CGSize(width: 25, height: 0))
        
        to.anchor(top: line1.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 0) , size: CGSize(width: 0, height: 20))
        selectToDate.anchor(top: to.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) , size: CGSize(width: 0, height: 40))
        line2.anchor(top: selectToDate.bottomAnchor , leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size : CGSize(width: 0, height: 0.5))
        calendarImage1.anchor(top: selectToDate.topAnchor, leading: nil, bottom: selectToDate.bottomAnchor, trailing: selectToDate.trailingAnchor, size : CGSize(width: 25, height: 0))
        
        reason.anchor(top: line2.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 0) , size: CGSize(width: 0, height: 20))
        typeReason.anchor(top: reason.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) , size: CGSize(width: 0, height: 0))
        line3.anchor(top: typeReason.bottomAnchor , leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size : CGSize(width: 0, height: 0.5))
        
        
        submitButton.anchor(top: line3.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets.init(top: 20, left: 100, bottom: 0, right: 100), size: CGSize.init(width: 0, height: 50))
        
    }
    
    @objc func blueBorder(textField : UITextField){
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1).cgColor
    }
    
    @objc func grayBorder(textField : UITextField){
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.darkGray.cgColor
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
    
    func pickUpDate(forField Field : UITextField){
        
        // DatePicker
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker.backgroundColor = UIColor(red: 233.0/255.0, green: 233.0/255.0, blue: 233/255.0, alpha: 1)
        self.datePicker.datePickerMode = UIDatePicker.Mode.date
        Field.inputView = self.datePicker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = false
        toolBar.tintColor = .white
        toolBar.barTintColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ApplyLeaveView.doneClick ))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(ApplyLeaveView.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        Field.inputAccessoryView = toolBar
        
    }
    
    @objc func doneClick() {
       // blackBack.isHidden = true
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        dateFormatter1.timeZone = (NSTimeZone(name: "IST")! as TimeZone)
        if activeTextField == selectToDate {
            toDate = Int64(datePicker.date.timeIntervalSince1970) - (Int64(datePicker.date.timeIntervalSince1970)%86400) - 19800
            
        }
        else{
            fromDate = Int64(datePicker.date.timeIntervalSince1970) - (Int64(datePicker.date.timeIntervalSince1970)%86400) - 19800
        }
      //  print(datePicker.date)
        activeTextField.text = dateFormatter1.string(from: datePicker.date)
        activeTextField.resignFirstResponder()
        blackBack.isHidden = true
    }
    
    @objc func cancelClick() {
        
       // activeTextField.text = beforeText
        
        activeTextField.resignFirstResponder()
        blackBack.isHidden = true
        
    }
    
        @objc private func textFieldDidBeginEditing(textField : UITextField) {
            beforeText = textField.text
            blackBack.isHidden = false
            pickUpDate(forField: textField)
            activeTextField = textField
            
        }

    var beforeText : String?
    @objc func textButton(sender: AnyObject) {
        beforeText = sender.text
        
        blackBack.isHidden = false
        
        let picker: UIPickerView
        picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        picker.backgroundColor = UIColor(red: 233.0/255.0, green: 233.0/255.0, blue: 233/255.0, alpha: 1)
        
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = false
        toolBar.tintColor = .white
        toolBar.barTintColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelPicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        selectLeaveType.inputView = picker
        selectLeaveType.inputAccessoryView = toolBar
        
    }
    
    let progressHUD = ProgressHUD(text: "Applying Leave")
    let blackView = UIView()
    @objc func submitButtonPressed(){
    //    presenter?.updateLeave(leave: le)
        if selectLeaveType.text == "" || selectToDate.text == "" || selectFromDate.text == "" || typeReason.textColor == UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22) {
            showToast(message: "Please enter all values")
        }else if fromDate! > toDate! {
            showToast(message: "From date cannot be greater than to date")
            
        }
        else {
            presenter?.getDeptId(empUuid: empUuid!)
            
            let anEnum = LeaveType(rawValue: selectLeaveType.text!)!
            print(anEnum)
            let leave = Leave(employeeId: empUuid!, leaveType: anEnum, startDate: fromDate!, endDate: toDate!, deptId: deptUuid! , reason: typeReason.text)
        presenter?.updateLeave(leave: leave)
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
                self.presenter?.presentHomeTab(from : self, with: self.empUuid!)
            }
       
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
    
   
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return leaveTypeList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return leaveTypeList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedValue = leaveTypeList[row]
    }
    var selectedValue : String?
    @objc func donePicker() {
        selectLeaveType.text = selectedValue
        selectLeaveType.resignFirstResponder()
        blackBack.isHidden = true
    }
    
    @objc func cancelPicker() {
        selectLeaveType.text = beforeText
        selectLeaveType.resignFirstResponder()
        blackBack.isHidden = true
    }
    
}
