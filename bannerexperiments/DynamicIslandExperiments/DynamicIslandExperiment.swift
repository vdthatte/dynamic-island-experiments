//
//  DynamicIslandExperiment.swift
//  bannerexperiments
//
//  Drop this folder into another SwiftUI app to reuse the experiments.
//

import Foundation

enum DynamicIslandExperiment: Equatable, Identifiable {
    case loading
    case applyingProgress
    case errorBanner
    case successBanner

    static let selectableCases: [Self] = [
        .applyingProgress,
        .errorBanner,
        .successBanner
    ]

    var id: Self {
        self
    }

    var controlTitle: String {
        switch self {
        case .loading:
            "Loading"
        case .applyingProgress:
            "Applying Progress"
        case .errorBanner:
            "Error Banner"
        case .successBanner:
            "Success Banner"
        }
    }

    var hidesStatusBar: Bool {
        switch self {
        case .loading:
            false
        case .applyingProgress, .errorBanner, .successBanner:
            true
        }
    }
}
