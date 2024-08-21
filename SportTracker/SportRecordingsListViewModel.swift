import Combine
import Foundation
import SwiftUI

protocol SportRecordingsListViewModelDelegate: AnyObject {
    func sportRecordingsViewModelDidTapAddActivity(_ viewModel: SportRecordingsListViewModel)
    func sportRecordingsViewModelDidTapFilter(_ viewModel: SportRecordingsListViewModel)
}

class SportRecordingsListViewModel: ObservableObject {
    enum State {
        case loading
        case loaded(recordings: [SportRecording])
        case error
    }
    
    @Published private(set) var state: State = .loading
    
    private var recordings: [SportRecording] = []
    private var filter: Filter = .all
    
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
   
    func tapFilter() {
        delegate?.sportRecordingsViewModelDidTapFilter(self)
    }
    
    func tapAddRecording() {
        delegate?.sportRecordingsViewModelDidTapAddActivity(self)
    }
    
    func onDelete(indexSet: IndexSet) {
        guard case .loaded(let recordings) = state else { return }

        for index in indexSet {
            sportRecordingsUpdater.delete(recordings[index])
        }
    }
    
    func filterRecordings(using filter: Filter) {
        self.filter = filter
        applyFilter()
    }
    
    private func applyFilter() {
        let filteredRecordings = recordings.filter { recording in
            switch filter {
                case .all:      return true
                case .remote:   return recording.isRemote
                case .local:    return recording.isRemote == false
            }
        }.sorted { r1, r2 in r1.timestamp < r2.timestamp }
        
        Task { @MainActor in setState(.loaded(recordings: filteredRecordings)) }
    }
    
    private func loadData() async {
        do {
            let data = try await self.sportRecordingsProvider.getAllRecordings()
            
            recordings = data
            applyFilter()
        } catch(let error) {
            await setState(.error)
        }
    }
    
    @MainActor func setState(_ newState: State) {
        self.state = newState
    }
}
