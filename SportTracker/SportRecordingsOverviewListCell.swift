import SwiftUI

struct SportRecordingsOverviewListCell: View {
    let recording: SportRecording
    
    var body: some View {
        Text(recording.id)
    }
}

#Preview {
    SportRecordingsOverviewListCell(recording: .init())
        .previewLayout(.sizeThatFits)
}
