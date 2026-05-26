import SwiftUI

enum DynamicIslandAnimation {
    static let morph = Animation.spring(response: 0.42, dampingFraction: 0.82, blendDuration: 0.06)
    static let content = Animation.spring(response: 0.32, dampingFraction: 0.72, blendDuration: 0.04)
}
