import UIKit
import SwiftUI
import FirebaseCore
import FirebaseAuth

final class AppCoordinator: Coordinator {
    
    lazy var sportRecordingsOverviewCoordinator: Coordinator = {
        let coordinator = SportRecordingsOverviewCoordinator(navigationController: navigationController)
        return coordinator
    }()
//
//    lazy var authCoordinator: Coordinator = {
//        let coordinator = AuthCoordinator(navigationController: navigationController)
//        return coordinator
//    }()
//    
    var navigationController: UINavigationController
   
//    let authManager: AuthManaging
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        
        self.navigationController.setNavigationBarHidden(true, animated: false)
//        authManager = AuthManager()
    }
    
    func start(animated: Bool) {
        
        FirebaseApp.configure()
        
//        if (authManager.isSignedIn()) {
            sportRecordingsOverviewCoordinator.start(animated: animated)
//        } else {
//            authCoordinator.start(animated: animated)
//        }
    }
}
