//
//  IslandExperimentAttributes.swift
//  bannerexperiments
//
//  Created by Vidy Thatte on 5/26/26.
//

import ActivityKit
import Foundation

struct IslandExperimentAttributes: ActivityAttributes {
    struct ContentState: Codable, Hashable {
        var title: String
        var subtitle: String
        var progress: Double
        var symbolName: String
        var tintName: String
    }

    var experimentName: String
}
