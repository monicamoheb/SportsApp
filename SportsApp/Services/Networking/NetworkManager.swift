//
//  NetworkManager.swift
//  MVPDemo
//
//  Created by Iti on 5/17/23.
//  Copyright © 2023 Esraa. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkService{
    static func loadData<T: Decodable>(sportName: String, param:Parameters ,compilitionHandler: @escaping (T?) -> Void)
}
class NetworkManager : NetworkService{
    
    static func loadData<T: Decodable>(sportName: String, param:Parameters ,compilitionHandler: @escaping (T?) -> Void){
        AF.request("https://apiv2.allsportsapi.com/\(sportName)/",parameters: param).responseDecodable(of: T.self){ response in
            debugPrint(response)
            guard response.data != nil else{
                return
            }
            do{
                let result = try JSONDecoder().decode(T.self, from: response.data ?? Data())
                compilitionHandler(result)
                
            }catch let error{
                print(error.localizedDescription)
                compilitionHandler(nil)
            }
        }
        
    }
}
