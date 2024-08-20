import Combine
import Foundation

protocol SportRecordingsListViewModelDelegate: AnyObject {
    func didTapAddActivity()
    
}

class SportRecordingsListViewModel: ObservableObject {
    enum State {
        case loading
        case loaded(recordings: [SportRecording])
        case error // TODO: add loading error
    }
    
    @Published private(set) var state: State = .loading
    
    private let sportRecordingsProvider: SportRecordingsProviding
    private let sportRecordingsUpdater: SportRecordingUpdating
    
    weak var delegate: SportRecordingsListViewModelDelegate?
    
    init(sportRecordingsProvider: SportRecordingsProviding, sportRecordingsUpdater: SportRecordingUpdating) {
        self.sportRecordingsProvider = sportRecordingsProvider
        self.sportRecordingsUpdater = sportRecordingsUpdater
    }
    
    func onAppear() {
        Task { [weak self] in
            await self?.setState(.loading)

            await self?.loadData()
        }
    }
    
    func refresh() async {
        await loadData()
    }
    
    func tapAddRecording() {
        delegate?.didTapAddActivity()
    }
    
    func onDelete(indexSet: IndexSet) {
        guard case .loaded(let recordings) = state else { return }

        for index in indexSet {
            sportRecordingsUpdater.delete(recordings[index])
        }
//        Task {
//            await loadData()
//        }
    }
    
    private func loadData() async {
        do {
            let data = try await self.sportRecordingsProvider.getAllRecordings()
            
            await setState(.loaded(recordings: data))
            
        } catch(let error) {
            print(error.localizedDescription)
            await setState(.error)
        }
    }
    
    @MainActor func setState(_ newState: State) {
        self.state = newState
    }
}

