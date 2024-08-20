import Combine
import Foundation

typealias SportType = SportRecording.SportType

protocol SportRecordingAddRecordingViewModelDelegate: AnyObject {
    func sportRecordingAddRecordingViewModelDidFinishUploading(
        _ viewModel: SportRecordingAddRecordingViewModel,
        success: Bool
    )
    func sportRecordingAddRecordingViewModelDidCancel(_ viewModel: SportRecordingAddRecordingViewModel)
}

final class SportRecordingAddRecordingViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var place: String = ""
    @Published var duration: Double = 1.0
    @Published var sportType: SportType = .cycling
    @Published var isRemote: Bool = false
    
    let sportRecordingUpdater: SportRecordingUpdating
    
    weak var delegate: SportRecordingAddRecordingViewModelDelegate?
    
    init(sportRecordingUpdater: SportRecordingUpdating) {
        self.sportRecordingUpdater = sportRecordingUpdater
    }
    
    func tapSave() {
        guard validateInput() else {
            delegate?.sportRecordingAddRecordingViewModelDidFinishUploading(self, success: false)
            return
        }
        
        let recording = SportRecording(
            id: UUID().uuidString,
            isRemote: isRemote,
            timestamp: Date(),
            duration: duration,
            sportType: sportType,
            name: name,
            place: place
        )
        
        do {
            try sportRecordingUpdater.upload(recording: recording)
            delegate?.sportRecordingAddRecordingViewModelDidFinishUploading(self, success: true)
        } catch {
            delegate?.sportRecordingAddRecordingViewModelDidFinishUploading(self, success: false)
        }
    }
    
    private func validateInput() -> Bool {
        guard name != "" else { return false }
        guard place != "" else { return false }
        guard duration != 0.0 else { return false }
        
        return true
    }
    
    func tapCancel() {
        delegate?.sportRecordingAddRecordingViewModelDidCancel(self)
    }
}
