import SwiftUI

extension View {
    @ViewBuilder
    func dynamicIslandStatusBarHidden(_ hidden: Bool) -> some View {
        #if os(iOS)
        self.statusBarHidden(hidden)
        #else
        self
        #endif
    }
}
