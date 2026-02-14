// (c) 2024 and onwards Pizza Studio (AGPL v3.0 License or later).
// ====================
// This code is released under the SPDX-License-Identifier: `AGPL-3.0-or-later`.

@testable import ArtifactRatingDB
import Testing

@Suite(.serialized)
struct ArtifactRatingDBTests {
    @Test
    func testLoadingBundleData() throws {
        _ = ARDB.getBundledARDB4GI()
        _ = ARDB.getBundledARDB4HSR()
        _ = ARDB.getBundledCountDB4GI()
    }

    @Test
    func testCalculatingSteps() throws {
        let db = ARDB.getBundledCountDB4GI()
        let result = ARDB.calculateSteps(
            against: [501082, 501052, 501023, 501203, 501083, 501203, 501053, 501201],
            using: db
        )
        #expect(result["FIGHT_PROP_CRITICAL"] == 3)
    }
}
