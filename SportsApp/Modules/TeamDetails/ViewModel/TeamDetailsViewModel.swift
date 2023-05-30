//
//  TeamDetailsViewModel.swift
//  SportsApp
//
//  Created by Mac on 24/05/2023.
//

import Foundation
class TeamDetailsViewModel{
    var sportName : String?
    var teamID : String?
    var bindResultToViewController : (()->()) = {}
    var result : Teams!{
        didSet{
            bindResultToViewController()
        }
    }
    //https://apiv2.allsportsapi.com/football/?&met=Teams&teamId=[team_key]&APIkey=[YourKey]
    func getItems(){
//        let param = ["met":"Teams","teamId":teamID!,"APIkey":"fb7419108b900032b89d25268411cef54132de43ba4ceec5dd189418a60a6d33"]
        let url = "https://apiv2.allsportsapi.com/football/?&met=Teams&teamId=\(teamID!)&APIkey=fb7419108b900032b89d25268411cef54132de43ba4ceec5dd189418a60a6d33"
        
        NetworkManager().loadData(url : url) { [weak self] (result : Welcome<Teams>?) in
            self?.result = result?.result?[0]
        }
    }

}
