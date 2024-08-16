import Foundation

protocol SportRecordingsProviding {
    
    func getAllRecordings() async throws -> [SportRecording]
    
}
