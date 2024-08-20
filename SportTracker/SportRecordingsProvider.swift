import FirebaseFirestore

final class SportRecordingsProvider: SportRecordingsProviding {
  
    struct Model: Codable {
        let recordings: [SportRecording]
    }
    
    let coreDataManager: CoreDataManager
    let db = Firestore.firestore()

    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    func getAllRecordings() async throws -> [SportRecording] {
        let localRecordings = try getLocalRecordings()
        let remoteRecordings = try await getRemoteRecordings()
        return localRecordings + remoteRecordings
    }
    
    private func getRemoteRecordings() async throws -> [SportRecording] {
        
        let querySnapshot = try await db.collection("sportRecords").getDocuments()

        return querySnapshot.documents.compactMap { document in
            try? document.data(as: SportRecording.self)
        }
        // return [] // data.recordings
    }
    
    private func getLocalRecordings() throws -> [SportRecording] {
        let data: [CDSportRecording] = try coreDataManager.getData()
        return data.map(SportRecording.init(cdSportRecording:))
    }
    
}
