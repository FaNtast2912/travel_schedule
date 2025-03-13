//
//  ScreenFactory.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 08.03.2025.
//

import SwiftUI

final class ScreenFactory: ObservableObject {
    
    @ViewBuilder
    func view(for route: Router.Route) -> some View {
        switch route {
        case .firstView:
            SelectSityView()
        case .secondView:
            SecondView()
        case .thirdView:
            ThirdView()
        case .storiesView:
            StoriesListView()
        case let .showStory(story):
            StoryDetailView(story: story)
        }
    }
}
