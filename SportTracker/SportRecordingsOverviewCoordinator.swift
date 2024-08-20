import SwiftUI

class SportRecordingsOverviewCoordinator: Coordinator {
   
    let factory: SportRecordingsOverviewFactory
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, factory: SportRecordingsOverviewFactory) {
        self.navigationController = navigationController
        self.factory = factory
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
        
        navigationController.presentedViewController?.present(alert, animated: true)
    }
    
    func presentFilterAlert(completion: @escaping(Filter) -> Void) {
        let alert = UIAlertController(title: "Filter", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "All", style: .default, handler: { _ in completion(.all) } ))
        alert.addAction(UIAlertAction(title: "Remote", style: .default, handler: { _ in completion(.remote) } ))
        alert.addAction(UIAlertAction(title: "Local", style: .default, handler: { _ in completion(.local) } ))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        navigationController.present(alert, animated: true)
    }
}

extension SportRecordingsOverviewCoordinator: SportRecordingAddRecordingViewModelDelegate {
    
    func sportRecordingAddRecordingViewModelDidFinishUploading(
        _ viewModel: SportRecordingAddRecordingViewModel,
        success: Bool
    ) {
        if success {
            navigationController.topViewController?.dismiss(animated: true)
        } else {
            presentAlert(
                title: "Something went wrong",
                message: "Please check your internet connection and that all the fields are filled."
            )
        }
    }
    
    func sportRecordingAddRecordingViewModelDidCancel(_ viewModel: SportRecordingAddRecordingViewModel) {
        navigationController.topViewController?.dismiss(animated: true)
    }
}

extension SportRecordingsOverviewCoordinator: SportRecordingsListViewModelDelegate {
    
    func sportRecordingsViewModelDidTapAddActivity(_ viewModel: SportRecordingsListViewModel) {
        presentSportRecordingAddRecording()
    }
    
    func sportRecordingsViewModelDidTapFilter(_ viewModel: SportRecordingsListViewModel) {
        presentFilterAlert { filter in
            viewModel.filterRecordings(using: filter)
        }
    }
}
