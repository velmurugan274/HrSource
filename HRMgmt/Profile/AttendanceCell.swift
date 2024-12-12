import Foundation
import UIKit
class AttendanceCell : UITableViewCell {
    var month : UILabel = {
        let day = UILabel()
        day.text = "Jan"
        day.textColor = .gray
        day.textAlignment = .center
        day.font = UIFont.systemFont(ofSize: 14, weight: .medium)
      //  day.textColor = .black
        return day
    }()
    
    var date : UILabel = {
        let date = UILabel()
        date.text = "05"
        date.font = date.font.withSize(24)
        date.textAlignment = .center
        date.textColor = .black
        return date
    }()
    
    var activeStatus : UILabel = {
        let label = UILabel()
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.backgroundColor = .green
        return label
    }()
    
    var day : UILabel = {
        let day = UILabel()
        day.text = "Monday"
        day.textColor = .black
        return day
    }()
    
    var hoursCount : UILabel = {
        let label  = UILabel()
        label.text = "04:30"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstrains()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
       
        self.addSubview(month)
        self.addSubview(date)
        self.addSubview(day)
        self.addSubview(hoursCount)
        self.addSubview(activeStatus)

    }
    
    private func setConstrains(){
     //   progress.translatesAutoresizingMaskIntoConstraints = false
        month.translatesAutoresizingMaskIntoConstraints = false
        date.translatesAutoresizingMaskIntoConstraints = false
        activeStatus.translatesAutoresizingMaskIntoConstraints = false
        let ccBorder = self.layoutMarginsGuide
        self.backgroundColor = .white
        month.topAnchor.constraint(equalTo: ccBorder.topAnchor, constant: 0).isActive = true
        month.leadingAnchor.constraint(equalTo: ccBorder.leadingAnchor, constant: 5).isActive = true
   //     month.bottomAnchor.constraint(equalTo: ccBorder.bottomAnchor, constant: -30).isActive = true
        month.widthAnchor.constraint(equalToConstant: 40).isActive = true
        date.topAnchor.constraint(equalTo: month.bottomAnchor, constant: 0).isActive = true
        date.leadingAnchor.constraint(equalTo: ccBorder.leadingAnchor, constant: 10).isActive = true
    //    date.bottomAnchor.constraint(equalTo: ccBorder.bottomAnchor, constant: -10).isActive = true
        date.widthAnchor.constraint(equalToConstant: 30).isActive = true
        day.anchor(top: self.topAnchor, leading: date.trailingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 15, left: 50, bottom: 15, right: 0), size: CGSize(width: 100, height: 0))
    
        hoursCount.anchor(top: self.topAnchor, leading: nil, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 15, left: 0 , bottom: 15, right: 15))
        activeStatus.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -90).isActive = true
        activeStatus.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activeStatus.heightAnchor.constraint(equalToConstant: 10).isActive = true
        activeStatus.widthAnchor.constraint(equalToConstant: 10).isActive = true
        self.selectionStyle = .none
        self.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
        
    }
}

