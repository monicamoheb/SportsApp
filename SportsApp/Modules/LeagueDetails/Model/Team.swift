//
//  Team.swift
//  SportsApp
//
//  Created by Mac on 23/05/2023.
//

import Foundation

struct Team: Decodable, Hashable{
    let teamLogo: String?
    let teamName: String?
    let teamKey: Int?
  
    enum CodingKeys: String, CodingKey{
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
    }
}


