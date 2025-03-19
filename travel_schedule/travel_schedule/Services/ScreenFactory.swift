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
        case .selectCityView:
            SelectCityView()
        case .selectStationView:
            SelectStationView()
        case .carriersListView:
            CarriersListView()
        case .filterView:
            FilterView()
        case .carrierCardView:
            CarrierCardView()
        case .userAreementView:
            UserAreementView()
        case .networkErrorView:
            ErrorScreenView(error: .internetConnectError)
        case .serverErrorView:
            ErrorScreenView(error: .serverError)
        case .storiesView:
            StoriesListView()
        case let .showStory(story):
            StoryDetailView(story: story)
        }
    }
}
