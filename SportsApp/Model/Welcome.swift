//
//  Welcome.swift
//  SportsApp
//
//  Created by Mac on 21/05/2023.
//

import Foundation

// MARK: - Welcome
class Welcome: Decodable {
    var success: Int?
    var result: [Result]?

    init(success: Int, result: [Result]) {
        self.success = success
        self.result = result
    }
    init(){
        
    }
}
