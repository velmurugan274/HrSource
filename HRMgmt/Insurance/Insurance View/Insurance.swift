//
//  Insurance.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 25/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class InsuranceView : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InsuranceCell
        cell.title.text = titleText[indexPath.row]
        cell.details.text = detailText[indexPath.row]
        return cell
    }
    
    
    var titleText = ["Monthly Premium","Insurance Balance ", "For queries / Support" ]
    var detailText = ["₹.3000","₹ 4,00,000/4,00,000","1800-429-5000" ]
    
    var boolCheck = true
    var scrollView :  UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.isScrollEnabled = true
        return scroll
    }()
    var starLogo : UIImageView = {
        let backView = UIImageView()
        //    backView.backgroundColor = .red
        backView.image = UIImage(named: "InsuranceLogo")
        backView.contentMode = .scaleAspectFit
        backView.alpha = 0.05
        return backView
        
    }()
    var cardView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 0.1
        return view
    }()
    var insuranceCard : UILabel = {
        let label = UILabel()
        label.text = "Insurance Card  "
       // label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.font = UIFont(name: "Futura-MediumItalic", size: 18)!
        return label
    }()
    var insuranceHolderLabel : UILabel = {
        let label = UILabel()
        label.text = "Insurance Number  "
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.font = UIFont(name: "Futura-MediumItalic", size: 18)!
        return label
    }()
    var insuranceHolder : UILabel = {
        let label = UILabel()
        label.text = "AWDEK89532"
//        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    var cardHolderLabel : UILabel = {
        let label = UILabel()
        label.text = "Card Holder's Name "
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.font = UIFont(name: "Futura-MediumItalic", size: 18)!
        return label
    }()
    var cardHolder : UILabel = {
        let label = UILabel()
        label.text = "Velmurugan"
        //        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    var premiumTypeLabel : UILabel = {
        let label = UILabel()
        label.text = "Premium Type  "
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.font = UIFont(name: "Futura-MediumItalic", size: 18)!
        return label
    }()
    var premiumType : UILabel = {
        let label = UILabel()
        label.text = "GOLD Premium"
        //        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    var validTillLabel : UILabel = {
        let label = UILabel()
        label.text = "Valid Till"
        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.font = UIFont(name: "Futura-MediumItalic", size: 18)!
        return label
    }()
    var validTill : UILabel = {
        let label = UILabel()
        label.text = "Jan 2021"
        //        label.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    var cardProfilePic : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ProfilePicture")
        return image
    }()

    var insuranceCollection : UICollectionView?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let frame = self.view.frame
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 350, height: 80)
        layout.minimumLineSpacing = 15
        view.addSubview(scrollView)
        scrollView.addSubview(cardView)
        cardView.addSubview(starLogo)
        scrollView.addSubview(insuranceCard)
        cardView.addSubview(insuranceHolderLabel)
        cardView.addSubview(insuranceHolder)
        cardView.addSubview(cardHolder)
        cardView.addSubview(cardHolderLabel)
        cardView.addSubview(premiumType)
        cardView.addSubview(premiumTypeLabel)
        cardView.addSubview(validTillLabel)
        cardView.addSubview(validTill)
        cardView.addSubview(cardProfilePic)
        cardProfilePic.layer.masksToBounds = true
        cardProfilePic.layer.cornerRadius = 10
        
        insuranceCollection  = UICollectionView(frame: frame, collectionViewLayout: layout)
        insuranceCollection!.register(InsuranceCell.self, forCellWithReuseIdentifier: "cell")
        insuranceCollection!.dataSource = self
        insuranceCollection!.delegate = self
        insuranceCollection!.backgroundColor = .clear
        
        scrollView.addSubview(insuranceCollection!)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Insurance"
        setConstrains()
        scrollView.contentSize = CGSize(width: view.frame.width, height: 750)
        
    }
    func setConstrains()  {
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        cardView.anchor(top: scrollView.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0), size: CGSize(width: 360, height: 220))
        cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        starLogo.anchor(top: cardView.topAnchor, leading: cardView.leadingAnchor, bottom: cardView.bottomAnchor, trailing: cardView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
        insuranceCard.anchor(top: cardView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        insuranceCard.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        insuranceHolderLabel.anchor(top: cardView.topAnchor, leading: cardView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 0))
        insuranceHolder.anchor(top: insuranceHolderLabel.bottomAnchor, leading: cardView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0))
        cardHolderLabel.anchor(top: insuranceHolder.topAnchor, leading: cardView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 40, left: 20, bottom: 0, right: 0))
        cardHolder.anchor(top: cardHolderLabel.bottomAnchor, leading: cardView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0))
        premiumTypeLabel.anchor(top: cardHolder.topAnchor, leading: cardView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 40, left: 20, bottom: 0, right: 0))
        premiumType.anchor(top: premiumTypeLabel.bottomAnchor, leading: cardView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0))
        validTillLabel.anchor(top: cardHolder.topAnchor, leading: nil, bottom: nil, trailing: cardView.trailingAnchor, padding: UIEdgeInsets(top: 40, left: 50, bottom: 0, right: 20))
        validTill.anchor(top: premiumTypeLabel.bottomAnchor, leading: nil, bottom: nil, trailing: cardView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 20))
        cardProfilePic.anchor(top: cardView.topAnchor, leading: nil, bottom: nil, trailing: cardView.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 20), size: CGSize(width: 80, height: 80))
        insuranceCollection!.anchor(top: insuranceCard.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor , padding: UIEdgeInsets(top: 30, left: 30, bottom: 0, right: 30), size: CGSize(width: 0, height: 290))
    }

}

extension UIView{
    func animShow(){
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut],
                       animations: {
                        self.center.y += self.bounds.height 
                        self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    func animHide(){
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveLinear],
                       animations: {
                        self.center.y -= self.bounds.height
                        self.layoutIfNeeded()
                        
        },  completion: {(_ completed: Bool) -> Void in
            self.isHidden = true
        })
    }
}

class InsuranceCell :  UICollectionViewCell {

    var title : UILabel = {
        let headerText = UILabel()
        headerText.textColor = UIColor.blue
        headerText.adjustsFontSizeToFitWidth = true
        headerText.text = "Payments"
        headerText.textColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        headerText.textAlignment = .center
        headerText.font = UIFont(name: "Futura-MediumItalic", size: 20)!
        headerText.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
        return headerText
    }()
    let details : UILabel = {
        let headerText = UILabel()
        headerText.textColor = UIColor.blue
        headerText.adjustsFontSizeToFitWidth = true
        headerText.text = "Payments"
        headerText.textColor = .black
        headerText.textAlignment = .center
        headerText.font = UIFont.boldSystemFont(ofSize: 20.0)
        headerText.backgroundColor = .white
        return headerText
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCells()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupCells(){
        self.addSubview(title)
        self.addSubview(details)
        title.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, size : CGSize(width: 0, height: self.frame.height/2))
        details.anchor(top: title.bottomAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 0.1


    }
}
