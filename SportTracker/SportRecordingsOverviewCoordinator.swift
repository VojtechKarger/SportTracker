import SwiftUI

class SportRecordingsOverviewCoordinator: Coordinator {
   
    let factory: SportRecordingsOverviewFactory = .init(coreDataManager: .init())
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(animated: Bool) {
        presentSportRecordingsList(animated: animated)
    }
    
    func presentSportRecordingsList(animated: Bool = true) {
        let viewModel = SportRecordingsListViewModel(
            sportRecordingsProvider: factory.makeSportRecordingsProvider(),
            sportRecordingsUpdater: factory.makeSportRecordingsUpdater()
        )
        viewModel.delegate = self
        let vc = UIHostingController(rootView: SportRecordingsListView(viewModel: viewModel))
        
        navigationController.pushViewController(vc, animated: animated)
    }
    
    func presentSportRecordingAddRecording(animated: Bool = true) {
        let viewModel = SportRecordingAddRecordingViewModel(sportRecordingUpdater: factory.makeSportRecordingsUpdater())
        viewModel.delegate = self
        let vc = UIHostingController(rootView: SportRecordingsAddRecordingView(viewModel: viewModel))
        
        navigationController.present(vc, animated: animated)
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default))
    }
}

extension SportRecordingsOverviewCoordinator: SportRecordingAddRecordingViewModelDelegate {
    
    func didFinishUploading(success: Bool) {
        navigationController.topViewController?.dismiss(animated: true)
        
        if !success {
            presentAlert(title: "Upload failed", message: "something went wrong try again later")
        }
    }
    
    func didCancel() {
        navigationController.topViewController?.dismiss(animated: true)
    }
}

extension SportRecordingsOverviewCoordinator: SportRecordingsListViewModelDelegate {
    
    func didTapAddActivity() {
        presentSportRecordingAddRecording()
    }
}
