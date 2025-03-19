//
//  StoryModel.swift
//  Navigation SwiftUI
//
//  Created by Maksim Zakharov on 16.02.2025.
//
import Foundation
import SwiftUI

struct StoryModel: Identifiable, Hashable {
    let id = UUID()
    let image: Image
    let title: String
    let description: String
    
    static func == (lhs: StoryModel, rhs: StoryModel) -> Bool {
        return lhs.id == rhs.id &&
               lhs.title == rhs.title &&
               lhs.description == rhs.description
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(description)
    }
    
    static let stories: [StoryModel] = [story1, story2, story3, story4, story5, story6, story7, story8]

    static let story1 = StoryModel(
        image: Image("1"),
        title: "🎉 ⭐️ ❤️",
        description: "Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 "
    )

    static let story2 = StoryModel(
        image: Image("2"),
        title: "😍 🌸 🥬",
        description: "Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 "
    )

    static let story3 = StoryModel(
        image: Image("3"),
        title: "🧀 🥑 🥚",
        description: "Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 "
    )

    static let story4 = StoryModel(
        image: Image("4"),
        title: "🌈 🌟 🎈",
        description: "Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 "
    )

    static let story5 = StoryModel(
        image: Image("5"),
        title: "🌊 🐚 🏖️",
        description: "Text5 Text5 Text5 Text5 Text5 Text5 Text5 Text5 Text5 Text5 Text5 Text5 Text5 Text5 Text5 Text5 Text5 Text5 Text5 Text5 Text5 Text5 Text5 Text5 Text5 Text5 Text5 Text5 "
    )

    static let story6 = StoryModel(
        image: Image("6"),
        title: "🍔 🍕 🍔",
        description: "Text6 Text6 Text6 Text6 Text6 Text6 Text6 Text6 Text6 Text6 Text6 Text6 Text6 Text6 Text6 Text6 Text6 Text6 Text6 Text6 Text6 Text6 Text6 Text6 Text6 Text6 Text6 Text6 "
    )

    static let story7 = StoryModel(
        image: Image("7"),
        title: "📚 🎨 🎵",
        description: "Text7 Text7 Text7 Text7 Text7 Text7 Text7 Text7 Text7 Text7 Text7 Text7 Text7 Text7 Text7 Text7 Text7 Text7 Text7 Text7 Text7 Text7 Text7 Text7 Text7 Text7 Text7 Text7 "
    )

    static let story8 = StoryModel(
        image: Image("8"),
        title: "🚴‍♂️ 🏃‍♀️ 🏋️‍♀️",
        description: "Text8 Text8 Text8 Text8 Text8 Text8 Text8 Text8 Text8 Text8 Text8 Text8 Text8 Text8 Text8 Text8 Text8 Text8 Text8 Text8 Text8 Text8 Text8 Text8 Text8 Text8 Text8 Text8 "
    )
}
