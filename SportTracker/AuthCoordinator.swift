import SwiftUI

class AuthCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(animated: Bool) {
        
        let viewModel = LoginViewModel()
        let vc = UIHostingController(rootView: LoginView(viewModel: viewModel))
        navigationController.pushViewController(vc, animated: animated)
    }
}
