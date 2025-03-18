//
//  StoryDetailView.swift
//  Navigation SwiftUI
//
//  Created by Maksim Zakharov on 16.02.2025.
//

import SwiftUI
import Combine

struct StoryDetailView: View {
    // MARK: - States
    @ObservedObject private var router: Router
    @ObservedObject private var viewModel: StoryViewModel
    
    private let story: StoryModel
    
    // MARK: - init
    init(story: StoryModel) {
        guard let r = DIContainer.shared.resolve(Router.self), let vm = DIContainer.shared.resolve(StoryViewModel.self) else {
            fatalError("Dependencies not registered")
        }
        self.story = story
        self.viewModel = vm
        self.router = r
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {

            StoryView(story: viewModel.currentStory)
            

            ProgressBar(
                numberOfSections: viewModel.stories.count,
                progress: viewModel.progress
            )
            .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
                
            // Области для навигации по историям
            HStack(spacing: 0) {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.previousStory()
                        viewModel.restartTimer()
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.3)
                
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.restartTimer()
                    }
                
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.nextStory()
                        viewModel.restartTimer()
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.3)
            }
            
            CloseButton(action: {
                viewModel.stopTimer()
                router.pop()
            })
            .padding(.top, 57)
            .padding(.trailing, 12)
            .zIndex(1)
        }
        .onAppear {
            viewModel.startTimer()
        }
        .onDisappear {
            viewModel.stopTimer()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    StoryDetailView(story: .story16)
}
