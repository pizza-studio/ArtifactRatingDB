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

// MARK: - AvatarBaseType

public enum AvatarBaseType: String, Codable, Hashable, Sendable {
    case knight = "Knight"
    case mage = "Mage"
    case memory = "Memory"
    case priest = "Priest"
    case rogue = "Rogue"
    case shaman = "Shaman"
    case warlock = "Warlock"
    case warrior = "Warrior"
}

// MARK: - DamageType

public enum DamageType: String, Codable, Hashable, Sendable {
    case fire = "Fire"
    case ice = "Ice"
    case imaginary = "Imaginary"
    case physical = "Physical"
    case quantum = "Quantum"
    case thunder = "Thunder"
    case wind = "Wind"
}

// MARK: - RelicType

public enum RelicType: String, Codable, Hashable, Sendable {
    case head = "HEAD"
    case hand = "HAND"
    case body = "BODY"
    case foot = "FOOT"
    case neck = "NECK"
    case object = "OBJECT"

    // MARK: Internal

    var typeID: Int {
        switch self {
        case .head: 1
        case .hand: 2
        case .body: 3
        case .foot: 4
        case .neck: 5
        case .object: 6
        }
    }
}

// MARK: - PropertyType

public enum PropertyType: String, Codable, Hashable, Sendable {
    case attackAddedRatio = "AttackAddedRatio"
    case attackDelta = "AttackDelta"
    case breakDamageAddedRatioBase = "BreakDamageAddedRatioBase"
    case criticalChanceBase = "CriticalChanceBase"
    case criticalDamageBase = "CriticalDamageBase"
    case defenceAddedRatio = "DefenceAddedRatio"
    case fireAddedRatio = "FireAddedRatio"
    case healRatioBase = "HealRatioBase"
    case hpAddedRatio = "HPAddedRatio"
    case iceAddedRatio = "IceAddedRatio"
    case imaginaryAddedRatio = "ImaginaryAddedRatio"
    case physicalAddedRatio = "PhysicalAddedRatio"
    case quantumAddedRatio = "QuantumAddedRatio"
    case spRatioBase = "SPRatioBase"
    case speedDelta = "SpeedDelta"
    case statusProbabilityBase = "StatusProbabilityBase"
    case statusResistanceBase = "StatusResistanceBase"
    case thunderAddedRatio = "ThunderAddedRatio"
    case windAddedRatio = "WindAddedRatio"
}

// MARK: - AvatarConfigElement

public struct AvatarConfigElement: Codable, Hashable, Sendable {
    public enum CodingKeys: String, CodingKey {
        case avatarID = "AvatarID"
        case avatarVOTag = "AvatarVOTag"
        case damageType = "DamageType"
        case avatarBaseType = "AvatarBaseType"
    }

    public var avatarBaseType: AvatarBaseType
    public var avatarID: Int
    public var avatarVOTag: String
    public var damageType: DamageType
}

public typealias AvatarConfig = [AvatarConfigElement]
public typealias AvatarRelicRecommend = [AvatarRelicRecommendElement]
public typealias RelicMainAffixAvatarValue = [RelicMainAffixAvatarValueElement]
public typealias RelicSubAffixAvatarValue = [RelicSubAffixAvatarValueElement]

// MARK: - AvatarRelicRecommendElement

public struct AvatarRelicRecommendElement: Codable, Hashable, Sendable {
    public enum CodingKeys: String, CodingKey {
        case avatarID = "AvatarID"
        case propertyList = "PropertyList"
    }

    // MARK: - PropertyList

    public struct PropertyList: Codable, Hashable, Sendable {
        public enum CodingKeys: String, CodingKey {
            case relicType = "RelicType"
            case propertyType = "PropertyType"
        }

        public var relicType: RelicType
        public var propertyType: PropertyType
    }

    public var avatarID: Int
    public var propertyList: [PropertyList]
}

// MARK: - RelicMainAffixAvatarValueElement

public struct RelicMainAffixAvatarValueElement: Codable, Hashable, Sendable {
    // MARK: Public

    public enum CodingKeys: String, CodingKey {
        case avatarID = "AvatarID"
        case attack = "Attack"
        case hp = "HP"
        case defence = "Defence"
        case speed = "Speed"
        case criticalChance = "CriticalChance"
        case criticalDamage = "CriticalDamage"
        case statusProbability = "StatusProbability"
        case breakDamage = "BreakDamage"
        case damageAddedRatio = "DamageAddedRatio"
        case spRatio = "SPRatio"
        case healRatio = "HealRatio"
    }

    // MARK: Internal

    let avatarID: Int
    let attack: Double?
    let hp: Double
    let defence: Double?
    let speed: Double
    let criticalChance: Double?
    let criticalDamage: Double?
    let statusProbability: Double?
    let breakDamage: Double?
    let damageAddedRatio: Double?
    let spRatio: Double?
    let healRatio: Double?
}

// MARK: - RelicSubAffixAvatarValueElement

public struct RelicSubAffixAvatarValueElement: Codable, Hashable, Sendable {
    public enum CodingKeys: String, CodingKey {
        case avatarID = "AvatarID"
        case attack = "Attack"
        case hp = "HP"
        case defence = "Defence"
        case speed = "Speed"
        case criticalChance = "CriticalChance"
        case criticalDamage = "CriticalDamage"
        case statusProbability = "StatusProbability"
        case statusResistance = "StatusResistance"
        case breakDamage = "BreakDamage"
    }

    public var avatarID: Int
    public var attack: Double?
    public var hp: Double
    public var defence: Double?
    public var speed: Double
    public var criticalChance, criticalDamage, statusProbability: Double?
    public var statusResistance: Double
    public var breakDamage: Double?
}

// MARK: - RelicScoreResult

/// Used for encoding final JSON output.
public struct RelicScoreResult: Codable, Hashable, Sendable {
    // MARK: Lifecycle

    public init() {
        self.main = [:]
        for i: Int in 1 ... 6 {
            switch i {
            case 1: main[String(i)] = ["HPDelta": 1]
            case 2: main[String(i)] = ["AttackDelta": 1]
            default: main[String(i)] = [:]
            }
        }
        self.weight = Weight()
        self.max = 0
    }

    // MARK: Public

    public struct Weight: Codable, Hashable, Sendable {
        // MARK: Lifecycle

        public init() {
            self.hpDelta = 0
            self.attackDelta = 0
            self.defenceDelta = 0
            self.hpAddedRatio = 0
            self.attackAddedRatio = 0
            self.defenceAddedRatio = 0
            self.speedDelta = 0
            self.criticalChanceBase = 0
            self.criticalDamageBase = 0
            self.statusProbabilityBase = 0
            self.statusResistanceBase = 0
            self.breakDamageAddedRatioBase = 0
        }

        // MARK: Public

        public var hpDelta: Double
        public var attackDelta: Double
        public var defenceDelta: Double
        public var hpAddedRatio: Double
        public var attackAddedRatio: Double
        public var defenceAddedRatio: Double
        public var speedDelta: Double
        public var criticalChanceBase: Double
        public var criticalDamageBase: Double
        public var statusProbabilityBase: Double
        public var statusResistanceBase: Double
        public var breakDamageAddedRatioBase: Double

        // MARK: Private

        private enum CodingKeys: String, CodingKey {
            case hpDelta = "HPDelta"
            case attackDelta = "AttackDelta"
            case defenceDelta = "DefenceDelta"
            case hpAddedRatio = "HPAddedRatio"
            case attackAddedRatio = "AttackAddedRatio"
            case defenceAddedRatio = "DefenceAddedRatio"
            case speedDelta = "SpeedDelta"
            case criticalChanceBase = "CriticalChanceBase"
            case criticalDamageBase = "CriticalDamageBase"
            case statusProbabilityBase = "StatusProbabilityBase"
            case statusResistanceBase = "StatusResistanceBase"
            case breakDamageAddedRatioBase = "BreakDamageAddedRatioBase"
        }
    }

    public var main: [String: [String: Double]]
    public var weight: Weight
    public var max: Double
}

// MARK: - RelicScoreCalculatorMK2

public final class RelicScoreCalculatorMK2 {
    // MARK: Lifecycle

    // MARK: - Initialization

    public init() {
        self.scoreMap = [:]
        self.baseURL = "https://gitlab.com/Dimbreath/turnbasedgamedata/-/raw/main/ExcelOutput/"
        self.endpoints = [
            "AvatarConfig": "AvatarConfig.json",
            "AvatarConfigLD": "AvatarConfigLD.json",
            "AvatarRelicRecommend": "AvatarRelicRecommend.json",
            "AvatarRelicRecommendLD": "AvatarRelicRecommendLD.json",
            "RelicMainAffixAvatarValue": "RelicMainAffixAvatarValue.json",
            "RelicSubAffixAvatarValue": "RelicSubAffixAvatarValue.json",
        ]
    }

    // MARK: Public

    // MARK: - Public Methods

    public func process() async throws {
        print("Fetching configuration files...")

        var characterMap: AvatarConfig = try await fetchData(
            fromEndpoint: endpoints["AvatarConfig"]!
        ) + fetchData(fromEndpoint: endpoints["AvatarConfigLD"]!)
        characterMap.sort { $0.avatarID < $1.avatarID }
        var relicRecommendMap: AvatarRelicRecommend = try await fetchData(
            fromEndpoint: endpoints["AvatarRelicRecommend"]!
        ) + fetchData(fromEndpoint: endpoints["AvatarRelicRecommendLD"]!)
        relicRecommendMap.sort { $0.avatarID < $1.avatarID }
        let mainRecommendMap: RelicMainAffixAvatarValue =
            try await fetchData(fromEndpoint: endpoints["RelicMainAffixAvatarValue"]!)
        let subRecommendMap: RelicSubAffixAvatarValue =
            try await fetchData(fromEndpoint: endpoints["RelicSubAffixAvatarValue"]!)

        // Initialize scoreMap with default values
        for character: AvatarConfigElement in characterMap {
            let k = String(character.avatarID)
            print("Processing \(k)")
            scoreMap[k] = RelicScoreResult()

            if let relicRecommendItem: AvatarRelicRecommendElement = relicRecommendMap
                .first(where: { $0.avatarID == character.avatarID }) {
                processRelicRecommendations(forCharacter: k, withData: relicRecommendItem)
            }

            if let mainRecommendItem: RelicMainAffixAvatarValueElement = mainRecommendMap
                .first(where: { $0.avatarID == character.avatarID }) {
                processMainRecommendations(
                    forCharacter: k,
                    withData: mainRecommendItem,
                    characterDamageType: character.damageType
                )
            }

            if let subRecommendItem: RelicSubAffixAvatarValueElement = subRecommendMap
                .first(where: { $0.avatarID == character.avatarID }) {
                processSubRecommendations(forCharacter: k, withData: subRecommendItem)
            }
        }

        calculateMaxScores()

        // Sort scoreMap by keys
        scoreMap = Dictionary(uniqueKeysWithValues: scoreMap.sorted { $0.key < $1.key })

        // Save final JSON
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let jsonData: Data = try encoder.encode(scoreMap)
        try jsonData.write(to: URL(fileURLWithPath: "./Sources/ArtifactRatingDB/Resources/ARDB4HSR.json"))

        print("Successfully wrote to score.json")
    }

    // MARK: Private

    private var scoreMap: [String: RelicScoreResult]
    private let baseURL: String
    private let endpoints: [String: String]

    // MARK: - Network Methods

    private func fetchData<T: Decodable>(fromEndpoint endpoint: String) async throws -> T {
        let urlString: String = baseURL + endpoint
        guard let url = URL(string: urlString) else {
            throw NSError(
                domain: "RelicScoreCalculator",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]
            )
        }

        let (data, response): (Data, URLResponse) = try await URLSession.shared.asyncData(from: url)

        guard let httpResponse: HTTPURLResponse = response as? HTTPURLResponse,
              (200 ... 299).contains(httpResponse.statusCode) else {
            throw NSError(
                domain: "RelicScoreCalculator",
                code: 2,
                userInfo: [NSLocalizedDescriptionKey: "Server error"]
            )
        }

        let decoder = JSONDecoder()
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print("[ERROR] \(endpoint)")
            throw error
        }
    }

    // MARK: - Processing Methods

    private func processRelicRecommendations(
        forCharacter k: String,
        withData item: AvatarRelicRecommendElement
    ) {
        guard var score: RelicScoreResult = scoreMap[k] else { return }

        for property: AvatarRelicRecommendElement.PropertyList in item.propertyList {
            let typeID = String(property.relicType.typeID)
            if let scoreForType: [String: Double] = score.main[typeID] {
                var updatedScore: [String: Double] = scoreForType
                switch property.propertyType {
                case .attackDelta:
                    if property.relicType == .hand {
                        updatedScore[property.propertyType.rawValue] = 1
                    }
                default:
                    updatedScore[property.propertyType.rawValue] = 1
                }
                score.main[typeID] = updatedScore
            }
        }

        scoreMap[k] = score
    }

    private func processMainRecommendations(
        forCharacter k: String,
        withData item: RelicMainAffixAvatarValueElement,
        characterDamageType: DamageType
    ) {
        guard var score: RelicScoreResult = scoreMap[k] else { return }

        // Process part 3
        var part3: [String: Double] = score.main["3"] ?? [String: Double]()
        part3["HPAddedRatio"] = Double(item.hp)
        part3["AttackAddedRatio"] = item.attack ?? 0
        part3["DefenceAddedRatio"] = Double(item.defence ?? 0)
        part3["CriticalChanceBase"] = item.criticalChance ?? 0
        part3["CriticalDamageBase"] = item.criticalDamage ?? 0
        part3["HealRatioBase"] = Double(item.healRatio ?? 0)
        part3["StatusProbabilityBase"] = item.statusProbability ?? 0
        score.main["3"] = part3

        // Process part 4
        var part4: [String: Double] = score.main["4"] ?? [String: Double]()
        part4["HPAddedRatio"] = Double(item.hp)
        part4["AttackAddedRatio"] = item.attack ?? 0
        part4["DefenceAddedRatio"] = Double(item.defence ?? 0)
        part4["SpeedDelta"] = Double(item.speed)
        score.main["4"] = part4

        // Process part 5
        var part5: [String: Double] = score.main["5"] ?? [String: Double]()
        part5["HPAddedRatio"] = Double(item.hp)
        part5["AttackAddedRatio"] = item.attack ?? 0
        part5["DefenceAddedRatio"] = Double(item.defence ?? 0)

        if let damageAddedRatio: Double = item.damageAddedRatio {
            switch characterDamageType {
            case .physical: part5["PhysicalAddedRatio"] = damageAddedRatio
            case .fire: part5["FireAddedRatio"] = damageAddedRatio
            case .ice: part5["IceAddedRatio"] = damageAddedRatio
            case .thunder: part5["ThunderAddedRatio"] = damageAddedRatio
            case .wind: part5["WindAddedRatio"] = damageAddedRatio
            case .quantum: part5["QuantumAddedRatio"] = damageAddedRatio
            case .imaginary: part5["ImaginaryAddedRatio"] = damageAddedRatio
            }
        }
        score.main["5"] = part5

        // Process part 6
        var part6: [String: Double] = score.main["6"] ?? [String: Double]()
        part6["BreakDamageAddedRatioBase"] = item.breakDamage ?? 0
        part6["SPRatioBase"] = item.spRatio ?? 0
        part6["HPAddedRatio"] = Double(item.hp)
        part6["AttackAddedRatio"] = item.attack ?? 0
        part6["DefenceAddedRatio"] = Double(item.defence ?? 0)
        score.main["6"] = part6

        // Fix highest values to 1
        for partID: String in ["3", "4", "5", "6"] {
            if var partScore: [String: Double] = score.main[partID] {
                let mirror = Mirror(reflecting: partScore)
                let values: [Double] = mirror.children.compactMap { $0.value as? Double }
                if !values.contains(1), let highest: Double = values.max() {
                    for child: Mirror.Child in mirror.children {
                        if let value: Double = child.value as? Double,
                           value == highest,
                           let label: String = child.label {
                            let updatedValue = 1.0
                            switch label {
                            case "hpAddedRatio": partScore["HPAddedRatio"] = updatedValue
                            case "attackAddedRatio": partScore["AttackAddedRatio"] = updatedValue
                            case "defenceAddedRatio": partScore["DefenceAddedRatio"] = updatedValue
                            case "speedDelta": partScore["SpeedDelta"] = updatedValue
                            case "criticalChanceBase": partScore["CriticalChanceBase"] = updatedValue
                            case "criticalDamageBase": partScore["CriticalDamageBase"] = updatedValue
                            case "healRatioBase": partScore["HealRatioBase"] = updatedValue
                            case "statusProbabilityBase": partScore["StatusProbabilityBase"] = updatedValue
                            case "breakDamageAddedRatioBase": partScore["BreakDamageAddedRatioBase"] = updatedValue
                            case "spRatioBase": partScore["SPRatioBase"] = updatedValue
                            default: break
                            }
                        }
                    }
                    score.main[partID] = partScore
                }
            }
        }

        // Fix attack and damage
        if let damageAdd: Double = item.damageAddedRatio,
           let attackAdd: Double = item.attack,
           damageAdd > 0.1,
           attackAdd > 0.1,
           var part5: [String: Double] = score.main["5"] {
            part5["AttackAddedRatio"] = max(min(1, round(damageAdd * 0.8 * 10) / 10), attackAdd)
            score.main["5"] = part5
        }

        scoreMap[k] = score
    }

    private func processSubRecommendations(
        forCharacter k: String,
        withData item: RelicSubAffixAvatarValueElement
    ) {
        guard var score: RelicScoreResult = scoreMap[k] else { return }

        var weight = RelicScoreResult.Weight()

        // Process HP, Attack, and Defence deltas
        weight.hpDelta = item.hp > 0.1 ? round(item.hp / 3 * 10) / 10 : 0
        if let attack: Double = item.attack {
            weight.attackDelta = attack > 0.1 ? round(attack / 3 * 10) / 10 : 0
        }
        if let defence: Double = item.defence {
            weight.defenceDelta = defence > 0.1 ? round(defence / 3 * 10) / 10 : 0
        }

        // Process direct mappings
        weight.hpAddedRatio = item.hp
        if let attack: Double = item.attack { weight.attackAddedRatio = attack }
        if let defence: Double = item.defence { weight.defenceAddedRatio = defence }
        weight.speedDelta = item.speed
        if let criticalChance: Double = item.criticalChance { weight.criticalChanceBase = criticalChance }
        if let criticalDamage: Double = item.criticalDamage { weight.criticalDamageBase = criticalDamage }
        if let statusProbability: Double = item.statusProbability { weight.statusProbabilityBase = statusProbability }
        weight.statusResistanceBase = item.statusResistance
        if let breakDamage: Double = item.breakDamage { weight.breakDamageAddedRatioBase = breakDamage }

        score.weight = weight
        scoreMap[k] = score
    }

    private func calculateMaxScores() {
        for (k, score) in scoreMap {
            let weightMirror = Mirror(reflecting: score.weight)
            let weightValues: [(String, Double)] = weightMirror.children
                .compactMap {
                    if let label = $0.label, let value = $0.value as? Double {
                        return (label, value)
                    }
                    return nil
                }
                .sorted { $0.1 > $1.1 }

            var maxScore: Double = 0

            for i: String in ["3", "4", "5", "6"] {
                guard let partScore: [String: Double] = score.main[i] else { continue }
                let partMirror = Mirror(reflecting: partScore)
                let partValues: [(String, Double)] = partMirror.children
                    .compactMap {
                        if let label = $0.label, let value = $0.value as? Double {
                            return (label, value)
                        }
                        return nil
                    }

                if let highestPartValue: (String, Double) = partValues.first {
                    let subAffixWeightThis: ArraySlice<(String, Double)> = weightValues
                        .filter { $0.0 != highestPartValue.0 }
                        .prefix(4)

                    if subAffixWeightThis.count >= 4 {
                        maxScore += 1.2 * (
                            subAffixWeightThis[0].1 * 6 +
                                subAffixWeightThis[1].1 +
                                subAffixWeightThis[2].1 +
                                subAffixWeightThis[3].1
                        )
                    }
                }
            }

            // Max 4+5 sub affix
            if weightValues.count >= 4 {
                maxScore += 2 * 1.2 * (
                    weightValues[0].1 * 6 +
                        weightValues[1].1 +
                        weightValues[2].1 +
                        weightValues[3].1
                )
            }

            var finalMaxScore: Double = maxScore / 6.0
            if String(finalMaxScore).count > 6 {
                finalMaxScore = round(finalMaxScore * 1000) / 1000
            }

            scoreMap[k]?.max = finalMaxScore
        }
    }
}

// MARK: - Main Process

try await RelicScoreCalculatorMK2().process()
