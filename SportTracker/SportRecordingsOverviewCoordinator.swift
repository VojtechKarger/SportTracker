import SwiftUI

class SportRecordingsOverviewCoordinator: Coordinator {
   
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(animated: Bool) {
        let provider = SportRecordingsProvider()
        let viewModel = SportRecordingsOverviewViewModel(sportRecordingsProvider: provider)
        let vc = UIHostingController(rootView: SportRecordingsOverviewView(viewModel: viewModel))
        
        navigationController.pushViewController(vc, animated: animated)
    }
}
