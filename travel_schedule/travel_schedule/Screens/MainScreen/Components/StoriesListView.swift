//
//  ScrollView.swift
//  Navigation SwiftUI
//
//  Created by Maksim Zakharov on 16.02.2025.
//

import SwiftUI

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

struct StoriesListView: View {
    // MARK: - States
    @ObservedObject private var router: Router
    @ObservedObject private var viewModel: StoryViewModel
    
    // MARK: - init
    init() {
        guard let r = DIContainer.shared.resolve(Router.self), let vm = DIContainer.shared.resolve(StoryViewModel.self) else {
            fatalError("Dependencies not registered")
        }
        self.viewModel = vm
        self.router = r
    }
    
    // Размеры для адаптации
    private let storySize = CGSize(
        width: 92,
        height: 140
    )
    private let cornerRadius: CGFloat = 16
    
    var body: some View {
        VStack(
            alignment: .leading
        ) {
            ScrollView(
                .horizontal,
                showsIndicators: false
            ) {
                HStack(
                    spacing: 12
                ) {
                    ForEach(
                        Array(viewModel.stories.enumerated()),
                        id: \.element.id
                    ) { index, story in
                        storyButton(
                            story: story,
                            index: index
                        )
                    }
                }
                .padding(
                    .horizontal,
                    16
                )
                .padding(
                    .vertical,
                    24
                )
            }
        }
    }
    
    private func storyButton(
        story: StoryModel,
        index: Int
    ) -> some View {
        Button(
            action: {
                handleStoryTap(
                    story: story,
                    index: index
                )
            }) {
                StoryCardView(
                    story: story
                )
            }
            .buttonStyle(
                ScaleButtonStyle()
            )
    }
    
    private func handleStoryTap(
        story: StoryModel,
        index: Int
    ) {
        viewModel.setStory(at: index)
        

        router.push(.showStory(story: story))
    }
}

#Preview {
    let coordinator = AppCoordinator.shared
    coordinator
        .setupDependencies()
    
    return StoriesListView()
}
