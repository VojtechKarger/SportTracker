import SwiftUI

struct SportRecordingsAddRecordingView: View {
    @ObservedObject var viewModel: SportRecordingAddRecordingViewModel
    
    var body: some View {
        NavigationView {
            Form {
                nameField
                placeField
                durationField
                sportTypeField
                isRemoteField
            }
            .navigationTitle("Add activity")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("save", action: viewModel.tapSave)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("cancel", action: viewModel.tapCancel)
                }
            }
        }
    }
    
    @ViewBuilder var nameField: some View {
        VStack(alignment: .leading) {
            Text("Activity name:")
            TextField("type activity name...", text: $viewModel.name)
        }
    }
    
    @ViewBuilder var placeField: some View {
        VStack(alignment: .leading) {
            Text("Where did it happend?")
            TextField("type place name...", text: $viewModel.place)
        }
    }
    
    @ViewBuilder var durationField: some View {
        VStack(alignment: .leading) {
            Text("Duration: \(String(format: "%.1f", viewModel.duration))h")
            Slider(value: $viewModel.duration, in: 0...5)
        }
    }
    
    @ViewBuilder var sportTypeField: some View {
        Picker("Sport type", selection: $viewModel.sportType) {
            Text("Cycling").tag(SportType.cycling)
            Text("Running").tag(SportType.running)
            Text("Walking").tag(SportType.walking)
        }
    }
    
    @ViewBuilder var isRemoteField: some View {
        Picker("Save to", selection: $viewModel.isRemote) {
            Text("device").tag(false)
            Text("server").tag(true)
        }
    }
}

#Preview {
    SportRecordingsAddRecordingView(viewModel: .init(sportRecordingUpdater: .mock))
}
