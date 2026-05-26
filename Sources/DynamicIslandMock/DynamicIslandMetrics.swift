//  iOS does not expose the physical Dynamic Island frame. These metrics use
//  known Dynamic Island screen sizes with a geometry-based fallback.

import SwiftUI

struct DynamicIslandMetrics {
    let islandSize: CGSize
    let topOffset: CGFloat

    var borderSize: CGSize {
        CGSize(width: islandSize.width + 16, height: (islandSize.height + 8) * 1.02)
    }

    static func forCurrentDevice(in proxy: GeometryProxy) -> Self {
        let screenSize = normalizedScreenSize(proxy.size)

        switch screenSize {
        case CGSize(width: 393, height: 852), CGSize(width: 402, height: 874):
            return Self(islandSize: CGSize(width: 126, height: 37), topOffset: -50)
        case CGSize(width: 430, height: 932), CGSize(width: 440, height: 956):
            return Self(islandSize: CGSize(width: 126, height: 37), topOffset: -50)
        default:
            return fallbackMetrics(for: proxy)
        }
    }

    private static func normalizedScreenSize(_ size: CGSize) -> CGSize {
        CGSize(
            width: min(size.width.rounded(), size.height.rounded()),
            height: max(size.width.rounded(), size.height.rounded())
        )
    }

    private static func fallbackMetrics(for proxy: GeometryProxy) -> Self {
        let width = min(max(proxy.size.width * 0.32, 118), 132)
        return Self(
            islandSize: CGSize(width: width, height: 37),
            topOffset: -max(proxy.safeAreaInsets.top - 9, 44)
        )
    }
}
