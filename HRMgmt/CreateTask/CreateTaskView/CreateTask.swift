import Foundation
import UIKit
class CreateTask : UIViewController, UITextFieldDelegate , UIPickerViewDelegate, UIPickerViewDataSource ,UITextViewDelegate, CreateTaskViewProtocol{
    func setTaskOwners(taskOwners: [TaskOwners]) {
        self.taskOwners = taskOwners
    }
    
    
    var empUuid :  String?
    var presenter : CreateTaskPresenterProtocol?
    var activeTextField : UITextField!
    var datePicker = UIDatePicker()
    let taskOwnerPicker = [String]()
    var taskOwners = [TaskOwners]()
    var scrollView :  UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.isScrollEnabled = true
        return scroll
    }()
    var taskOwner : UILabel = {
        let label = UILabel()
        label.text = "Task Owner  "
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.font = UIFont(name: "Futura-MediumItalic", size: 18)!
        return label
    }()
    var taskName : UILabel = {
        let label = UILabel()
        label.text = "Task Name  "
        label.textColor =  UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.font = UIFont(name: "Futura-MediumItalic", size: 18)!
        return label
    }()
    var selectTaskOwner : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.text = "SELECT"
        textField.layer.masksToBounds = false
        textField.tintColor = .clear
        return textField
    }()
    var selectFromDate : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.text = "SELECT"
        textField.layer.masksToBounds = false
        textField.tintColor = .clear
        textField.allowsEditingTextAttributes = false
        return textField
    }()
    var selectToDate : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.text = "SELECT"
        textField.layer.masksToBounds = false
        textField.tintColor = .clear
        textField.allowsEditingTextAttributes = false
        return textField
    }()
    var typeDescription : UITextView = {
        let textView = UITextView()
        textView.text = " Reason "
        textView.textColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
        textView.layer.masksToBounds = false
        textView.font = UIFont(name: textView.font!.fontName, size: 18)
        
        textView.backgroundColor = .clear
        //   textView.layer.borderWidth = 0.5
        return textView
    }()
    var typeTaskName : UITextView = {
        let textView = UITextView()
        textView.text = " Task Name "
        textView.textColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
        textView.layer.masksToBounds = false
        textView.font = UIFont(name: textView.font!.fontName, size: 18)
        //  textView.layer.cornerRadius = 5
        //   textView.layer.borderColor = UIColor.darkGray.cgColor
        textView.backgroundColor = .clear
        //   textView.layer.borderWidth = 0.5
        return textView
    }()
    var From : UILabel = {
        let label = UILabel()
        label.text = "From  "
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.font = UIFont(name: "Futura-MediumItalic", size: 18)!
        return label
    }()
    var to : UILabel = {
        let label = UILabel()
        label.text = "To  "
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.font = UIFont(name: "Futura-MediumItalic", size: 18)!
        return label
    }()
    var taskDescription : UILabel = {
        let label = UILabel()
        label.text = "Description  "
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.font = UIFont(name: "Futura-MediumItalic", size: 18)!
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
    
    let line4 : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
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
    
    var submitButton : UIButton = {
        let button = UIButton()
        button.setTitle("SUBMIT", for: .normal)
        button.setTitleColor(UIColor(red: 231.0/255.0, green: 243/255.0, blue:253/255.0, alpha: 1), for: .normal)
        //   button.titleLabel?.textColor = .blue
        //   button.layer.borderColor = UIColor.blue.cgColor
        //   button.layer.borderWidth = 2
        button.backgroundColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //     self.tabBarController?.tabBar.isHidden = true
        
        CreateTaskRouter.createCreateTaskModule(createTaskRef: self)
        presenter?.getTaskOwner(empUuid: empUuid!)
        taskOwners.append(TaskOwners(empUuid: empUuid!, empName: "Self"))
        typeDescription.delegate = self
        scrollView.contentSize = view.frame.size
        view.backgroundColor = .white
        view.addSubview(scrollView)
        
        scrollView.addSubview(selectTaskOwner)
        scrollView.addSubview(taskOwner)
        taskOwner.addSubview(arrowImage)
        scrollView.addSubview(line)
        
        scrollView.addSubview(typeTaskName)
        scrollView.addSubview(taskName)
        adjustUITextViewHeight(arg: typeTaskName)
        scrollView.addSubview(line1)
        
        scrollView.addSubview(typeDescription)
        scrollView.addSubview(taskDescription)
        adjustUITextViewHeight(arg: typeDescription)
        scrollView.addSubview(line2)
        
        
        
        scrollView.addSubview(selectFromDate)
        scrollView.addSubview(From)
        scrollView.addSubview(line3)
        selectFromDate.addSubview(calendarImage)
        
        scrollView.addSubview(selectToDate)
        scrollView.addSubview(to)
        scrollView.addSubview(line4)
        selectFromDate.addSubview(calendarImage1)
        
        //view.addSubview(cancelButton)
        scrollView.addSubview(submitButton)
        typeTaskName.delegate = self
        //  scrollView.backgroundColor = UIColor(red: 239.0/255.0, green: 240.0/255.0, blue: 244.0/255.0, alpha: 1)
        //scrollView.backgroundColor = UIColor(red: 231.0/255.0, green: 243/255.0, blue:253/255.0, alpha: 1)
        navigationItem.title = "Create Task"
        //  selectFromDate.delegate = self
        selectFromDate.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .allEditingEvents)
        
        selectToDate.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .allEditingEvents)
        
        submitButton.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
        
        selectTaskOwner.addTarget(self, action: #selector(textButton), for: .allEditingEvents)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain , target: self, action: #selector(cancelTask))
        
        
       
        setConstrains()
        
//        tap.cancelsTouchesInView = false
    //    blackBack.isUserInteractionEnabled = true
        scrollView.addSubview(blackBack)
        blackBack.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
//        scrollView.addGestureRecognizer(tap)
        hideKeyboardWhenTapped()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
    }
    @objc func cancelTask(){
        navigationController?.dismiss(animated: true, completion: nil)
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
        taskOwner.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 0) , size: CGSize(width: 0, height: 20))
        selectTaskOwner.anchor(top: taskOwner.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) , size: CGSize(width: 0, height: 40))
        line.anchor(top: selectTaskOwner.bottomAnchor , leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size : CGSize(width: 0, height: 0.5))
        arrowImage.anchor(top: selectTaskOwner.topAnchor, leading: nil, bottom: selectTaskOwner.bottomAnchor, trailing: selectTaskOwner.trailingAnchor, size : CGSize(width: 25, height: 0))
        
        
        taskName.anchor(top: line.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 0) , size: CGSize(width: 0, height: 20))
        typeTaskName.anchor(top: taskName.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) , size: CGSize(width: 0, height: 0))
        line1.anchor(top: typeTaskName.bottomAnchor , leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size : CGSize(width: 0, height: 0.5))
        
        taskDescription.anchor(top: line1.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 0) , size: CGSize(width: 0, height: 20))
        typeDescription.anchor(top: taskDescription.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) , size: CGSize(width: 0, height: 0))
        line2.anchor(top: typeDescription.bottomAnchor , leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size : CGSize(width: 0, height: 0.5))
        
        From.anchor(top: line2.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 0) , size: CGSize(width: 0, height: 20))
        selectFromDate.anchor(top: From.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) , size: CGSize(width: 0, height: 40))
        line3.anchor(top: selectFromDate.bottomAnchor , leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size : CGSize(width: 0, height: 0.5))
        calendarImage.anchor(top: selectFromDate.topAnchor, leading: nil, bottom: selectFromDate.bottomAnchor, trailing: selectFromDate.trailingAnchor, size : CGSize(width: 25, height: 0))
        
        to.anchor(top: line3.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 0) , size: CGSize(width: 0, height: 20))
        selectToDate.anchor(top: to.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) , size: CGSize(width: 0, height: 40))
        line4.anchor(top: selectToDate.bottomAnchor , leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size : CGSize(width: 0, height: 0.5))
        calendarImage1.anchor(top: selectToDate.topAnchor, leading: nil, bottom: selectToDate.bottomAnchor, trailing: selectToDate.trailingAnchor, size : CGSize(width: 25, height: 0))
        
 
        submitButton.anchor(top: line4.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets.init(top: 50, left: 120, bottom: 0, right: 120), size: CGSize.init(width: 0, height: 50))
       
        
        
        
    }

    
    
    @objc func handleTap() {
        blackBack.isHidden = true
      //  print("yes")
        activeTextField.resignFirstResponder()
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

    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    
    func pickUpDate(forField Field : UITextField){
        
        // DatePicker
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker.backgroundColor = UIColor(red: 233.0/255.0, green: 233.0/255.0, blue: 233/255.0, alpha: 1)
        self.datePicker.datePickerMode = UIDatePicker.Mode.date
        Field.inputView = self.datePicker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
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
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        if activeTextField == selectToDate {
            toDate = Int64(datePicker.date.timeIntervalSince1970) - (Int64(datePicker.date.timeIntervalSince1970)%86400) - 19800
            
        }
        else{
            fromDate = Int64(datePicker.date.timeIntervalSince1970) - (Int64(datePicker.date.timeIntervalSince1970)%86400) - 19800
        }
        activeTextField.text = dateFormatter1.string(from: datePicker.date)
        activeTextField.resignFirstResponder()
        self.blackBack.isHidden = true

    }
    
    @objc func cancelClick() {
        activeTextField.resignFirstResponder()
        self.blackBack.isHidden = true
        
    }
    
    @objc private func textFieldDidBeginEditing(textField : UITextField) {
        blackBack.isHidden = false
        pickUpDate(forField: textField)
        activeTextField = textField
        
    }
   
    @objc func submitButtonPressed(){
        if(typeTaskName.text=="" || typeDescription.text=="" || selectToDate.text == "" || selectFromDate.text == "" || selectToDate.text == "SELECT" || selectFromDate.text == "SELECT" || selectTaskOwner.text == "" || selectTaskOwner.text == "SELECT" ){
        showToast(message: "Enter all credentials")
        }else if fromDate! > toDate! {
            showToast(message: "From date cannot be greater than to date")
            
        } else{
            let task = Task(empId: taskOwnerId!, taskName: typeTaskName.text, taskDetails: typeDescription.text, startDate: fromDate!, endDate: toDate!, taskStatus: .incomplete, taskAssigner: empUuid!, taskId: UUID().uuidString)
            presenter?.updateTask(task: task)
            presenter?.presentHomeTab(from: self, with: empUuid!)
        }
    }
    
    var taskOwnerId : String?
    var toDate : Int64?
    var fromDate : Int64?
    
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
        toolBar.isTranslucent = false
        toolBar.tintColor = .white
        toolBar.barTintColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(CreateTask.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(CreateTask.cancelPicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        selectTaskOwner.inputView = picker
        selectTaskOwner.inputAccessoryView = toolBar
    }
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return taskOwners.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return taskOwners[row].empName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectTaskOwner.text = taskOwners[row].empName
        taskOwnerId = taskOwners[row].empUuid
    }
    
    @objc func donePicker() {

       
        selectTaskOwner.resignFirstResponder()
        blackBack.isHidden = true
        
    }
    
    @objc func cancelPicker(){
        selectTaskOwner.text = "SELECT"
        selectTaskOwner.resignFirstResponder()
        blackBack.isHidden = true
    }
    
}
struct TaskOwners{
    var empUuid : String?
    var empName : String?
    init(empUuid : String, empName : String){
        self.empUuid = empUuid
        self.empName = empName
    }
}

