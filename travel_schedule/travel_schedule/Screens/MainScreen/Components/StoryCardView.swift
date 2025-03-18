//
//  StoryCardView.swift
//  Navigation SwiftUI
//
//  Created by Maksim Zakharov on 16.02.2025.
//

import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct StoryCardView: View {
    let story: StoryModel
    let isActive: Bool
    private let storySize = CGSize(width: 92, height: 140)
    private let cornerRadius: CGFloat = 16
    
    var body: some View {
        ZStack(alignment: .bottom) {
            storyImage()
            storyTitle()
        }
        .frame(width: storySize.width, height: storySize.height)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .opacity(isActive ? 1.0 : 0.5)
        .animation(.easeInOut(duration: 0.4), value: isActive)
    }
    
    private func storyImage() -> some View {
        story.image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: storySize.width, height: storySize.height)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        isActive ?
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ) : LinearGradient(
                            colors: [.clear, .clear],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 4
                    )
                    .animation(.easeInOut(duration: 0.4), value: isActive)
            )
    }
    
    private func storyTitle() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(story.description)
                .font(.system(size: 12))
                .foregroundColor(.white)
                .lineLimit(3)
                .padding(.horizontal, 8)
                .padding(.bottom, 12)
        }
        .background(
            LinearGradient(
                colors: [.clear, .black.opacity(0.6)],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}


#Preview {
    StoryCardView(story: StoryModel.story1, isActive: true)
}
