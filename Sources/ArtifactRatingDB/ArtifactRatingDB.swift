// (c) 2024 and onwards Pizza Studio (AGPL v3.0 License or later).
// ====================
// This code is released under the SPDX-License-Identifier: `AGPL-3.0-or-later`.

import Foundation

public enum ARDB {
    public struct RawStatScoreModel: Codable, Hashable {
        public typealias Dict = [String: Self]

        public var main: [String: [String: Double]]
        public var weight: [String: Double]
        public var max: Double
    }

    public static func getBundledARDB4GI() -> [String: RawStatScoreModel] {
        let url = Bundle.module.url(forResource: "ARDB4GI", withExtension: "json")!
        return try! JSONDecoder().decode([String: RawStatScoreModel].self, from: Data(contentsOf: url))
    }

    public static func getBundledARDB4HSR() -> [String: RawStatScoreModel] {
        let url = Bundle.module.url(forResource: "ARDB4HSR", withExtension: "json")!
        return try! JSONDecoder().decode([String: RawStatScoreModel].self, from: Data(contentsOf: url))
    }

    public static func calculateSteps(
        against appendPropIdList: [Int],
        using db: [String: String],
        dbExpiryHandler: (() -> Void)? = nil
    )
        -> [String: Int] {
        var result = [String: Int]() // [PropName: Steps]
        for propID in appendPropIdList {
            // Shouldn't happen unless the database is expired.
            guard let propName = db[propID.description] else {
                dbExpiryHandler?()
                return [:]
            }
            result[propName, default: 0] += 1
        }
        return result
    }

    public static func getBundledCountDB4GI() -> [String: String] {
        let url = Bundle.module.url(forResource: "CountDB4GI", withExtension: "json")!
        return try! JSONDecoder().decode([String: String].self, from: Data(contentsOf: url))
    }
}
