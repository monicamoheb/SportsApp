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
     func loadData<T: Decodable>(url:String,compilitionHandler: @escaping (MyResponse<T>?, Error?) -> Void)
}
class NetworkManager : NetworkService{
    
     func loadData<T: Decodable>(url:String ,compilitionHandler: @escaping (MyResponse<T>?, Error?) -> Void){
        AF.request(url).responseDecodable(of: T.self){ response in
            debugPrint(response)

            guard response.data != nil else{
                compilitionHandler(nil , response.error)
                return
            }
            do{
                let result = try JSONDecoder().decode(MyResponse<T>.self, from: response.data ?? Data())
                compilitionHandler(result,nil)

            }catch let error{
                print(error.localizedDescription)
                compilitionHandler(nil,error)
            }
        }
        
    }
}
