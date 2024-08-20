
final class SportRecordingsOverviewFactory {
    
    let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    func makeSportRecordingsProvider() -> SportRecordingsProviding {
        return SportRecordingsProvider(coreDataManager: coreDataManager)
    }
    
    func makeSportRecordingsUpdater() -> SportRecordingUpdating {
        return SportRecordingUpdater(coreDataManager: coreDataManager)
    }
}
