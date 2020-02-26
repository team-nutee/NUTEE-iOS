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
    
    //MARK: - 게시글 하나 받아오기
    
    func getPost(_ postId: String, completion: @escaping (NetworkResult<Any>) -> Void){
//        static let PostGET = BaseURL + "/api/post/:id"                              // GET 뒤에 아이디 값을 넣어야 함                 // 아이디가 게시물의 id?

        let URL = APIConstants.BaseURL + "/api/post/" + postId
        let header: HTTPHeaders = [
            "Content-Type" : "application/json",
            "Cookie" : UserDefaults.standard.string(forKey: "Cookie") as! String
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseData{ response in
            
            switch response.result {
                
            case .success:
                if let value = response.result.value {
                    
                    if let status = response.response?.statusCode{
                        switch status {
                        case 200:
                                do{
                                    print("start decode")
                                    let decoder = JSONDecoder()
                                    let result = try decoder.decode(DetailContent.self, from: value)
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
