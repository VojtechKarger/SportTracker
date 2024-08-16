
final class MockSportRecordingsProvider: SportRecordingsProviding {
    enum MockState {
        case loading
        case loaded(data: [SportRecording])
        case error(err: NetworkError)
    }
    
    let mockState: MockState
    
    fileprivate init(_ mockState: MockState) {
        self.mockState = mockState
    }
    
    func getAllRecordings() async throws -> [SportRecording] {
        switch (mockState) {
            case .loading: try await Task.sleep(nanoseconds: 1_000_000_000_000)
            case .loaded(let data): return data
            case .error(let error): throw error
        }
        
        return []
    }

}

extension SportRecordingsProviding where Self == MockSportRecordingsProvider {
    
    static var loading: Self {
        MockSportRecordingsProvider(.loading)
    }
    
    static var mockData: Self {
        MockSportRecordingsProvider(.loaded(data: .mockData))
    }
   
    static var error: Self {
        MockSportRecordingsProvider(.error(err: .unknown))
    }
}
