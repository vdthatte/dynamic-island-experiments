import SwiftUI

public struct DynamicIslandExperimentHost: View {
    @Namespace private var islandNamespace
    @State private var activeExperiment: DynamicIslandExperiment = .loading
    @State private var selectedExperiment: DynamicIslandExperiment?
    @State private var transitionID = UUID()

    public init() {}

    public var body: some View {
        GeometryReader { proxy in
            let metrics = DynamicIslandMetrics.forCurrentDevice(in: proxy)

            ZStack {
                background
                    .ignoresSafeArea()

                VStack {
                    DynamicIslandExperimentSurface(
                        metrics: metrics,
                        experiment: activeExperiment,
                        availableWidth: proxy.size.width,
                        namespace: islandNamespace
                    )
                    .padding(.top, metrics.topOffset)

                    Spacer()

                    DynamicIslandExperimentControls(
                        selectedExperiment: selectedExperiment,
                        selectExperiment: selectExperiment
                    )
                        .padding(.horizontal, 24)
                        .padding(.bottom, 28)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .dynamicIslandStatusBarHidden(
            activeExperiment.hidesStatusBar ||
            (selectedExperiment?.hidesStatusBar ?? false)
        )
    }

    @ViewBuilder
    private var background: some View {
        Color.white
    }

    private func selectExperiment(_ experiment: DynamicIslandExperiment) {
        guard activeExperiment != experiment else {
            return
        }

        let nextTransitionID = UUID()
        transitionID = nextTransitionID
        selectedExperiment = experiment

        withAnimation(DynamicIslandAnimation.morph) {
            activeExperiment = .loading
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            guard transitionID == nextTransitionID else {
                return
            }

            withAnimation(DynamicIslandAnimation.morph) {
                activeExperiment = experiment
            }
        }
    }
}
