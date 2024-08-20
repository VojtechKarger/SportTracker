import Foundation

struct SportRecording: Identifiable, Equatable, Codable {
    
    enum SportType: String, Codable {
        case cycling
        case running
        case walking
    }
    
    var id: String
    let isRemote: Bool
    let timestamp: Date
    let duration: Double
    let sportType: SportType
    let name: String
    let place: String
    
    init(
        id: String,
        isRemote: Bool,
        timestamp: Date,
        duration: Double,
        sportType: SportType,
        name: String,
        place: String
    ) {
        self.id = id
        self.isRemote = isRemote
        self.timestamp = timestamp
        self.duration = duration
        self.sportType = sportType
        self.name = name
        self.place = place
    }
}

extension SportRecording {
    
    init(cdSportRecording: CDSportRecording) {
        self.init(
            id: cdSportRecording.recordingID ?? UUID().uuidString,
            isRemote: false,
            timestamp: cdSportRecording.timestamp ?? Date(),
            duration: cdSportRecording.duration,
            sportType: SportType.init(rawValue: cdSportRecording.sportType ?? "") ?? .cycling,
            name: cdSportRecording.name ?? "unknown",
            place: cdSportRecording.place ?? "unknown"
        )
    }
}

extension CDSportRecording {
    func initialize(from recording: SportRecording) {
        self.recordingID = recording.id
        self.timestamp = recording.timestamp
        self.name = recording.name
        self.sportType = recording.sportType.rawValue
        self.duration = recording.duration
        self.place = recording.place
    }
}
