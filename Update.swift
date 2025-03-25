#!/usr/bin/env swift

// (c) 2024 and onwards Pizza Studio (AGPL v3.0 License or later).
// ====================
// This code is released under the SPDX-License-Identifier: `AGPL-3.0-or-later`.

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

#if canImport(WinSDK) || (!canImport(AppKit) && !canImport(UIKit) && !canImport(Glibc))
let isWindows = true
#else
let isWindows = false
#endif

/// An extension that provides async support for fetching a URL
///
/// Needed because the Linux version of Swift does not support async URLSession yet.
extension URLSession {
    enum AsyncError: Error {
        case invalidUrlResponse, missingResponseData
    }

    /// A reimplementation of `URLSession.shared.asyncData(from: url)` required for Linux
    ///
    /// ref: https://gist.github.com/aronbudinszky/66cdb71d734ae48a2609c7f2c094a02d
    ///
    /// - Parameter url: The URL for which to load data.
    /// - Returns: Data and response.
    ///
    /// - Usage:
    ///
    ///     let (data, response) = try await URLSession.shared.asyncData(from: url)
    func asyncData(from url: URL) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: url) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    continuation.resume(throwing: AsyncError.invalidUrlResponse)
                    return
                }
                guard let data = data else {
                    continuation.resume(throwing: AsyncError.missingResponseData)
                    return
                }
                continuation.resume(returning: (data, response))
            }
            task.resume()
        }
    }
}

// MARK: - Update CountDB for Genshin Impact.

let rawDataURLStr = """
https://gitlab.com/Dimbreath/AnimeGameData/-/raw/master/ExcelBinOutput/ReliquaryAffixExcelConfigData.json
"""

let rawDataURL = URL(string: rawDataURLStr)!

let countDBPath = "./Sources/ArtifactRatingDB/Resources/CountDB4GI.json"

// MARK: - ReliquaryAffixExcelConfig

struct ReliquaryAffixExcelConfig: Decodable {
    let id: Int
    let propType: String

    private enum CodingKeys: String, CodingKey {
        case id = "ELKKIAIGOBK"
        case propType = "JJNPGPFNJHP"
    }
}

do {
    let (data, _) = try await URLSession.shared.asyncData(from: rawDataURL)
    let decoded = try JSONDecoder().decode([ReliquaryAffixExcelConfig].self, from: data)
    var result = [String: String]()
    decoded.forEach {
        result[$0.id.description] = $0.propType
    }
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
    let newData = try encoder.encode(result)
    print(String(data: newData, encoding: .utf8)!)
    try newData.write(to: URL(fileURLWithPath: countDBPath), options: .atomic)
} catch {
    print(error)
    exit(1)
}

// MARK: - Update SRS Data.

let rawSRSURLStr = "https://raw.githubusercontent.com/Mar-7th/StarRailScore/master/score.json"
let rawSRSURL = URL(string: rawSRSURLStr)!
let srsDBPath = "./Sources/ArtifactRatingDB/Resources/ARDB4HSR.json"

do {
    let (data, _) = try await URLSession.shared.asyncData(from: rawSRSURL)
    try data.write(to: URL(fileURLWithPath: srsDBPath), options: .atomic)
} catch {
    print(error)
    exit(1)
}
