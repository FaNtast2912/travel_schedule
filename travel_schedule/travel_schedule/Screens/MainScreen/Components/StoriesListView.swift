//
//  ScrollView.swift
//  Navigation SwiftUI
//
//  Created by Maksim Zakharov on 16.02.2025.
//

import SwiftUI

struct StoriesListView: View {
    // MARK: - States
    @ObservedObject private var router: Router
    
    // MARK: - init
    init() {
        guard let r = DIContainer.shared.resolve(
            Router.self
        ) else {
            fatalError(
                "Dependencies not registered"
            )
        }
        self.router = r
    }
    
    let stories = StoryModel.stories
    
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
                        stories
                    ) { story in
                        storyButton(
                            story: story
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
        story: StoryModel
    ) -> some View {
        Button(
            action: {
                handleStoryTap(
                    story: story
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
        story: StoryModel
    ) {
        router
            .push(
                .showStory(
                    story: story
                )
            )
    }
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

#Preview {
    let coordinator = AppCoordinator.shared
    coordinator
        .setupDependencies()
    
    return StoriesListView()
}
