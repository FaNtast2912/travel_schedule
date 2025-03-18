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
    
    static let stories: [StoryModel] = [story1, story2, story3, story4, story5, story6, story7, story8/*, story9, story10, story11, story12, story13, story14, story15, story16, story17, story18*/]

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

//    static let story9 = StoryModel(
//        image: Image("9"),
//        title: "🌍 🌙 🌞",
//        description: "Text9 Text9 Text9 Text9 Text9 Text9 Text9 Text9 Text9 Text9 Text9 Text9 Text9 Text9 Text9 Text9 Text9 Text9 Text9 Text9 Text9 Text9 Text9 Text9 Text9 Text9 Text9 Text9 "
//    )
//
//    static let story10 = StoryModel(
//        image: Image("10"),
//        title: "🎮 🎮 🎮",
//        description: "Text10 Text10 Text10 Text10 Text10 Text10 Text10 Text10 Text10 Text10 Text10 Text10 Text10 Text10 Text10 Text10 Text10 Text10 Text10 Text10 Text10 Text10 Text10 Text10 "
//    )
//
//    static let story11 = StoryModel(
//        image: Image("11"),
//        title: "🐶 🐱 🐰",
//        description: "Text11 Text11 Text11 Text11 Text11 Text11 Text11 Text11 Text11 Text11 Text11 Text11 Text11 Text11 Text11 Text11 Text11 Text11 Text11 Text11 Text11 Text11 Text11 Text11 "
//    )
//
//    static let story12 = StoryModel(
//        image: Image("12"),
//        title: "☕️ 🍰 🍦",
//        description: "Text12 Text12 Text12 Text12 Text12 Text12 Text12 Text12 Text12 Text12 Text12 Text12 Text12 Text12 Text12 Text12 Text12 Text12 Text12 Text12 Text12 Text12 Text12 Text12 "
//    )
//
//    static let story13 = StoryModel(
//        image: Image("13"),
//        title: "🚗 🚁 ✈️",
//        description: "Text13 Text13 Text13 Text13 Text13 Text13 Text13 Text13 Text13 Text13 Text13 Text13 Text13 Text13 Text13 Text13 Text13 Text13 Text13 Text13 Text13 Text13 Text13 Text13 "
//    )
//
//    static let story14 = StoryModel(
//        image: Image("14"),
//        title: "🏰 🏔️ 🏜️",
//        description: "Text14 Text14 Text14 Text14 Text14 Text14 Text14 Text14 Text14 Text14 Text14 Text14 Text14 Text14 Text14 Text14 Text14 Text14 Text14 Text14 Text14 Text14 Text14 Text14 "
//    )
//
//    static let story15 = StoryModel(
//        image: Image("15"),
//        title: "🎸 🎤 🎹",
//        description: "Text15 Text15 Text15 Text15 Text15 Text15 Text15 Text15 Text15 Text15 Text15 Text15 Text15 Text15 Text15 Text15 Text15 Text15 Text15 Text15 Text15 Text15 Text15 Text15 "
//    )
//
//    static let story16 = StoryModel(
//        image: Image("16"),
//        title: "⚽️ 🏀 🏈",
//        description: "Text16 Text16 Text16 Text16 Text16 Text16 Text16 Text16 Text16 Text16 Text16 Text16 Text16 Text16 Text16 Text16 Text16 Text16 Text16 Text16 Text16 Text16 Text16 Text16 "
//    )
//
//    static let story17 = StoryModel(
//        image: Image("17"),
//        title: "🎨 📸 🎞️",
//        description: "Text17 Text17 Text17 Text17 Text17 Text17 Text17 Text17 Text17 Text17 Text17 Text17 Text17 Text17 Text17 Text17 Text17 Text17 Text17 Text17 Text17 Text17 Text17 Text17 "
//    )
//
//    static let story18 = StoryModel(
//        image: Image("18"),
//        title: "🎭 🎪 🎡",
//        description: "Text18 Text18 Text18 Text18 Text18 Text18 Text18 Text18 Text18 Text18 Text18 Text18 Text18 Text18 Text18 Text18 Text18 Text18 Text18 Text18 Text18 Text18 Text18 Text18 "
//    )
}
