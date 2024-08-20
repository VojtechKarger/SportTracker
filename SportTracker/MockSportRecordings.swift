import Foundation

extension SportRecording {
    
    static var mock: Self {
        SportRecording(id: "asdfa", isRemote: false, timestamp: Date(), duration: 1, sportType: .cycling, name: "Afternoon ride", place: "Praha")
    }
}

extension [SportRecording] {
    
    static var mockData: Self {
        [
            .mock
        ]
    }
}
