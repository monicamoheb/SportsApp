//
//  Welcome.swift
//  SportsApp
//
//  Created by Mac on 21/05/2023.
//

import Foundation

// MARK: - Welcome
class Welcome<T>: Decodable where T: Decodable{
    var success: Int?
    var result: [T]?

    init(success: Int, result: [T]) {
        self.success = success
        self.result = result
    }
    init(){
        
    }
}
