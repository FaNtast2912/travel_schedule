//
//  StoryView.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 18.03.2025.
//

import SwiftUI

struct StoryView: View {
    let story: StoryModel

    var body: some View {
        story.image
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
            .overlay(
                VStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 10) {
                        Text(story.title)
                            .font(.bold34)
                            .foregroundColor(.white)
                        Text(story.description)
                            .font(.regular20)
                            .lineLimit(3)
                            .foregroundColor(.white)
                    }
                    .padding(.init(top: 0, leading: 16, bottom: 40, trailing: 16))
                }
            )

    }
}

#Preview {
    StoryView(story: .story1)
}
