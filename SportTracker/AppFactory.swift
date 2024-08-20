import UIKit

final class AppFactory {
    
    let coreDataManager: CoreDataManager = .init()
    
    func makeSportRecordingsOverviewFactory() -> SportRecordingsOverviewFactory {
        return SportRecordingsOverviewFactory(coreDataManager: coreDataManager)
    }
}
