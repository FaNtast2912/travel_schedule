//
//  ScrollView.swift
//  Navigation SwiftUI
//
//  Created by Maksim Zakharov on 16.02.2025.
//

import SwiftUI

struct StoriesListView: View {
    @EnvironmentObject private var router: Router
    
    let stories: [StoryModel] = [
        StoryModel(imageName: "1", title: "Машинист и его машина едут в саратов"),
        StoryModel(imageName: "2", title: "Инженер"),
        StoryModel(imageName: "3", title: "Проводница"),
        StoryModel(imageName: "4", title: "Еще проводница"),
        StoryModel(imageName: "5", title: "Электричка")
    ]
    
    // Размеры для адаптации
    private let storySize = CGSize(width: 92, height: 140)
    private let cornerRadius: CGFloat = 16
    
    
    var body: some View {
        
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(stories) { story in
                        storyButton(story: story)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 24)
            }
        }
    }
    
    private func storyButton(story: StoryModel) -> some View {
        Button(action: {
            handleStoryTap(story: story)
        }) {
            StoryCardView(story: story)
        }
        .buttonStyle(ScaleButtonStyle())
    }
    
    private func handleStoryTap(story: StoryModel) {
        router.push(.showStory(story: story))
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

#Preview {
    StoriesListView()
}
