//
//  PaySlip.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 25/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class PaySlipView : UIViewController, UITableViewDataSource, UITableViewDelegate , PaySlipViewProtocol{
    func UpdatedPaySlip(paySlip: PaySlip) {
        self.paySlip = paySlip
    }
    var empUuid = "vel"
    var paySlip : PaySlip?
    var presenter : PaySlipPresenterProtocol?
    var scrollView :  UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.isScrollEnabled = true
        return scroll
    }()
    
    var backView : UIImageView = {
        let backView = UIImageView()
    //    backView.backgroundColor = .red
        backView.image = UIImage(named: "payBack")
        backView.contentMode = .scaleAspectFit
        backView.alpha = 0.02
        return backView

    }()
    var grossCorners : UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor(red: 0/255.0, green: 46/255.0, blue: 110/255.0, alpha: 1).cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    var grossTitle : UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "GROSS PAY"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .blue
        label.textColor = UIColor(red: 0/255.0, green: 46/255.0, blue: 110/255.0, alpha: 1)
        return label
    }()
    
    var grossValue : UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "₹ 12,137"
        label.font = label.font.withSize(70)
        label.textAlignment = .center
        label.textColor = UIColor(red: 0/255.0, green: 46/255.0, blue: 110/255.0, alpha: 1)
        return label
    }()
    var nettCorners : UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor(red: 0/255.0, green: 46/255.0, blue: 110/255.0, alpha: 1).cgColor
        view.layer.borderWidth = 0.25
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()

    
    var nettTitle : UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "Net pay"
        label.textAlignment =  .center
        label.font = UIFont(name: "Futura-MediumItalic", size: 25)!
        label.textColor = .black
        label.clipsToBounds = true
        label.backgroundColor =  UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
        return label
    }()
    
    var nettValue : UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = label.font.withSize(70)
        label.font = UIFont.systemFont(ofSize: 70, weight: .thin)
        label.textAlignment = .center
     //   label.textColor = UIColor(red: 38/255.0, green: 95/255.0, blue: 177/255.0, alpha: 1)
        return label
    }()
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func  tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerText = UILabel()
       // headerText.textColor = UIColor.blue
        headerText.adjustsFontSizeToFitWidth = true
        if(tableView == payments){
        headerText.text = "Gross pay"
        }
        else{
            headerText.text = "Deduction "
        }
       // headerText.textColor = .white
        headerText.textAlignment = .center
        headerText.font = UIFont(name: "Futura-MediumItalic", size: 20)!
        headerText.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
        return headerText
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == payments{
        return 5
        }
        else{
        return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! paymentCell
        if tableView == payments{
            if indexPath.row == 0{
                cell.title.text = "Basic Salary"
                cell.value.text = String( paySlip!.getBasicSalary())
            }
            if indexPath.row == 1{
                cell.title.text = "Rent Allowance"
                cell.value.text = String( paySlip!.getHomeRentAllowance())
            }
            if indexPath.row == 2{
                cell.title.text = "Conveyance Allowance"
                cell.value.text = String( paySlip!.getConveyanceAllowance() )
            }
            if indexPath.row == 3{
                cell.title.text = "Medical Allowance"
                cell.value.text = String( paySlip!.getMedicalAllowance())
            }
            if indexPath.row == 4{
                cell.title.text = "Travel Allowance"
                cell.value.text = String( paySlip!.getTravelAllowance())
            }
        }
        else {
            if indexPath.row == 0 {
                cell.title.text = "Profident Fund"
                cell.value.text = String( paySlip!.getProfidentFund())
            }
            if indexPath.row == 1 {
                cell.title.text = "Insurance"
                cell.value.text = String( paySlip!.getInsuranceAmount() )
            }
        }
        return cell
    }
    var payments : UITableView!
    var detuctions : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        PaySlipRouter.createPaySlipModule(paySlipRef: self)
        presenter?.getPaySlip(empUuid: empUuid)
        payments = UITableView()
        payments.register(paymentCell.self, forCellReuseIdentifier: "cell")
        payments.delegate = self
        payments.dataSource = self
        payments.rowHeight = 40
        payments.layer.cornerRadius = 15
        payments.isScrollEnabled = false
        detuctions  = UITableView()
        detuctions.register(paymentCell.self, forCellReuseIdentifier: "cell")
        detuctions.delegate = self
        detuctions.dataSource = self
        detuctions.rowHeight = 40
        detuctions.layer.cornerRadius = 15
        detuctions.isScrollEnabled = false
        view.backgroundColor = .white
        view.addSubview(scrollView)
        view.addSubview(backView)
//        scrollView.addSubview(grossCorners)
//        scrollView.addSubview(grossTitle)
//        scrollView.addSubview(grossValue)
        scrollView.addSubview(nettCorners)
        scrollView.addSubview(nettTitle)
        scrollView.addSubview(nettValue)
        scrollView.addSubview(payments)
        scrollView.addSubview(detuctions)
        payments.layer.borderWidth = 0.26
        detuctions.layer.borderWidth = 0.25
      //  scrollView.backgroundColor = UIColor(red: 137/255.0, green: 196/255.0, blue: 244/255.0, alpha: 0.2)
        updateTotalSalary()
        setConstrains()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Pay Slip"
        scrollView.contentSize  = CGSize(width: view.frame.width, height: 750)
    }
    func updateTotalSalary(){
        let grossSalary = (paySlip!.getBasicSalary()) + (paySlip!.getMedicalAllowance()) + (paySlip!.getConveyanceAllowance()) + (paySlip!.getTravelAllowance()) + paySlip!.getHomeRentAllowance()
        let deduce = paySlip!.getInsuranceAmount() + paySlip!.getProfidentFund()
        let nettSalary = grossSalary - deduce
        nettValue.text = "₹ " + String(nettSalary)
        
    }
    func setConstrains(){
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        backView.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 30, left: 30, bottom: 50, right: 30))
//        grossCorners.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 40, bottom: 0, right: 40), size: CGSize(width: 0, height: 160))
//        grossTitle.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 25, left: 50, bottom: 0, right: 50), size: CGSize(width: 0, height: 50))
//        grossValue.anchor(top: grossTitle.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 50, bottom: 0, right: 50), size: CGSize(width: 0, height: 80))
        nettCorners.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 40, bottom: 0, right: 40), size: CGSize(width: 0, height: 160))
        nettTitle.anchor(top: nettCorners.topAnchor, leading: nettCorners.leadingAnchor, bottom: nil, trailing: nettCorners.trailingAnchor,size: CGSize(width: 0, height: 50))
        nettValue.anchor(top: nettTitle.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 40, bottom: 0, right: 40), size: CGSize(width: 0, height: 80))
        payments.anchor(top: nettCorners.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 30, left: 40, bottom: 0, right: 40), size: CGSize(width: 0, height: 240))
        detuctions.anchor(top: payments.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 30, left: 40, bottom: 0, right: 40), size: CGSize(width: 0, height: 120))
        
        
    }
    

    
}

class paymentCell : UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCells()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var title : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura-MediumItalic", size: 18)!
        label.textColor = UIColor(red: 0/255.0, green: 46/255.0, blue: 110/255.0, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    var value : UILabel = {
        let label = UILabel()
     //   label.textColor = UIColor(red: 0/255.0, green: 46/255.0, blue: 110/255.0, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    func setupCells(){
         self.addSubview(title)
         self.addSubview(value)
         setConstrains()
        self.selectionStyle = .none
    
    }
    func setConstrains(){
        title.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0), size: CGSize(width: self.frame.width*(2/3), height: 0))
        value.anchor(top: self.topAnchor, leading: title.trailingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
    }
}
