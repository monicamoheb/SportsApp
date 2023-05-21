//
//  Result.swift
//  SportsApp
//
//  Created by Mac on 21/05/2023.
//

import Foundation

// MARK: - Result
class Result: Codable {
    var leagueKey: Int?
    var leagueName: String?
    var countryKey: Int?
    var countryName: String?
    var leagueLogo, countryLogo: String?

    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case countryKey = "country_key"
        case countryName = "country_name"
        case leagueLogo = "league_logo"
        case countryLogo = "country_logo"
    }

    init(leagueKey: Int, leagueName: String, countryKey: Int, countryName: String, leagueLogo: String?, countryLogo: String?) {
        self.leagueKey = leagueKey
        self.leagueName = leagueName
        self.countryKey = countryKey
        self.countryName = countryName
        self.leagueLogo = leagueLogo
        self.countryLogo = countryLogo
    }
    init() {
        
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.leagueKey = try container.decodeIfPresent(Int.self, forKey: .leagueKey)
        self.leagueName = try container.decodeIfPresent(String.self, forKey: .leagueName)
        self.countryKey = try container.decodeIfPresent(Int.self, forKey: .countryKey)
        self.countryName = try container.decodeIfPresent(String.self, forKey: .countryName)
        self.leagueLogo = try container.decodeIfPresent(String.self, forKey: .leagueLogo)
        self.countryLogo = try container.decodeIfPresent(String.self, forKey: .countryLogo)
    }
}
