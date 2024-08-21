import SwiftUI

struct SportRecordingsListCell: View {
    let name: String
    let place: String
    let duration: String
    let sportType: SportType
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: sportType.imageName)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading) {
                Text("\(name) in \(place)")
                Text(duration)
            }
        }
    }
}

#Preview {
    SportRecordingsListCell(name: "evening ride", place: "Praha", duration: "1.5h", sportType: .walking)
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
