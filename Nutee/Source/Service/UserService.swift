//
//  UserService.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/13.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import Foundation
import Alamofire

struct UserService {
    
    private init() {}
    
    static let shared = UserService()
    
    // MARK: - 회원가입
    
    func signUp(_ userId: String, _ password: String, _ nickname: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.UserPost
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
        ]
        
        let body : Parameters = [
            "userId" : userId,
            "password" : password,
            "nickname" : nickname
        ]
        
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseData{
            response in
            
            switch response.result {
                
            case .success:
                // parameter 위치
                if let value = response.result.value {
                    //print("response", )
                    print("value", value)
                    //response의 respones안에 있는 statusCode를 추출
                    if let status = response.response?.statusCode {
                        print(status)
                        switch status {
                        case 200:
                            do{
                                print("start decode")
                                let decoder = JSONDecoder()
                                let result = try decoder.decode(SignUp.self, from: value)
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
                break
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
            }
        }
    }
    
    
    // MARK: - sign in
    
    func signIn(_ userId: String, _ password: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.Login
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        let body : Parameters = [
            "userId" : userId,
            "password" : password
        ]
        
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseData{
            response in
            
            switch response.result {
                
            case .success:
                // parameter 위치
                if let value = response.result.value {
                    //print("response", )
                    //response의 respones안에 있는 statusCode를 추출
                    if let status = response.response?.statusCode {
                        print(status)
                        switch status {
                        case 200:
                            do{
                                let headerFields = response.response?.allHeaderFields as? [String: String]
                                var cookie : String? = headerFields!["Set-Cookie"]
                                var cookies : [String]? = []
                                cookies = cookie?.components(separatedBy: ";")
                                cookie = cookies?[0]
                                UserDefaults.standard.set(cookie, forKey: "Cookie")
                                print(UserDefaults.standard.string(forKey: "Cookie"))
                                
                                let decoder = JSONDecoder()
                                let result = try decoder.decode(SignIn.self, from: value)
                                completion(.success(result))
                            } catch {
                                completion(.pathErr)
                            }
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
                }
                break
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
            }
        }
    }
    
    // MARK: - logout
    
    func signOut(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.Logout
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Cookie" : UserDefaults.standard.string(forKey: "Cookie")!
        ]
        
        Alamofire.request(URL, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseData{
            response in
            
            switch response.result {
                
            case .success:
                    if let status = response.response?.statusCode {
                        print(status)
                        switch status {
                        case 200:
                            completion(.success("로그아웃 성공"))
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
                break
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
            }
        }
    }

    func getUserInfo(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.User
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Cookie" : UserDefaults.standard.string(forKey: "Cookie")!
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseData{
            response in
            
            switch response.result {
                
            case .success:
                // parameter 위치
                if let value = response.result.value {
                    //print("response", )
                    //response의 respones안에 있는 statusCode를 추출
                    if let status = response.response?.statusCode {
                        print(status)
                        switch status {
                        case 200:
                            do{
                                print("start decode")
                                let decoder = JSONDecoder()
                                let result = try decoder.decode(SignIn.self, from: value)
                                completion(.success(result))
                            } catch {
                                completion(.pathErr)
                            }
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
                }
                break
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
            }
        }
    }


}
