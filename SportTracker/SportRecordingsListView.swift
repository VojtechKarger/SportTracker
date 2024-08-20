import SwiftUI

struct SportRecordingsListView: View {
    @ObservedObject var viewModel: SportRecordingsListViewModel
    
    var body: some View {
        NavigationView {
            content
                .onAppear(perform: viewModel.onAppear)
                .navigationTitle("Overview")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .toolbar(content: {
                    ToolbarItem(placement: .automatic) {
                        Button(action: viewModel.tapFilter) {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                        }
                    }
                })
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
                SportRecordingsListCell(
                    name: recording.name,
                    place: recording.place,
                    duration: recording.durationFormatted,
                    sportType: recording.sportType
                )
                .listRowBackground(recording.isRemote ? Color.accentColor : .accentColor.opacity(0.1))
            }
            .onDelete(perform: viewModel.onDelete(indexSet:))
        }
        .listStyle(.plain)
        .overlay(alignment: .bottomTrailing, content:  { addRecordingView })
        .refreshable {
            await viewModel.refresh()
        }
    }
    
    @ViewBuilder var addRecordingView: some View {
        Button(action: viewModel.tapAddRecording) {
            Image(systemName: "plus")
                .resizable()
                .scaledToFit()
                .tint(.white)
                .padding(.small)
                .frame(width: 50, height: 50)
                .background {
                    Circle().fill(Color.accentColor)
                }
        }
        .padding(.medium)
    }
    
    @ViewBuilder var error: some View {
        VStack(spacing: .small){
            Text("⚠︎")
                .font(.largeTitle)
            Text("Something went wrong!")
        }                
        .foregroundStyle(Color.accentColor)
    }
}

extension SportRecording {
    var durationFormatted: String {
        return "\(String(format: "%.1f", duration)) h"
    }
}

#Preview {
    SportRecordingsListView(viewModel: .init(sportRecordingsProvider: .mockData, sportRecordingsUpdater: .mock))
}

#Preview {
    SportRecordingsListView(viewModel: .init(sportRecordingsProvider: .loading, sportRecordingsUpdater: .mock))
}

#Preview {
    SportRecordingsListView(viewModel: .init(sportRecordingsProvider: .error, sportRecordingsUpdater: .mock))
}
