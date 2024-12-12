import UIKit
import Foundation

class makeAnnouncementRouter : MakeAnnouncementRouterProtocol{
    
    
    static func createMakeAnnouncementModule(makeAnnouncementRef: MakeAnnouncementView) {
        let presenter : MakeAnnouncementOutputInteractorProtocol & MakeAnnouncementPresenterProtocol = MakeAnnouncementPresenter()
        makeAnnouncementRef.presenter = presenter
        makeAnnouncementRef.presenter?.interactor = MakeAnnouncementInteractor()
        makeAnnouncementRef.presenter?.view = makeAnnouncementRef
        makeAnnouncementRef.presenter?.router = makeAnnouncementRouter()
        makeAnnouncementRef.presenter?.interactor?.presenter = presenter
    }
    
    
    
    
    
    func presentHomeTab(from view: UIViewController, with empUuid: String) {

        let vc = TabBarController()
        vc.empUuid = empUuid
        view.navigationController?.present(vc, animated: true, completion: nil)
    }
  
    
}
