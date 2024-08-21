import UIKit
import SwiftUI
import FirebaseCore

final class AppCoordinator: Coordinator {
    
    lazy var sportRecordingsOverviewCoordinator: Coordinator = {
        return SportRecordingsOverviewCoordinator(
            navigationController: navigationController,
            factory: factory.makeSportRecordingsOverviewFactory()
        )
    }()

    let factory = AppFactory()
    var navigationController: UINavigationController
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func start(animated: Bool) {
        
        FirebaseApp.configure()
        sportRecordingsOverviewCoordinator.start(animated: animated)
    }
}
