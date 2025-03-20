//
//  ScrollView.swift
//  Navigation SwiftUI
//
//  Created by Maksim Zakharov on 16.02.2025.
//

import SwiftUI

struct StoriesListView: View {
    @ObservedObject private var router: Router
    @ObservedObject private var viewModel: StoryViewModel
    
    init() {
        guard let r = DIContainer.shared.resolve(Router.self),
              let vm = DIContainer.shared.resolve(StoryViewModel.self) else {
            fatalError("Dependencies not registered")
        }
        self.viewModel = vm
        self.router = r
    }
    
    private let storySize = CGSize(width: 92, height: 140)
    private let spacing: CGFloat = 12
    
    var body: some View {
        GeometryReader { outerGeometry in
            VStack(alignment: .leading) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: spacing) {
                        ForEach(viewModel.stories) { story in
                            storyButton(story: story)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 24)
                }
            }
        }
        .frame(height: 188)
    }
    
    private func storyButton(story: StoryModel) -> some View {
        Button {
            handleStoryTap(story: story)
        } label: {
            StoryCardView(
                story: story,
                isActive: !viewModel.viewedStoryIds.contains(story.id)
            )
        }
        .buttonStyle(ScaleButtonStyle())
    }
    
    private func handleStoryTap(story: StoryModel) {
        guard let index = viewModel.stories.firstIndex(where: { $0.id == story.id }) else { return }
        viewModel.setStory(at: index)
        router.push(.showStory(story: story))
    }
}

#Preview {
    let coordinator = AppCoordinator.shared
    coordinator.setupDependencies()
    return StoriesListView()
}


struct ScaleButtonStyle: ButtonStyle {
    func makeBody(
        configuration: Configuration
    ) -> some View {
        configuration.label
            .scaleEffect(
                configuration.isPressed ? 0.95 : 1
            )
            .animation(
                .easeInOut(
                    duration: 0.2
                ),
                value: configuration.isPressed
            )
    }
}
