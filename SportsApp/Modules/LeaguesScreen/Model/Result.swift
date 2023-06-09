//
//  Result.swift
//  SportsApp
//
//  Created by Mac on 21/05/2023.
//

import Foundation

// MARK: - Result
class Result: Decodable {
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

}
