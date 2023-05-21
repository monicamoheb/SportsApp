//
//  NetworkManager.swift
//  MVPDemo
//
//  Created by Iti on 5/17/23.
//  Copyright © 2023 Esraa. All rights reserved.
//

import Foundation
protocol NetworkService{
    static func loadData<T: Decodable>(compilitionHandler: @escaping (T?) -> Void)
}
class NetworkManager : NetworkService{
    
    static func loadData<T: Decodable>(compilitionHandler: @escaping (T?) -> Void){
        //1-
        let url = URL(string: "https://imdb-api.com/en/API/BoxOffice/k_uw09j68u")
        guard let urlFinal = url else {
            return
        }
        //2-
        let request = URLRequest(url: urlFinal)
        //3-
        let session = URLSession(configuration: .default)
        //4-
        let task = session.dataTask(with: request) { (data, response, error) in
            //6-
            guard let data = data else{
                return
            }
            do{
                /*
            let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String,Any>
            //print(result)
            let items = result["items"] as! [Dictionary<String,String>]
            let firstItem = items[0]
            let title = firstItem["title"]
            print(title ?? "No title")*/
                let result = try JSONDecoder().decode(T.self, from: data)
                //print(result.items[0].header ?? "No title")
                compilitionHandler(result)
                
            }catch let error{
                print(error.localizedDescription)
                compilitionHandler(nil)
            }
        }
        //5-
        task.resume()
        
    }
}
