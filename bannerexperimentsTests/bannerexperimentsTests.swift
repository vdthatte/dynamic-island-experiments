//
//  bannerexperimentsTests.swift
//  bannerexperimentsTests
//
//  Created by Vidy Thatte on 5/26/26.
//

import Testing
@testable import bannerexperiments

struct bannerexperimentsTests {

    @Test func selectableExperimentsExcludeLoading() {
        #expect(DynamicIslandExperiment.selectableCases == [
            .applyingProgress,
            .errorBanner,
            .successBanner
        ])
    }

    @Test func selectableExperimentTitlesAreUserFacing() {
        #expect(DynamicIslandExperiment.applyingProgress.controlTitle == "Applying Progress")
        #expect(DynamicIslandExperiment.errorBanner.controlTitle == "Error Banner")
        #expect(DynamicIslandExperiment.successBanner.controlTitle == "Success Banner")
    }

    @Test func loadingDoesNotHideStatusBar() {
        #expect(DynamicIslandExperiment.loading.hidesStatusBar == false)
        #expect(DynamicIslandExperiment.applyingProgress.hidesStatusBar)
        #expect(DynamicIslandExperiment.errorBanner.hidesStatusBar)
        #expect(DynamicIslandExperiment.successBanner.hidesStatusBar)
    }

}
