//
//  FavViewModel.swift
//  SportsApp
//
//  Created by Mac on 25/05/2023.
//

import Foundation

class FavViewModel{
    
    var bindResultToViewController : (()->()) = {}
    
    var favCoreData : LocalSource?
    
    init(favCoreData: LocalSource) {
        self.favCoreData = favCoreData
    }
    
    var result : [LeagueLocal]!{
        didSet{
            bindResultToViewController()
        }
    }
    
    func getItems(){
        result = favCoreData?.fetchAll()
    }
    
    func deleteLeague(leagueID : Int){
        favCoreData?.deleteLeague(key: leagueID)
    }
    func insertLeague(league : LeagueLocal){
        favCoreData?.insert(newLeagues: league)
    }
    

}
