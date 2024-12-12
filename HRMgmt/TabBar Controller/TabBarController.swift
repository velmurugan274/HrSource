import Foundation
import UIKit
class TabBarController: UIViewController {
    
    var empUuid : String = ""
    
    let  tabbar = UITabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBarController()
        print("yespd")
        tabbar.selectedIndex = 1
        tabbar.tabBar.isTranslucent = false
        tabbar.tabBar.tintColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
      //  tabbar.tabBar.barTintColor = UIColor(red: 231.0/255.0, green: 243/255.0, blue:253/255.0, alpha: 1)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createTabBarController() {
        
        
        let firstVc = PeopleView()
      //  firstVc.title = "Services"
        firstVc.empUuid = empUuid
        firstVc.tabBarItem = UITabBarItem.init(tabBarSystemItem: .contacts, tag: 0)
        
        let secondVc = HomeView()
        secondVc.title = "Home"
        secondVc.empUuid = empUuid
        secondVc.tabBarItem = UITabBarItem.init(title: "Home", image: UIImage(named: "home"), tag: 1)
        
        let thirdVc = ServicesView()
        thirdVc.title = "More"
        thirdVc.empUuid = empUuid
        thirdVc.tabBarItem = UITabBarItem.init(title: "Featured", image: resizeImage(image: UIImage(named: "More")!, targetSize: CGSize(width: 24, height: 24)), tag: 2)
        
        let controllerArray = [firstVc, secondVc, thirdVc]
        tabbar.viewControllers = controllerArray.map { UINavigationController(rootViewController: $0) }
        
        self.view.addSubview(tabbar.view)
    }
}
