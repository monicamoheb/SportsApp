//
//  FavViewModelTests.swift
//  SportsAppTests
//
//  Created by Mac on 31/05/2023.
//

import XCTest
@testable import SportsApp

final class FavViewModelTests: XCTestCase {

    var favViewModel: FavViewModel?
      var favCoreData: LocalSource!
    
      override func setUpWithError() throws {
          // Put setup code here. This method is called before the invocation of each test method in the class.
          favCoreData = LocalSourceMock()
          favViewModel=FavViewModel(favCoreData: favCoreData)
          
      }
      
      override func tearDownWithError() throws {
          // Put teardown code here. This method is called after the invocation of each test method in the class.
          favViewModel = nil
          favCoreData = nil
      }
      
      func testGetFavItems(){
          favViewModel?.getItems()
          
          XCTAssertNotNil(favViewModel?.result)
         XCTAssertEqual(favViewModel?.result.count, 7)
      }
      func testInsertFavItem(){
          favViewModel?.getItems()
          
          guard let count = favViewModel?.result.count else { return }
          
          favViewModel?.insertLeague(league: LeagueLocal(sport: "", name: "", logo: "", key: 7))
          
          favViewModel?.getItems()
          
          XCTAssertEqual(favViewModel?.result.count, count+1)
          
      }
    
    func testDeleteFromFavItem(){
        favViewModel?.getItems()
        
        guard var count = favViewModel?.result.count else { return }
        
        favViewModel?.deleteLeague(leagueID: 5)
        
        favViewModel?.getItems()
        
        XCTAssertEqual(favViewModel?.result.count, count-1)
        
    }
}
