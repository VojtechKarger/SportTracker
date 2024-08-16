import SwiftUI

struct SportRecordingsOverviewView: View {
    @ObservedObject var viewModel: SportRecordingsOverviewViewModel
    
    var body: some View {
        NavigationView {
            content
                .onAppear(perform: viewModel.onAppear)
                .navigationTitle("Overview")
        }
    }
    
    @ViewBuilder var content: some View {
        switch (viewModel.state) {
            case .loading: loading
            case .loaded(let recordings): loaded(recordings: recordings)
            case .error: error
        }
    }
    
    @ViewBuilder var loading: some View {
        ProgressView()
    }
    
    @ViewBuilder func loaded(recordings: [SportRecording]) -> some View {
        List {
            ForEach(recordings) { recording in
                SportRecordingsOverviewListCell(recording: recording)
            }
        }
        .listStyle(.plain)
    }
    
    @ViewBuilder var error: some View {
        Text("Todo error screen")
    }
}

#Preview {
    SportRecordingsOverviewView(viewModel: .init(sportRecordingsProvider: .mockData))
}

#Preview {
    SportRecordingsOverviewView(viewModel: .init(sportRecordingsProvider: .loading))
}

#Preview {
    SportRecordingsOverviewView(viewModel: .init(sportRecordingsProvider: .error))
}
