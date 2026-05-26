//
//  DynamicIslandLoadingCapsule.swift
//  bannerexperiments
//

import SwiftUI

struct DynamicIslandLoadingCapsule: View {
    let metrics: DynamicIslandMetrics
    let experiment: DynamicIslandExperiment
    let availableWidth: CGFloat
    let namespace: Namespace.ID

    @State private var rotation: Angle = .degrees(0)
    @State private var isRainbowBorderVisible = false
    @State private var borderVisibilityGeneration = 0

    private var isAnimating: Bool {
        experiment == .loading
    }

    private var displaySize: CGSize {
        switch experiment {
        case .applyingProgress:
            CGSize(width: min(max(metrics.borderSize.width + 150, 274), availableWidth - 96), height: metrics.borderSize.height)
        case .loading, .errorBanner, .successBanner:
            metrics.borderSize
        }
    }

    var body: some View {
        Capsule(style: .continuous)
            .fill(backgroundColor)
            .matchedGeometryEffect(id: "islandSurface", in: namespace)
            .overlay {
                if experiment == .applyingProgress {
                    ApplyingProgressStatusContent()
                        .padding(.leading, 12)
                        .padding(.trailing, 15)
                } else if experiment == .loading {
                    Capsule(style: .continuous)
                        .strokeBorder(rainbowGradient, lineWidth: 2.5)
                        .opacity(isRainbowBorderVisible ? 1 : 0)
                }
            }
            .frame(width: displaySize.width, height: displaySize.height)
            .shadow(color: .black.opacity(0.22), radius: 5, y: 2)
            .allowsHitTesting(false)
            .accessibilityHidden(true)
            .animation(DynamicIslandAnimation.morph, value: displaySize)
            .animation(DynamicIslandAnimation.content, value: experiment)
            .onAppear {
                updateAnimation()
            }
            .onChange(of: experiment) {
                updateAnimation()
            }
    }

    private var rainbowGradient: AngularGradient {
        AngularGradient(
            colors: [
                Color(red: 49 / 255, green: 134 / 255, blue: 255 / 255),
                Color(red: 255 / 255, green: 70 / 255, blue: 65 / 255),
                Color(red: 255 / 255, green: 204 / 255, blue: 0 / 255),
                Color(red: 14 / 255, green: 188 / 255, blue: 95 / 255),
                Color(red: 49 / 255, green: 134 / 255, blue: 255 / 255)
            ],
            center: .center,
            angle: rotation
        )
    }

    private func updateAnimation() {
        if isAnimating {
            isRainbowBorderVisible = false
            borderVisibilityGeneration += 1
            let generation = borderVisibilityGeneration
            rotation = .degrees(0)

            withAnimation(.linear(duration: 1.2).repeatForever(autoreverses: false)) {
                rotation = .degrees(360)
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.42) {
                guard borderVisibilityGeneration == generation, isAnimating else {
                    return
                }

                withAnimation(.easeOut(duration: 0.22)) {
                    isRainbowBorderVisible = true
                }
            }
        } else {
            borderVisibilityGeneration += 1
            isRainbowBorderVisible = false

            withAnimation(.easeOut(duration: 0.2)) {
                rotation = .degrees(0)
            }
        }
    }

    private var backgroundColor: Color {
        .black
    }
}

private struct ApplyingProgressStatusContent: View {
    @State private var progress = 0.0

    var body: some View {
        HStack(spacing: 8) {
            ProgressIndicator(progress: progress)

            Spacer(minLength: 120)

            Text("Applying")
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
                .lineLimit(1)
        }
        .onAppear {
            progress = 0

            withAnimation(.linear(duration: 60)) {
                progress = 0.85
            }
        }
    }
}

private struct ProgressIndicator: View {
    let progress: Double

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(red: 0.22, green: 0.75, blue: 0.35).opacity(0.25), lineWidth: 4.41816)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color(red: 0.22, green: 0.75, blue: 0.35),
                    style: StrokeStyle(lineWidth: 4.41816, lineCap: .round)
                )
                .rotationEffect(.degrees(-85))
        }
        .frame(width: 26, height: 26)
    }
}
