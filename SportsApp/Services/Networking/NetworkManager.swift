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
     func loadData<T: Decodable>(url:String,compilitionHandler: @escaping (Welcome<T>?) -> Void)
}
class NetworkManager : NetworkService{
    
     func loadData<T: Decodable>(url:String ,compilitionHandler: @escaping (Welcome<T>?) -> Void){
        AF.request(url).responseDecodable(of: T.self){ response in
            debugPrint(response)
            guard response.data != nil else{
                return
            }
            do{
                let result = try JSONDecoder().decode(Welcome<T>.self, from: response.data ?? Data())
                compilitionHandler(result)
                
            }catch let error{
                print(error.localizedDescription)
                compilitionHandler(nil)
            }
        }
        
    }
}
