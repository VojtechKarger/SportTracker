
final class MockSportRecordingUpdater: SportRecordingUpdating {
    
    func upload(recording: SportRecording) throws {}
    
    func delete(_ recording: SportRecording) {}
}

extension SportRecordingUpdating where Self == MockSportRecordingUpdater {
    
    static var mock: Self {
        MockSportRecordingUpdater()
    }
}
