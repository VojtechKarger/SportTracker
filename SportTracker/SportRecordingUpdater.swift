import FirebaseFirestore

final class SportRecordingUpdater: SportRecordingUpdating {
    
    let coreDataManager: CoreDataManager

    let db = Firestore.firestore()
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    func upload(recording: SportRecording) throws {
        if recording.isRemote {
            var copy = recording
            let document = db.collection("sportRecords").document()
            copy.id = document.documentID
            
            try document.setData(from: copy)
        } else {
            let newRecording: CDSportRecording = coreDataManager.newObject()
            newRecording.initialize(from: recording)
            coreDataManager.save()
        }
        
    }
    
    func delete(_ recording: SportRecording) {
        if recording.isRemote {
            db.collection("sportRecords").document(recording.id).delete()
        } else {
            coreDataManager.delete(type: CDSportRecording.self, where: { item in
                return item.recordingID == recording.id
            })
        }
    }
}
