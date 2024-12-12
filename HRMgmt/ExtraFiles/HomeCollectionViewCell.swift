import Foundation
import UIKit
class HomeCollectionViewCell : UICollectionViewCell {
    
    var label: UILabel!
    //   var roundView = UIView()
    var image = UIImageView()
    var arrow = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        label = UILabel(frame: contentView.frame)
        self.addSubview(label)
        //  self.addSubview(roundView)
        self.addSubview(image)
        self.addSubview(arrow)
        self.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
        //let ccBorder = self.layoutMarginsGuide
        label.textAlignment = .left
        //label.font = UIFont.systemFont(ofSize: 2, weight: .bold)
        //label.textColor = .white
        image.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: UIEdgeInsets.init(top: 10, left: 15, bottom: 10, right: 0), size: CGSize(width: 40, height: 0))
        
        
        label.anchor(top: nil, leading: image.trailingAnchor, bottom: nil, trailing: self.trailingAnchor,padding: UIEdgeInsets.init(top: 0, left: 30, bottom: 0, right: 30),size: CGSize.init(width: 0, height: 0))
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        arrow.anchor(top: nil, leading: label.trailingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10))
        arrow.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        arrow.image = UIImage(named: "rightArrow")
        arrow.contentMode = .scaleAspectFit
        
        
        image.contentMode = .scaleAspectFit
        label.textAlignment = .left
        //  label.font = UIFont(name: label.font.fontName, size: 12)
        self.layer.cornerRadius = 15
        label.font = UIFont(name: "Futura-MediumItalic", size: 18)!
        
        
    }
    
    
}
