
protocol SportRecordingUpdating {
    
    func upload(recording: SportRecording) throws
    
    func delete(_ recording: SportRecording)
}
