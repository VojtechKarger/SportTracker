import XCTest
import Combine
@testable import SportTracker

final class SportRecordingsViewModelTests: XCTestCase {

    private var cancellables: Set<AnyCancellable> = []
    
    func test_whenViewModelIsLoadedDataAreFetchedCorrectly() throws {
        
        let vm = SportRecordingsOverviewViewModel(sportRecordingsProvider: .mockData)
        
        let except = expectation(description: "updated data")
        vm.onAppear()
        vm.$state.sink { data in
            if case .loaded(let recordings) = data {
                XCTAssert(recordings == .mockData)
                except.fulfill()
            }
        }
        .store(in: &cancellables)
        wait(for: [except], timeout: 1)
    }
}
