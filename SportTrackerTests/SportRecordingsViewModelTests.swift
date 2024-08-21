import XCTest
import Combine
@testable import SportTracker

final class SportRecordingsViewModelTests: XCTestCase {

    private var cancellables: Set<AnyCancellable> = []
    
    func test_whenViewModelIsLoadedDataAreFetchedCorrectly() throws {
        
        let vm = SportRecordingsListViewModel(sportRecordingsProvider: .mockData, sportRecordingsUpdater: .mock)
        
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
    
    func test_whenViewModelIsLoadedDataExpectingError() throws {
        
        let vm = SportRecordingsListViewModel(sportRecordingsProvider: .error, sportRecordingsUpdater: .mock)
        
        let except = expectation(description: "updated data")
        vm.onAppear()
        vm.$state.sink { state in
            if case .error = state {
                XCTAssert(true)
            }
        }
        .store(in: &cancellables)
        wait(for: [except], timeout: 1)
    }
}
