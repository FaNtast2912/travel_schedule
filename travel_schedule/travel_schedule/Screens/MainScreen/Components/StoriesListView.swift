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
    @ObservedObject private var viewModel: StoryViewModel
    @State private var visibleIndices: Set<Int> = [0, 1]
    
    // MARK: - init
    init() {
        guard let r = DIContainer.shared.resolve(Router.self), let vm = DIContainer.shared.resolve(StoryViewModel.self) else {
            fatalError("Dependencies not registered")
        }
        self.viewModel = vm
        self.router = r
    }
    
    // Размеры для адаптации
    private let storySize = CGSize(width: 92, height: 140)
    private let spacing: CGFloat = 12
    
    var body: some View {
        GeometryReader { outerGeometry in
            VStack(alignment: .leading) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: spacing) {
                        ForEach(Array(viewModel.stories.enumerated()), id: \.element.id) { index, story in
                            storyButton(
                                story: story,
                                index: index,
                                isActive: visibleIndices.contains(index),
                                outerWidth: outerGeometry.size.width
                            )
                            .id(index)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 24)
                }
                .coordinateSpace(name: "scrollSpace")
            }
        }
        .frame(height: 188)
    }
    
    private func storyButton(
        story: StoryModel,
        index: Int,
        isActive: Bool,
        outerWidth: CGFloat
    ) -> some View {
        Button(action: {
            handleStoryTap(story: story, index: index)
        }) {
            StoryCardView(story: story, isActive: isActive)
                .animation(.easeInOut(duration: 0.3), value: isActive)
        }
        .buttonStyle(ScaleButtonStyle())
        .background(
            GeometryReader { geo in
                Color.clear
                    .onAppear {
                        if index <= 1 {
                            visibleIndices.insert(index)
                        }
                    }
                    .onChange(of: geo.frame(in: .named("scrollSpace")).minX) { newX in
                        updateVisibleIndices(for: index, minX: newX, outerWidth: outerWidth)
                    }
            }
        )
    }
    
    private func updateVisibleIndices(for index: Int, minX: CGFloat, outerWidth: CGFloat) {
        let screenLeftEdge: CGFloat = 16
        let screenRightEdge = outerWidth - 16
        let halfWidth = storySize.width / 2
        
        let leftEdge = minX
        let rightEdge = minX + storySize.width
        
        let isFullyVisible = (leftEdge + halfWidth >= screenLeftEdge) && (rightEdge - halfWidth <= screenRightEdge)
        let isPartiallyVisible = (leftEdge < screenLeftEdge + halfWidth && rightEdge > screenLeftEdge + halfWidth) ||
        (leftEdge < screenRightEdge - halfWidth && rightEdge > screenRightEdge - halfWidth)
        
        DispatchQueue.main.async {
            if isFullyVisible || isPartiallyVisible {
                visibleIndices.insert(index)
            } else {
                visibleIndices.remove(index)
            }
            
            if visibleIndices.count > 2 {
                let sortedIndices = visibleIndices.sorted()
                visibleIndices = Set(sortedIndices.prefix(2))
            }
        }
    }
    
    private func handleStoryTap(story: StoryModel, index: Int) {
        viewModel.setStory(at: index)
        router.push(.showStory(story: story))
    }
}

#Preview {
    let coordinator = AppCoordinator.shared
    coordinator.setupDependencies()
    return StoriesListView()
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
