import SwiftUI

struct SportRecordingsListCell: View {
    let name: String
    let duration: String
    let sportType: SportType
    
    var body: some View {
        HStack {
            Image(systemName: sportType.imageName)
            
            VStack {
                Text(name)
                Text(duration)
            }
        }
    }
}

#Preview {
    SportRecordingsListCell(name: "evening ride", duration: "1.5h", sportType: .cycling)
        .previewLayout(.sizeThatFits)
}

extension SportRecording.SportType {
    var imageName: String {
        switch self {
            case .cycling: return "bicycle"
            case .running: return "figure.run"
            case .walking: return "figure.walk"
        }
    }
}
