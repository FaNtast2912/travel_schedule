//
//  StoryDetailView.swift
//  Navigation SwiftUI
//
//  Created by Maksim Zakharov on 16.02.2025.
//

import SwiftUI

struct StoryDetailView: View {
    
    var story: StoryModel
    
    var body: some View {
        Text("картинка номер \(story.imageName)")
    }
}

#Preview {
    StoryDetailView(story: StoryModel(imageName: "1", title: "Машинист"))
}
