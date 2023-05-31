//
//  LocalSourseTests.swift
//  SportsAppTests
//
//  Created by Mac on 31/05/2023.
//

import Foundation
@testable import SportsApp
class LocalSourceMock: LocalSource{
    
    var leagues: [LeagueLocal]!
    init(){
        leagues = [ LeagueLocal(sport: "", name: "", logo: "", key: 0),
                    LeagueLocal(sport: "basketball", name: "sport2", logo: "sport2", key: 1),
                    LeagueLocal(sport: "tennis",  name: "sport3", logo: "sport3", key: 2),
                    LeagueLocal(sport: "football",name: "sport4", logo: "sport4", key: 3),
                    LeagueLocal(sport: "basketball",name: "sport5", logo: "sport5", key: 4),
                    LeagueLocal(sport: "cricket",name: "sport6", logo: "sport6", key: 5),
                    LeagueLocal(sport: "cricket",name: "sport7", logo: "sport7", key: 6)]
        
    }
    func insert(newLeagues: SportsApp.LeagueLocal) {
        leagues.append(newLeagues)
    }
    
    func fetchAll() -> Array<SportsApp.LeagueLocal> {
        return leagues
    }
    
    func deleteLeague(key: Int) {
        for i in 0..<leagues.count{
            
            if  leagues[i].key == key{
                leagues.remove(at: i)
                break
            }
        }
    }
    
    func getSportFromLocal(id: Int) -> Bool {
        for i in leagues{
            if   i.key == id{
                return true
            }
        }
        
        return  false
    }
}

