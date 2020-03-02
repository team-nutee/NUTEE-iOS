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
    
    //MARK: - 게시글(Post) 받아오기
    
    // NewsFeed에 있는 게시글들(posts) 가져오기
    func getNewsPosts(_ postCnt: Int, completion: @escaping (NetworkResult<Any>) -> Void){
         let URL = APIConstants.Posts + "?offset=0&limit=" + "\(postCnt)"
            let header: HTTPHeaders = [
                "Cookie" : UserDefaults.standard.string(forKey: "Cookie")!
            ]
            
            Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseData{ response in
                
                switch response.result {
                    
                case .success:
                    if let value = response.result.value {
                        
                        if let status = response.response?.statusCode{
                            print("getNewsPosts method:", status)
                            print(URL)
                            switch status {
                            case 200:
                                    do{
                                        print("start decode getNewsPosts")
                                        let decoder = JSONDecoder()
                                        let result = try decoder.decode(NewsPostsContent.self, from: value)
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
    
    // 게시글(post) 하나 가져오기
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
    
    // Profile에 있는 사용자 게시글들(UserPosts) 가져오기
    func getUserPosts(_ userId: Int, completion: @escaping (NetworkResult<Any>) -> Void){
         let URL = APIConstants.UserPost + "/\(userId)" + "/posts"
            let header: HTTPHeaders = [
                "Cookie" : UserDefaults.standard.string(forKey: "Cookie")!
            ]
            
            Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseData{ response in
                
                switch response.result {
                    
                case .success:
                    if let value = response.result.value {
                        
                        if let status = response.response?.statusCode{
                            print("getUserPosts method:", status)
                            print(URL)
                            switch status {
                            case 200:
                                    do{
                                        print("start decode getUserPosts")
                                        let decoder = JSONDecoder()
                                        let result = try decoder.decode(UserPostContent.self, from: value)
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
