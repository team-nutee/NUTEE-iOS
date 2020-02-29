//
//  FollowersService.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/02/27.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import Foundation
import Alamofire

struct FollowService {
    private init() {}
    
    static let shared = FollowService()
    
    //MARK: - Follower 목록 받아오기
    
    func getFollowersList(_ userId: String, completion: @escaping (NetworkResult<Any>) -> Void){

        let URL = APIConstants.BaseURL + "/api/user/" + userId + "/followers?offset=0&limit=3"
        // 'limit'는 가져올 followers의 개수
        let header: HTTPHeaders = [
//            "Content-Type" : "application/json",
            "Cookie" : UserDefaults.standard.string(forKey: "Cookie")!
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseData{ response in
            
            switch response.result {
                
            case .success:
                if let value = response.result.value {
                    print(value)
                    if let status = response.response?.statusCode{
                        print("getFollowersList method:", status)
                        print(URL)
                        switch status {
                        case 200:
                            do{
                                print("start decode getFollowersList")
                                let decoder = JSONDecoder()
                                let result = try decoder.decode(FollowList.self, from: value)
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
    
    //MARK: - Following 목록 받아오기
        
        func getFollowingsList(_ userId: String, completion: @escaping (NetworkResult<Any>) -> Void){

            let URL = APIConstants.BaseURL + "/api/user/" + userId + "/followings?offset=0&limit=10"
            // 'limit'는 가져올 followings의 개수
            let header: HTTPHeaders = [
    //            "Content-Type" : "application/json",
                "Cookie" : UserDefaults.standard.string(forKey: "Cookie")!
            ]
            
            Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseData{ response in
                
                switch response.result {
                    
                case .success:
                    if let value = response.result.value {
                        print(value)
                        if let status = response.response?.statusCode{
                            print("getFollowingsList method:", status)
                            print(URL)
                            switch status {
                            case 200:
                                do{
                                    print("start decode getFollowingsList")
                                    let decoder = JSONDecoder()
                                    let result = try decoder.decode(FollowList.self, from: value)
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
