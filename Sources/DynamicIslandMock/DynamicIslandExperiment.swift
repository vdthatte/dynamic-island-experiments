import Foundation

public enum DynamicIslandExperiment: Equatable, Identifiable, Sendable {
    case loading
    case applyingProgress
    case errorBanner
    case successBanner

    public static let selectableCases: [Self] = [
        .applyingProgress,
        .errorBanner,
        .successBanner
    ]

    public var id: Self {
        self
    }

    public var controlTitle: String {
        switch self {
        case .loading:
            "Loading"
        case .applyingProgress:
            "Applying Progress"
        case .errorBanner:
            "Error Banner"
        case .successBanner:
            "Success Banner"
        }
    }

    public var hidesStatusBar: Bool {
        switch self {
        case .loading:
            false
        case .applyingProgress, .errorBanner, .successBanner:
            true
        }
    }
}
