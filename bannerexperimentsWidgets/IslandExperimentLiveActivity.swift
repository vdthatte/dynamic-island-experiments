//
//  IslandExperimentLiveActivity.swift
//  bannerexperimentsWidgets
//
//  Created by Vidy Thatte on 5/26/26.
//

import ActivityKit
import SwiftUI
import WidgetKit

@main
struct BannerExperimentsWidgets: WidgetBundle {
    var body: some Widget {
        IslandExperimentLiveActivity()
    }
}

struct IslandExperimentLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: IslandExperimentAttributes.self) { context in
            LiveActivityLockScreenView(state: context.state)
                .activityBackgroundTint(.black)
                .activitySystemActionForegroundColor(.white)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    ActivityGlyph(state: context.state, size: 46)
                }

                DynamicIslandExpandedRegion(.center) {
                    VStack(alignment: .leading, spacing: 3) {
                        Text(context.state.title)
                            .font(.system(size: 15, weight: .bold))
                            .lineLimit(1)
                        Text(context.state.subtitle)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                DynamicIslandExpandedRegion(.trailing) {
                    Text("\(Int(context.state.progress * 100))%")
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundStyle(islandTint(for: context.state))
                        .monospacedDigit()
                }

                DynamicIslandExpandedRegion(.bottom) {
                    ProgressView(value: context.state.progress)
                        .tint(islandTint(for: context.state))
                }
            } compactLeading: {
                ActivityGlyph(state: context.state, size: 24)
            } compactTrailing: {
                Text("\(Int(context.state.progress * 100))")
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundStyle(islandTint(for: context.state))
                    .monospacedDigit()
            } minimal: {
                Image(systemName: context.state.symbolName)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(islandTint(for: context.state))
            }
            .widgetURL(URL(string: "bannerexperiments://island"))
            .keylineTint(islandTint(for: context.state))
        }
    }
}

private struct LiveActivityLockScreenView: View {
    let state: IslandExperimentAttributes.ContentState

    var body: some View {
        HStack(spacing: 14) {
            ActivityGlyph(state: state, size: 44)

            VStack(alignment: .leading, spacing: 4) {
                Text(state.title)
                    .font(.headline)
                    .lineLimit(1)
                Text(state.subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                ProgressView(value: state.progress)
                    .tint(islandTint(for: state))
            }
        }
        .padding()
    }
}

private struct ActivityGlyph: View {
    let state: IslandExperimentAttributes.ContentState
    let size: CGFloat

    var body: some View {
        ZStack {
            Circle()
                .fill(islandTint(for: state).opacity(0.24))
            Image(systemName: state.symbolName)
                .font(.system(size: size * 0.42, weight: .semibold))
                .foregroundStyle(islandTint(for: state))
        }
        .frame(width: size, height: size)
    }
}

private func islandTint(for state: IslandExperimentAttributes.ContentState) -> Color {
    switch state.tintName {
    case "green":
        return Color(red: 0.5, green: 0.92, blue: 0.52)
    case "orange":
        return Color(red: 1.0, green: 0.61, blue: 0.36)
    default:
        return Color(red: 0.35, green: 0.76, blue: 1.0)
    }
}
