import UIKit
import SwiftUI
import FirebaseCore
import FirebaseAuth

final class AppCoordinator: Coordinator {
    
    lazy var sportRecordingsOverviewCoordinator: Coordinator = {
        let coordinator = SportRecordingsOverviewCoordinator(navigationController: navigationController)
        return coordinator
    }()
    
    lazy var loginCoordinator: Coordinator = {
        let coordinator = LoginCoordinator(navigationController: navigationController)
        return coordinator
    }()
    
    var navigationController: UINavigationController
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(animated: Bool) {
        
        FirebaseApp.configure()
        
        if (Auth.auth().currentUser != nil) {
            sportRecordingsOverviewCoordinator.start(animated: animated)
        } else {
            loginCoordinator.start(animated: animated)
        }
    }
}
