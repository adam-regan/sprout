//
//  RootView.swift
//  StoryPlayer
//
//  Created by Adam Regan on 13/02/2026.
//

import SwiftUI

struct RootView: View {
    @Environment(DataManager.self) private var dataManager
    @State var viewModel: RootViewModel?

    var body: some View {
        Group {
            switch dataManager.loadingState {
            case .loading, .idle, .error:
                LoadingScreen()
            case .loaded:
                if viewModel?.isLoading == true {
                    LoadingScreen()
                } else {
                    MainContentView()
                }
            }
        }
        .task {
            if viewModel == nil {
                viewModel = RootViewModel(dataManager: dataManager)
                await viewModel?.loadingSequence()
            }
        }
    }
}

#Preview {
    RootView()
        .environment(DataManager())
}
