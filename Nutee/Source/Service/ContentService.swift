//
//  ContentService.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/02/24.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import Foundation
import Alamofire

struct ContentService {
    private init() {}
    
    static let shared = ContentService()
    
    //MARK: - Post(게시글) 하나 받아오기
    
    func getPost(_ postId: Int, completion: @escaping (NetworkResult<Any>) -> Void){
     let URL = APIConstants.BaseURL + "/api/post/" + String(postId)
        let header: HTTPHeaders = [
//            "Content-Type" : "application/json",
            "Cookie" : UserDefaults.standard.string(forKey: "Cookie")!
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseData{ response in
            
            switch response.result {
                
            case .success:
                if let value = response.result.value {
                    
                    if let status = response.response?.statusCode{
                        print("getPost method:", status)
                        print(URL)
                        switch status {
                        case 200:
                                do{
                                    print("start decode getPost")
                                    let decoder = JSONDecoder()
                                    let result = try decoder.decode(PostContent.self, from: value)
                                    completion(.success(result))
                                } catch {
                                    completion(.pathErr)
                                }
                            case 409:
                                print("실패 409")
                                completion(.pathErr)
                            case 500:
                                print("실패 500")
                                completion(.serverErr)
                            default:
                                break
                        }
                    }
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)

            }
            
        }
        
    }
    
}
