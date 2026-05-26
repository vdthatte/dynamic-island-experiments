//
//  DynamicIslandExperimentSurface.swift
//  bannerexperiments
//

import SwiftUI

struct DynamicIslandExperimentSurface: View {
    let metrics: DynamicIslandMetrics
    let experiment: DynamicIslandExperiment
    let availableWidth: CGFloat
    let namespace: Namespace.ID

    var body: some View {
        ZStack {
            switch experiment {
            case .errorBanner:
                DynamicIslandErrorBanner(availableWidth: availableWidth, namespace: namespace)
                    .transition(.scale(scale: 0.96).combined(with: .opacity))
            case .successBanner:
                DynamicIslandSuccessBanner(availableWidth: availableWidth, namespace: namespace)
                    .transition(.scale(scale: 0.96).combined(with: .opacity))
            case .loading, .applyingProgress:
                DynamicIslandLoadingCapsule(
                    metrics: metrics,
                    experiment: experiment,
                    availableWidth: availableWidth,
                    namespace: namespace
                )
                .transition(.scale(scale: 0.96).combined(with: .opacity))
            }
        }
        .animation(DynamicIslandAnimation.morph, value: experiment)
    }
}
