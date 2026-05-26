import SwiftUI

public struct DynamicIslandMock: View {
    @Binding private var experiment: DynamicIslandExperiment
    @Namespace private var islandNamespace

    public init(experiment: Binding<DynamicIslandExperiment>) {
        self._experiment = experiment
    }

    public var body: some View {
        GeometryReader { proxy in
            let metrics = DynamicIslandMetrics.forCurrentDevice(in: proxy)

            DynamicIslandExperimentSurface(
                metrics: metrics,
                experiment: experiment,
                availableWidth: proxy.size.width,
                namespace: islandNamespace
            )
            .padding(.top, metrics.topOffset)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .dynamicIslandStatusBarHidden(experiment.hidesStatusBar)
    }
}
