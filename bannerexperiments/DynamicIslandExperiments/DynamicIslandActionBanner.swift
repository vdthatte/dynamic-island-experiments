//
//  DynamicIslandActionBanner.swift
//  bannerexperiments
//

import SwiftUI

struct DynamicIslandErrorBanner: View {
    let availableWidth: CGFloat
    let namespace: Namespace.ID

    var body: some View {
        DynamicIslandActionBanner(
            availableWidth: availableWidth,
            namespace: namespace,
            iconName: "exclamationmark.octagon.fill",
            iconColor: .red,
            title: "Something went wrong",
            subtitle: "Tap Apply Fix to continue.",
            buttonTitle: "Apply Fix",
            accentColor: Color(red: 0.98, green: 0.21, blue: 0.2),
            buttonBackground: Color(red: 0.11, green: 0.06, blue: 0.07)
        )
    }
}

struct DynamicIslandSuccessBanner: View {
    let availableWidth: CGFloat
    let namespace: Namespace.ID

    var body: some View {
        DynamicIslandActionBanner(
            availableWidth: availableWidth,
            namespace: namespace,
            iconName: "checkmark.circle.fill",
            iconColor: Color(red: 0.2, green: 0.78, blue: 0.36),
            title: "Update available!",
            subtitle: "Reload to see changes.",
            buttonTitle: "Reload",
            accentColor: Color(red: 0.2, green: 0.78, blue: 0.36),
            buttonBackground: Color(red: 0.04, green: 0.13, blue: 0.07)
        )
    }
}

private struct DynamicIslandActionBanner: View {
    let availableWidth: CGFloat
    let namespace: Namespace.ID
    let iconName: String
    let iconColor: Color
    let title: String
    let subtitle: String
    let buttonTitle: String
    let accentColor: Color
    let buttonBackground: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: iconName)
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundStyle(iconColor)
                    .frame(width: 50)
                    .padding(.top, 1)

                VStack(alignment: .leading, spacing: 3) {
                    Text(title)
                        .font(.system(size: 21, weight: .medium))
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.82)

                    Text(subtitle)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(.gray)
                        .lineLimit(1)
                        .minimumScaleFactor(0.82)
                }

                Spacer(minLength: 0)
            }
            .padding(.top, 38)

            Color.clear
                .frame(height: 10)

            Button {
            } label: {
                HStack(alignment: .top, spacing: 10) {
                    Text(buttonTitle)
                        .font(.custom("SF Pro Text", size: 18).weight(.medium))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(accentColor)
                        .lineLimit(1)
                        .minimumScaleFactor(0.72)
                        .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 13)
                .frame(maxWidth: .infinity, alignment: .top)
                .background(buttonBackground)
                .cornerRadius(300)
            }
            .buttonStyle(.plain)
            .padding(.bottom, 4)
        }
        .padding(.horizontal, 16)
        .frame(width: min(367, availableWidth - 24), height: 164, alignment: .topLeading)
        .background {
            RoundedRectangle(cornerRadius: 42, style: .continuous)
                .fill(.black)
                .matchedGeometryEffect(id: "islandSurface", in: namespace)
        }
        .shadow(color: .black.opacity(0.25), radius: 8, x: 0, y: 8)
    }
}
