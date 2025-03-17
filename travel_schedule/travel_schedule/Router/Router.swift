//
//  Router.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 16.02.2025.
//

import Combine
import SwiftUI

@MainActor
final class Router: ObservableObject {
    // MARK: - Public Properties
    static let shared = Router()
    @Published var path = NavigationPath()
    
    
    // MARK: - init
    private init() { }
    
    // MARK: - Nested Types
    enum Route: Hashable {
        case selectCityView
        case selectStationView
        case carriersListView
        case filterView
        case carrierCardView
        case userAreementView
        case networkErrorView
        case serverErrorView
        case storiesView
        case showStory(story: StoryModel)
    }
    
    // MARK: - Public Methods
    @inlinable
    @inline(__always)
    func push(_ appRoute: Route) {
        path.append(appRoute)
    }
    
    @inlinable
    @inline(__always)
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    @inlinable
    @inline(__always)
    func backToRoot() {
        path.removeLast(path.count)
    }
}
