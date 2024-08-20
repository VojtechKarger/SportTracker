import Combine
import Foundation

typealias SportType = SportRecording.SportType

protocol SportRecordingAddRecordingViewModelDelegate: AnyObject {
    func didFinishUploading(success: Bool)
    func didCancel()
}

final class SportRecordingAddRecordingViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var duration: Double = 1.0
    @Published var sportType: SportType = .cycling
    @Published var isRemote: Bool = false
    
    let sportRecordingUpdater: SportRecordingUpdating
    
    weak var delegate: SportRecordingAddRecordingViewModelDelegate?
    
    init(sportRecordingUpdater: SportRecordingUpdating) {
        self.sportRecordingUpdater = sportRecordingUpdater
    }
    
    func tapSave() {
        let recording = SportRecording(
            id: UUID().uuidString,
            isRemote: isRemote,
            timestamp: Date(),
            duration: duration,
            sportType: sportType,
            name: name
        )
        
        do {
            try sportRecordingUpdater.upload(recording: recording)
            delegate?.didFinishUploading(success: true)
        } catch {
            delegate?.didFinishUploading(success: false)
        }
    }
    
    func tapCancel() {
        delegate?.didCancel()
    }
}
