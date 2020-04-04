//
//  ContentService.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/02/24.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper

struct ContentService {
    private init() {}
    
    static let shared = ContentService()
    
    //MARK: - 게시글(Post) 받아오기
    
    // NewsFeed에 있는 게시글들(posts) 가져오기
    func getNewsPosts(_ postCnt: Int, lastId: Int, completion: @escaping (NetworkResult<Any>) -> Void){
        let URL = APIConstants.Posts + "?lastId=" + "\(lastId)" + "&limit=" + "\(postCnt)"
        let header: HTTPHeaders = [
            "Content-Type" : "application/json",
            "Cookie" : KeychainWrapper.standard.string(forKey: "Cookie") ?? ""
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseData{ response in
            
            switch response.result {
                
            case .success:
                if let value = response.result.value {
                    
                    if let status = response.response?.statusCode{                    
                        switch status {
                        case 200:
                            do{
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
            "Content-Type" : "application/json",
            "Cookie" : KeychainWrapper.standard.string(forKey: "Cookie")!
        ]
        
        print(URL)
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseData{ response in
            
            switch response.result {
                
            case .success:
                if let value = response.result.value {
                    
                    if let status = response.response?.statusCode{
                        switch status {
                        case 200:
                            do{
                                let decoder = JSONDecoder()
                                let result = try decoder.decode(NewsPostsContentElement.self, from: value)
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
            "Content-Type": "application/json",
            "Cookie" : KeychainWrapper.standard.string(forKey: "Cookie") ?? ""
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseData{ response in
            
            switch response.result {
                
            case .success:
                if let value = response.result.value {
                    
                    if let status = response.response?.statusCode{
                        switch status {
                        case 200:
                            do{
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
    func uploadPost(pictures: [NSString], postContent: String, completion: @escaping(NetworkResult<Any>)->Void) {
        
        let headers: HTTPHeaders = [
            "Content-Type": "multipart/form-data",
            "Cookie" : KeychainWrapper.standard.string(forKey: "Cookie") ?? ""
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            //            multipartFormData.append(pictures, withName: "image")
            for image in pictures {
                
                multipartFormData.append((image as String).data(using: .utf8) ?? Data() , withName: "image")
            }
            multipartFormData.append(postContent.data(using: .utf8) ?? Data(), withName: "content")
            
        }, to: APIConstants.PostPost, method: .post, headers: headers) { (encodingResult) in
            
            switch encodingResult {
                
            case .success(let upload, _, _):
                upload.responseJSON { (response) in
                    
                    completion(.success(response.data as Any))
                }
            case .failure(let encodingError):
                print(encodingError.localizedDescription)
            }
        }
    }
    
    func uploadImage(pictures: [UIImage], completion: @escaping(NetworkResult<Any>)->Void) {
        
        let headers: HTTPHeaders = [
            "Content-Type": "multipart/form-data",
            "Cookie" : KeychainWrapper.standard.string(forKey: "Cookie")!
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for image in pictures {
                if let imageData = image.jpegData(compressionQuality: 0.3) {
                    multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpg")
                }
            }
        }, to: APIConstants.image, method: .post, headers: headers) { (encodingResult) in
            
            switch encodingResult {
                
            case .success(let upload, _, _):
                upload.responseJSON { (response) in
                    
                    completion(.success(response.result.value as Any))
                }
            case .failure(let encodingError):
                print(encodingError.localizedDescription)
            }
        }
    }
    
    func editPost(_ postId: Int, _ content: String, _ images: [String], completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.PostPost
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Cookie" : KeychainWrapper.standard.string(forKey: "Cookie")!
        ]
        
        let body : Parameters = [
            "postId" : postId,
            "content" : content,
            "image" : images
        ]
        
        
        Alamofire.request(URL, method: .patch, parameters: body, encoding: JSONEncoding.default, headers: headers).responseData{
            response in
            
            switch response.result {
                
            case .success:
                
                if let status = response.response?.statusCode {
                    print(status)
                    
                    switch status {
                    case 200:
                        completion(.success("성공했습니다."))
                    case 401:
                        print("실패 401")
                        completion(.pathErr)
                    case 500:
                        print("실패 500")
                        completion(.serverErr)
                    default:
                        break
                    }
                }
                
                break
                
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
            }
        }
    }
    
    // MARK: - Report
    
    func reportPost(_ id: String, _ content: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.ReportPost + "/" + id + "/report"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Cookie" : KeychainWrapper.standard.string(forKey: "Cookie")!
        ]
        
        let body : Parameters = [
            "content" : content
        ]
        
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseData{
            response in
            
            switch response.result {
                
            case .success:
                
                if let status = response.response?.statusCode {
                    switch status {
                    case 200:
                        completion(.success("성공했습니다."))
                    case 401:
                        print("실패 401")
                        completion(.pathErr)
                    case 500:
                        print("실패 500")
                        completion(.serverErr)
                    default:
                        break
                    }
                }
                
                break
                
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
            }
        }
    }
    
    // MARK: - like
    
    func likePost(_ postId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.LikePost + "/\(postId)/like"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Cookie" : KeychainWrapper.standard.string(forKey: "Cookie")!
        ]
        
        Alamofire.request(URL, method: .post, encoding: JSONEncoding.default, headers: headers).responseData{
            response in
            
            switch response.result {
                
            case .success:
                
                if let status = response.response?.statusCode {
                    switch status {
                    case 200:
                        completion(.success("likePost에 성공했습니다."))
                    case 401:
                        print("실패 401")
                        completion(.pathErr)
                    case 500:
                        print("실패 500")
                        completion(.serverErr)
                    default:
                        break
                    }
                }
                
                break
                
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
            }
        }
    }
    
    func likeDelete(_ postId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.LikeDelete + "/\(postId)/like"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Cookie" : KeychainWrapper.standard.string(forKey: "Cookie")!
        ]
        
        Alamofire.request(URL, method: .delete, encoding: JSONEncoding.default, headers: headers).responseData{
            response in
            
            switch response.result {
                
            case .success:
                
                if let status = response.response?.statusCode {
                    switch status {
                    case 200:
                        completion(.success("likeDelete에 성공했습니다."))
                    case 401:
                        print("실패 401")
                        completion(.pathErr)
                    case 500:
                        print("실패 500")
                        completion(.serverErr)
                    default:
                        break
                    }
                }
                
                break
                
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
            }
        }
    }
    
    // MARK: - Retweet
    
    func retweetPost(_ postId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.Retweet + "/\(postId)/retweet"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Cookie" : KeychainWrapper.standard.string(forKey: "Cookie")!
        ]
        
        Alamofire.request(URL, method: .post, encoding: JSONEncoding.default, headers: headers).responseData{
            response in
            
            switch response.result {
                
            case .success:
                
                if let status = response.response?.statusCode {
                    switch status {
                    case 200:
                        completion(.success("retweetPost에 성공했습니다."))
                    case 401:
                        print("실패 401")
                        completion(.pathErr)
                    case 403:
                        completion(.requestErr("이미 공유했습니다."))
                    case 500:
                        print("실패 500")
                        completion(.serverErr)
                    default:
                        break
                    }
                }
                
                break
                
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
            }
        }
    }
    
    func retweetDelete(_ postId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.Retweet + "/\(postId)/retweet"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Cookie" : KeychainWrapper.standard.string(forKey: "Cookie")!
        ]
        
        Alamofire.request(URL, method: .delete, encoding: JSONEncoding.default, headers: headers).responseData{
            response in
            
            switch response.result {
                
            case .success:
                
                if let status = response.response?.statusCode {
                    switch status {
                    case 200:
                        completion(.success("retweetDelete에 성공했습니다."))
                    case 401:
                        print("실패 401")
                        completion(.pathErr)
                    case 404:
                        completion(.serverErr)
                    case 500:
                        print("실패 500")
                        completion(.serverErr)
                    default:
                        break
                    }
                }
                
                break
                
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
            }
        }
    }

    // MARK: - Comments
    
    func commentPost(_ postId: Int, comment: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.CommentsPost + "/\(postId)/comment"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Cookie" : KeychainWrapper.standard.string(forKey: "Cookie")!
        ]
        
        let body : Parameters = [
            "content" : comment
        ]
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseData{
            response in
            
            switch response.result {
                
            case .success:
                
                if let status = response.response?.statusCode {
                    switch status {
                    case 200:
                        completion(.success("commentPost에 성공했습니다."))
                    case 401:
                        print("실패 401")
                        completion(.pathErr)
                    case 500:
                        print("실패 500")
                        completion(.serverErr)
                    default:
                        break
                    }
                }
                
                break
                
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
            }
        }
    }
    
    func commentDelete(_ postId: Int, commentId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.CommentsDelete + "/\(postId)/comment/\(commentId)"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Cookie" : KeychainWrapper.standard.string(forKey: "Cookie")!
        ]
        
        Alamofire.request(URL, method: .delete, encoding: JSONEncoding.default, headers: headers).responseData{
            response in
            
            switch response.result {
                
            case .success:
                
                if let status = response.response?.statusCode {
                    switch status {
                    case 200:
                        completion(.success("commentDelete에 성공했습니다."))
                    case 401:
                        print("실패 401")
                        completion(.pathErr)
                    case 500:
                        print("실패 500")
                        completion(.serverErr)
                    default:
                        break
                    }
                }
                
                break
                
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
            }
        }
    }
    
    
    func searchPost(text: String, postCnt: Int, lastId: Int, completion: @escaping (NetworkResult<Any>) -> Void){
        let URL = APIConstants.Search + text + "?lastId=" + "\(lastId)" + "&limit=" + "\(postCnt)"
        let header: HTTPHeaders = [
            "Content-Type" : "application/json",
            "Cookie" : KeychainWrapper.standard.string(forKey: "Cookie")!
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseData{ response in
            
            switch response.result {
                
            case .success:
                if let value = response.result.value {
                    
                    if let status = response.response?.statusCode{
                        switch status {
                        case 200:
                            do{
                                let decoder = JSONDecoder()
                                let result = try decoder.decode(NewsPostsContentElement.self, from: value)
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
