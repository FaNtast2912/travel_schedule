//
//  StoryViewModel.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 18.03.2025.
//
import SwiftUI
import Combine

final class StoryViewModel: ObservableObject {
    
    // MARK: - Private Properties
    private var cancellables = Set<AnyCancellable>()
    private let secondsPerStory: TimeInterval = 5
    private let timerTickInterval: TimeInterval = 0.1
    private var progressPerTick: CGFloat {
        return 1.0 / (CGFloat(stories.count) * CGFloat(secondsPerStory) / CGFloat(timerTickInterval))
    }
    
    // MARK: - Public Properties
    let stories: [StoryModel] = StoryModel.stories
    var currentStory: StoryModel {
        stories[currentIndex]
    }
    
    @Published var viewedStoryIds = Set<UUID>()
    @Published var currentIndex: Int = 0 {
        didSet { updateViewedStories() }
    }
    @Published var progress: CGFloat = 0

    
    // MARK: - Public Methods
    func startTimer() {
        stopTimer()
        
        Timer.publish(every: timerTickInterval, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.timerTick()
            }
            .store(in: &cancellables)
    }
    
    func setStory(at index: Int) {
        guard index >= 0 && index < stories.count else { return }
        currentIndex = index
        
        progress = CGFloat(index) / CGFloat(stories.count)
    }
    
    func nextStory() {
        if currentIndex < stories.count - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
        updateProgress()
    }
    
    func previousStory() {
        if currentIndex > 0 {
            currentIndex -= 1
        } else {
            currentIndex = stories.count - 1
        }
        updateProgress()
    }
    

    
    func restartTimer() {
        stopTimer()
        startTimer()
    }
    
    func stopTimer() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
    
    private func updateProgress() {
        withAnimation(.linear(duration: 0.3)) {
            progress = CGFloat(currentIndex) / CGFloat(stories.count)
        }
    }
    
    // MARK: - Private Methods
    private func timerTick() {
        let newProgress = progress + progressPerTick
        
        let newIndex = Int(newProgress * CGFloat(stories.count))
        
        if newIndex >= stories.count {
            progress = 0
            currentIndex = 0
            restartTimer()
            return
        }
        
        if newIndex > currentIndex {
            currentIndex = newIndex
        }

        withAnimation(.linear(duration: timerTickInterval)) {
            progress = newProgress
        }
    }
    
    private func updateViewedStories() {
        viewedStoryIds.insert(stories[currentIndex].id)
    }
}

