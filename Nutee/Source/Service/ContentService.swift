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
    func getNewsPosts(_ postCnt: Int, lastId: Int, completion: @escaping (NetworkResult<Any>) -> Void){
         let URL = APIConstants.Posts + "?lastId=" + "\(lastId)" + "&limit=" + "\(postCnt)"
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
    
    // Posting
    func uploadPost(pictures: String, postContent: String, completion: @escaping(NetworkResult<Any>)->Void) {
        
        let headers: HTTPHeaders = [
            "Content-Type": "multipart/form-data",
            "Cookie" : UserDefaults.standard.string(forKey: "Cookie")!
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
//            multipartFormData.append(pictures, withName: "image")
            if let picturesURL = URL(string: pictures){
                dump(picturesURL as URL)
                multipartFormData.append(picturesURL as URL, withName: "image")
            }
            dump(postContent)
            multipartFormData.append(postContent.data(using: .utf8) ?? Data(), withName: "content")

        }, to: APIConstants.PostPost, method: .post, headers: headers) { (encodingResult) in
                        
            switch encodingResult {
                
            case .success(let upload, _, _):
                upload.responseJSON { (response) in
                    print("service 성공")
                    let json = response.result.value
                    dump(json)
                    completion(.success(response.data))
                }
            case .failure(let encodingError):
                print(encodingError.localizedDescription + "[[[[")
            }
        }
    }

    func uploadImage(pictures: [UIImage], completion: @escaping(NetworkResult<Any>)->Void) {
        
        let headers: HTTPHeaders = [
            "Content-Type": "multipart/form-data",
            "Cookie" : UserDefaults.standard.string(forKey: "Cookie")!
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for image in pictures {
                if let imageData = image.jpegData(compressionQuality: 0.2) {
                    print(imageData)
                    multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpg")

                }
            }
        }, to: APIConstants.image, method: .post, headers: headers) { (encodingResult) in
                        
            switch encodingResult {
                
            case .success(let upload, _, _):
                upload.responseJSON { (response) in
                    print("service 성공")
                    completion(.success(response.data))
                }
            case .failure(let encodingError):
                print(encodingError.localizedDescription + "[[[[")
            }
        }
    }

}
