//
//  StoryDetailView.swift
//  Navigation SwiftUI
//
//  Created by Maksim Zakharov on 16.02.2025.
//

import SwiftUI
import Combine

struct StoryDetailView: View {
    @ObservedObject private var router: Router
    @ObservedObject private var viewModel: StoryViewModel
    
    init(story: StoryModel) {
        guard let r = DIContainer.shared.resolve(Router.self),
              let vm = DIContainer.shared.resolve(StoryViewModel.self) else {
            fatalError("Dependencies not registered")
        }
        self.viewModel = vm
        self.router = r
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoryView(story: viewModel.currentStory)
                .transition(.move(edge: .leading))
            
            ProgressBar(
                numberOfSections: viewModel.stories.count,
                progress: viewModel.progress
            )
            .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
            
            HStack(spacing: 0) {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture(perform: handlePrevious)
                    .frame(width: UIScreen.main.bounds.width * 0.3)
                
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture(perform: viewModel.restartTimer)
                
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture(perform: handleNext)
                    .frame(width: UIScreen.main.bounds.width * 0.3)
            }
            
            CloseButton(action: close)
                .padding(.top, 57)
                .padding(.trailing, 12)
                .zIndex(1)
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 20)
                .onEnded(handleDrag)
        )
        .onAppear(perform: viewModel.startTimer)
        .onDisappear(perform: viewModel.stopTimer)
        .navigationBarHidden(true)
    }
    
    private func handleDrag(_ value: DragGesture.Value) {
        let threshold: CGFloat = 50
        if value.translation.width > threshold {
            handlePrevious()
        } else if value.translation.width < -threshold {
            handleNext()
        }
    }
    
    private func handlePrevious() {
        viewModel.previousStory()
        viewModel.restartTimer()
    }
    
    private func handleNext() {
        viewModel.nextStory()
        viewModel.restartTimer()
    }
    
    private func close() {
        viewModel.stopTimer()
        router.pop()
    }
}

#Preview {
    StoryDetailView(story: .story1)
}
