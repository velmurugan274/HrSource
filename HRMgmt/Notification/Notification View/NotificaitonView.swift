import Foundation
import UIKit
class NotificationView : UIViewController, UITableViewDataSource, UITableViewDelegate , NotificationViewProtocol {
    func updatedIndividualNotificationList(notification: [Notifications]) {
        self.notification = notification
    }
    
    func updatedNotificationList(notification: [Notifications]) {
        self.notification = notification
    }
    
    var blueLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 216.0/255.0, green: 227/255.0, blue: 255/255.0, alpha: 1)
        label.layer.masksToBounds = true
        return label
    }()
    
    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Group", "Individual"])
        sc.selectedSegmentIndex = 0
        sc.layer.masksToBounds = true
        //  sc.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        return sc
    }()
    
    @objc  func handleSegmentChange() {
        print(segmentedControl.selectedSegmentIndex)
        switch segmentedControl.selectedSegmentIndex {
            
        case 0:
            presenter?.getNotificationList(empUuid: empUuid!)
        default:
            presenter?.getIndividualNotificationList(empUuid: empUuid!)
        }
        
        tableView.reloadData()
        checkEmpty()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if segmentedControl.selectedSegmentIndex == 0{
            presenter?.getNotificationList(empUuid: empUuid!)
            checkEmpty()
        }else{
            print("yes")
             presenter?.getIndividualNotificationList(empUuid: empUuid!)
            checkEmpty()
        }
        tableView.reloadData()
        checkEmpty()
    }
    
    var searching = false
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notification.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotificationCell
        cell.notificationDate.text =  DateController.getDateTimeFromTimeStamp(timeStamp: Double(notification[indexPath.row].getNotifDate()))
        cell.notificationTitle.text = notification[indexPath.row].getNotificationSubject()
        cell.notificationDetail.text = notification[indexPath.row].getNotificationBody()
        print(notification[indexPath.row].getNotifStatus())
        if notification[indexPath.row].getNotifStatus() == .unread{
        cell.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
        }else{
          //  cell.backgroundColor = UIColor(red: 137/255.0, green: 196/255.0, blue: 244/255.0, alpha: 0.1)
            cell.backgroundColor = .white
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if notification[indexPath.row].getNotifStatus() == .unread && segmentedControl.selectedSegmentIndex == 1{
            print("yes change")
          db.markIndividualStatusRead(notifId: notification[indexPath.row].getNotificationId())
        } else if notification[indexPath.row].getNotifStatus() == .unread && segmentedControl.selectedSegmentIndex == 0 {
            db.markNormalNotificationRead(notifId: notification[indexPath.row].getNotificationId(), empUuid: empUuid!)
        }
        presenter?.showFullNotification(from: self, with: notification[indexPath.row], with: empUuid!, with: self.segmentedControl.selectedSegmentIndex)
            
    }
    var empUuid : String?
    var notification = [Notifications]()
    var tableView = UITableView()
    var presenter : NotificationPresenterProtocol?
    var thinkView : UIImageView = {
        let thinkView = UIImageView(image: UIImage(named: "noNotif"))
        thinkView.contentMode = .scaleAspectFit
        thinkView.isHidden = true
        thinkView.alpha = 0.5
        return thinkView
    }()
    
    var thinkText : UILabel = {
        let label = UILabel()
        label.text = "No notifications to show"
        label.font = UIFont(name: "Futura-Medium", size: 15)!
        label.isHidden = true
        label.textColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationRouter.createNotificationModule(notificationRef: self)
        presenter?.getNotificationList(empUuid: empUuid!)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NotificationCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        view.addSubview(segmentedControl)
        navigationItem.title = "Notifications"
        view.backgroundColor = .white
        tableView.backgroundColor =  .clear
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        segmentedControl.layer.cornerRadius = 15
        setConstrains()
        navigationController?.navigationBar.prefersLargeTitles = true
        segmentedControl.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        tableView.bounces = false
        view.addSubview(thinkText)
        view.addSubview(thinkView)
        view.addSubview(blueLabel)
        thinkView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size : CGSize(width: view.frame.width/3.5, height: view.frame.width/3.5) )
        thinkView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        thinkView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        thinkText.anchor(top: thinkView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        thinkText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        checkEmpty()
        blueLabel.anchor(top: segmentedControl.topAnchor, leading: nil, bottom: segmentedControl.bottomAnchor, trailing: nil, size : CGSize(width: 20, height: 0))
        blueLabel.centerXAnchor.constraint(equalTo: segmentedControl.centerXAnchor).isActive = true
        blueLabel.layer.cornerRadius = 15.0
        tableView.tableFooterView = UIView(frame: .zero)
        
    }
    private func setConstrains(){
        
        tableView.rowHeight = 90
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20), size : CGSize(width: 0, height: 30))
        tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        

       // segmentedControl.tintColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        // self.segmentedControl.layer.masksToBounds = true
        self.segmentedControl.layer.cornerRadius = 15.0;
        self.segmentedControl.layer.borderColor = UIColor.gray.cgColor
        self.segmentedControl.layer.borderWidth = 1
        segmentedControl.tintColor = UIColor(red: 216/255.0, green: 227/255.0, blue: 255/255.0, alpha: 1)
        segmentedControl.backgroundColor = .white
        let textAttributes : [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont(name: "Futura-MediumItalic", size: 20)!]
        segmentedControl.setTitleTextAttributes(textAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(textAttributes, for: .selected)
        
    }
    func checkEmpty(){
        if notification.count == 0  {
            thinkView.isHidden = false
            thinkText.isHidden = false
        }else {
            thinkView.isHidden = true
            thinkText.isHidden = true
        }
    }

    
    
}


class NotificationCell : UITableViewCell {
    let senderImage : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ProfilePicture"))
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    var notificationTitle : UILabel = {
        let label = UILabel()
        label.text = "Velmurugan have sent you a new notificaiton"
        label.font = UIFont(name: "Futura-MediumItalic", size: 18)!
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let notificationDetail : UILabel  =  {
        let label = UILabel()
        label.text = "Velmurugan have sent you a new notificaiton"
       // label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    var notificationDate : UILabel = {
        let label = UILabel()
        label.text = "9 May, 12:13 PM"
        label.textColor = UIColor.gray
        label.font = label.font.withSize(10)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        self.addSubview(senderImage)
        self.addSubview(notificationTitle)
        self.addSubview(notificationDetail)
        self.addSubview(notificationDate)
       // self.backgroundColor = UIColor(red: 72.0/255.0, green: 133/255.0, blue: 237/255.0, alpha: 0.2)
     //   self.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
        setConstrains()
        senderImage.layer.cornerRadius = 30.0
        
    }
    
    func setConstrains(){
        let ccBorder = self.layoutMarginsGuide
        senderImage.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil,padding : UIEdgeInsets.init(top: 15, left: 15, bottom: 15, right: 0), size: CGSize.init(width: 60, height: 0))
        notificationTitle.anchor(top: self.topAnchor, leading: senderImage.trailingAnchor, bottom: nil, trailing: ccBorder.trailingAnchor, padding: UIEdgeInsets(top: 15, left: 10, bottom: 0, right: 0))
        notificationDetail.anchor(top: notificationTitle.bottomAnchor, leading: senderImage.trailingAnchor, bottom: nil, trailing: ccBorder.trailingAnchor, padding: UIEdgeInsets.init(top: -3, left: 10, bottom: 0, right: 0))
        notificationDate.anchor(top: notificationDetail.bottomAnchor, leading: senderImage.trailingAnchor, bottom: nil, trailing: ccBorder.trailingAnchor, padding: UIEdgeInsets.init(top: 2, left: 10, bottom: 0, right: 0))
    }
}
