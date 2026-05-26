import SwiftUI

struct DynamicIslandExperimentControls: View {
    let selectedExperiment: DynamicIslandExperiment?
    let selectExperiment: (DynamicIslandExperiment) -> Void

    var body: some View {
        VStack(spacing: 12) {
            ForEach(DynamicIslandExperiment.selectableCases) { experiment in
                DynamicIslandExperimentButton(
                    experiment: experiment,
                    selectedExperiment: selectedExperiment,
                    selectExperiment: selectExperiment
                )
            }
        }
    }
}

private struct DynamicIslandExperimentButton: View {
    let experiment: DynamicIslandExperiment
    let selectedExperiment: DynamicIslandExperiment?
    let selectExperiment: (DynamicIslandExperiment) -> Void

    private var isSelected: Bool {
        selectedExperiment == experiment
    }

    var body: some View {
        Button {
            selectExperiment(experiment)
        } label: {
            Text(experiment.controlTitle)
                .font(.system(size: 16, weight: .semibold))
                .frame(maxWidth: .infinity)
                .frame(height: 48)
        }
        .buttonStyle(.borderedProminent)
        .tint(isSelected ? .blue : .black)
        .scaleEffect(isSelected ? 1.025 : 1)
        .animation(DynamicIslandAnimation.content, value: selectedExperiment)
    }
}
