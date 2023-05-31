//
//  Bundle.swift
//  SportsAppTests
//
//  Created by Mac on 30/05/2023.
//

import Foundation
extension Bundle {
    public class var unitTest :Bundle{
        return Bundle(for: ApiServiceTests.self)
    }
}
