//
//  HomeViewModel.swift
//  SportsApp
//
//  Created by Mac on 21/05/2023.
//

import Foundation
class HomeViewModel{
    var sportName : String?
    var bindResultToViewController : (()->()) = {}
    var result : [Result]!{
        didSet{
            bindResultToViewController()
        }
    }
    
    func getItems(){
        let param = ["met":"Leagues","APIkey":"fb7419108b900032b89d25268411cef54132de43ba4ceec5dd189418a60a6d33"]
        NetworkManager.loadData(sportName: sportName ?? "football" ,param: param) { [weak self] (result : Welcome<Result>?) in
            self?.result = result?.result
        }
    }

}

