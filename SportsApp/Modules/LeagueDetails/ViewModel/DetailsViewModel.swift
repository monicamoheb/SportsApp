//
//  DetailsViewModel.swift
//  SportsApp
//
//  Created by Mac on 23/05/2023.
//

import Foundation
import Alamofire
class DetailsViewModel{
    
    var sportName : String?
    var leagueID : String!
    var bindResultToViewController : (()->()) = {}
    var result : [Event]!{
        didSet{
            bindResultToViewController()
        }
    }
    var latesEvent : [Event]!{
        didSet{
            bindResultToViewController()
        }
    }
    var teams : [Event]!{
        didSet{
            bindResultToViewController()
        }
    }
    // https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=205&from=2023-01-18&to=2024-01-18&APIkey=fb7419108b900032b89d25268411cef54132de43ba4ceec5dd189418a60a6d33
    // https://apiv2.allsportsapi.com/football?met=Fixtures&leagueId=[leagueId]&from=[CurrentDate - OneYear]&to=[CurrentDate]&APIkey=[YourKey]
    //https://apiv2.allsportsapi.com/football?met=Fixtures&leagueId=205&from=from=2022-01-18&to=2023-01-18&APIkey=fb7419108b900032b89d25268411cef54132de43ba4ceec5dd189418a60a6d33
    
    func getItems(){
        // Create Date
        let date = Date()
        // Create Date Formatter
        let dateFormatter = DateFormatter()
        // Set Date Format
        dateFormatter.dateFormat = "YYYY-MM-dd"
        // Convert Date to String
        let dateStr = dateFormatter.string(from: date)
        let afterYear = Date.init(timeIntervalSinceNow: 365 * 24 * 60 * 60)
        let afterYearStr = dateFormatter.string(from: afterYear)
        
        var param = ["met":"Fixtures", "leagueId":leagueID!,"from":dateStr, "to":afterYearStr,
                     "APIkey":"fb7419108b900032b89d25268411cef54132de43ba4ceec5dd189418a60a6d33"]
        
        NetworkManager.loadData(sportName: sportName ?? "football" ,param: param ) { [weak self] (result : Welcome<Event>?) in
            self?.result = result?.result
            // print(self?.result[0].countryName)
        }
        
        if let yearAgoDate = Calendar.current.date(byAdding: .year, value: -1, to: Date()) {
            // Use this date
            let yearAgoStr = dateFormatter.string(from: yearAgoDate)
            param = ["met":"Fixtures", "leagueId":leagueID!,"from":yearAgoStr, "to":dateStr,
                     "APIkey":"fb7419108b900032b89d25268411cef54132de43ba4ceec5dd189418a60a6d33"]
            NetworkManager.loadData(sportName: sportName ?? "football" ,param: param) { [weak self] (result : Welcome<Event>?) in
                self?.latesEvent = result?.result
                //  print(self?.latesEvent[0].countryName)
            }
        }
    }
    
    
    
}
