//
//  StoryModel.swift
//  Navigation SwiftUI
//
//  Created by Maksim Zakharov on 16.02.2025.
//
import Foundation

struct StoryModel: Identifiable, Hashable {
    let id = UUID()
    let imageName: String
    let title: String
}
