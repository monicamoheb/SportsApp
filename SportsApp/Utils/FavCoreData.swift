//
//  FavCoreData.swift
//  SportsApp
//
//  Created by Mac on 21/05/2023.
//

import Foundation
import CoreData
import UIKit
protocol LocalSource {
    func insert (newLeagues : LeagueLocal)
    func fetchAll()-> Array<LeagueLocal>
    func deleteLeague(key:Int)
    func getSportFromLocal(id: Int) -> Bool
}
class FavCodeData : LocalSource{
    static let sharedDB = FavCodeData()
    
    var manager : NSManagedObjectContext!
    var leagues : [NSManagedObject] = []
    
    private init(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        manager = appDelegate.persistentContainer.viewContext
    }
    
    func insert (newLeagues : LeagueLocal){
        //2-
        let entity = NSEntityDescription.entity(forEntityName: "Leagues", in: manager)
        //3-
        let leagues = NSManagedObject(entity: entity!, insertInto: manager)
        leagues.setValue(newLeagues.key, forKey: "leagueKey")
        leagues.setValue(newLeagues.name, forKey: "leagueName")
        leagues.setValue(newLeagues.logo, forKey: "leagueLogo")
        leagues.setValue(newLeagues.sport, forKey: "sportName")
        
        //4-
        do{
            try manager.save()
            print("Saved!")
        }catch let error{
            print(error.localizedDescription)
        }
        
    }
    
    func fetchAll()-> Array<LeagueLocal>{
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "Leagues")
        
        do{
            leagues = try manager.fetch(fetch)
        }catch let error{
            print(error.localizedDescription)
        }
        
        var leaguesList = Array<LeagueLocal>()
        for item in leagues{
            
            let key = item.value(forKey: "leagueKey") as? Int
            let name = item.value(forKey: "leagueName") as? String
            let logo = item.value(forKey: "leagueLogo") as? String
            let sport = item.value(forKey: "sportName") as? String
            
            let league = LeagueLocal(sport: sport!, name: name!, logo: logo!, key: key!)
            
            leaguesList.append(league)
        }
        return leaguesList
    }
    
    func deleteLeague(key:Int){
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "Leagues")
        //var leagues = self.fetchAll()
        
        let predicate = NSPredicate(format: "leagueKey == \(key)")
        fetch.predicate = predicate
        
        var fetchObject = [NSManagedObject]()
        do{
            fetchObject = try manager.fetch(fetch)
            
        }catch let error{
            print(error.localizedDescription)
        }
        manager.delete(fetchObject[0])
        do{
            try manager.save()
            print("Deleted!")
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
    func getSportFromLocal(id: Int) -> Bool{
        
        let fetchRequest : NSFetchRequest<Leagues> = Leagues.fetchRequest()
        
        let myPredicate = NSPredicate.init(format: "leagueKey == \(id)")
        fetchRequest.predicate = myPredicate
        
        if let result = try? manager.fetch(fetchRequest){
            if result.count > 0{
                return true
            }
        }
        return false
    }
    
    //    func deleteAll (){
    //
    //        let fetch = NSFetchRequest<NSManagedObject>(entityName: "Movie")
    //
    //        do{
    //            movies = try manager.fetch(fetch)
    //        }catch let error{
    //            print(error.localizedDescription)
    //        }
    //
    //        for item in movies{
    //            manager.delete(item)
    //        }
    //        do{
    //            try manager.save()
    //            print("Deleted all!")
    //        }catch let error{
    //            print(error.localizedDescription)
    //        }
    //
    //    }
}
