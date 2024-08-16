import Combine

class SportRecordingsOverviewViewModel: ObservableObject {
    enum State {
        case loading
        case loaded(recordings: [SportRecording])
        case error // TODO: add loading error
    }
    
    @Published private(set) var state: State = .loading
    
    private let sportRecordingsProvider: SportRecordingsProviding
    
    init(sportRecordingsProvider: SportRecordingsProviding) {
        self.sportRecordingsProvider = sportRecordingsProvider
    }
    
    func onAppear() {
        loadData()
    }
    
    func refresh() {
        loadData()
    }
    
    private func loadData() {
        Task { @MainActor in setState(.loading) }

        Task { [weak self] in
            guard let self else { return }
            
            do {
                let data = try await self.sportRecordingsProvider.getAllRecordings()
                
                await setState(.loaded(recordings: data))
                
            } catch {
                await setState(.error)
            }
        }
    }
     
    @MainActor func setState(_ newState: State) {
        self.state = newState
    }
}

