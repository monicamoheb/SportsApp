//
//  Welcome.swift
//  SportsApp
//
//  Created by Mac on 21/05/2023.
//

import Foundation

// MARK: - Welcome
class Welcome: Codable {
    var success: Int?
    var result: [Result]?

    init(success: Int, result: [Result]) {
        self.success = success
        self.result = result
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decode(Int.self, forKey: .success)
        self.result = try container.decode([Result].self, forKey: .result)
    }
    init(){
        
    }
}
