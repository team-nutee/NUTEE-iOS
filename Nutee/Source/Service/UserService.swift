//
//  UserService.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/13.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper

struct UserService {
    
    private init() {}
    
    static let shared = UserService()
    
    // MARK: - 회원가입
    
    func signUp(_ userId: String, _ password: String, _ nickname: String, _ email: String , completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.UserPost
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
        ]
        
        let body : Parameters = [
            "userId" : userId,
            "password" : password,
            "nickname" : nickname,
            "schoolEmail" : email
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
                                print("start decode SignUp")
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
                                print(cookie)
                                KeychainWrapper.standard.set(cookie ?? "", forKey: "Cookie")
                                
                                let decoder = JSONDecoder()
                                let result = try decoder.decode(SignIn.self, from: value)
                                // 로그인시 id 저장
                                KeychainWrapper.standard.set(result.id, forKey: "id")
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
            "Cookie" : KeychainWrapper.standard.string(forKey: "Cookie")!
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
    
    // MARK: - 사용자의 정보 가져오기
    
    // 로그인 한 사용자의 경우
    func getLoginUserInfo(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.User
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Cookie" : KeychainWrapper.standard.string(forKey: "Cookie")!
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseData{
            response in
            
            switch response.result {
                
            case .success:
                // parameter 위치
                if let value = response.result.value {
                    print(value)
                    //response의 respones안에 있는 statusCode를 추출
                    if let status = response.response?.statusCode {
                        print("getLoginUserInfo method:", status)
                        switch status {
                        case 200:
                            do{
                                print("start decode getLoginUserInfo")
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
    
    // 다른 사용자의 경우
    func getUserInfo(userId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.User + "/\(userId)"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseData{
            response in
            
            switch response.result {
                
            case .success:
                // parameter 위치
                if let value = response.result.value {
                    print(value)
                    //response의 respones안에 있는 statusCode를 추출
                    if let status = response.response?.statusCode {
                        print("getUserInfo method:", status)
                        switch status {
                        case 200:
                            do{
                                print("start decode getUserInfo")
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
    
    // MARK: - sendOTP
    func sendOTP(_ email : String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.OTPsend
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        let body : Parameters = [
            "schoolEmail" : email
        ]
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseData{
            response in
            
            switch response.result {
                
            case .success:
                if let status = response.response?.statusCode {
                    print(status)
                    switch status {
                    case 200:
                        completion(.success("otp send"))
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
    
    // MARK: - checkOTP
    
    func checkOTP(_ otpNumber : String, completion: @escaping (NetworkResult<Any>) -> Void){
        let URL = APIConstants.OTPcheck
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        let body : Parameters = [
            "otpcheck" : otpNumber
        ]
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseData{
            response in
            
            switch response.result {
                
            case .success:
                if let status = response.response?.statusCode {
                    print(status)
                    switch status {
                    case 200:
                        completion(.success("otp checked"))
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
    
    // MARK: - findID
    func findID(_ email : String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.FindId
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        let body : Parameters = [
            "schoolEmail" : email
        ]
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseData{
            response in
            
            switch response.result {
                
            case .success:
                if let status = response.response?.statusCode {
                    print(status)
                    switch status {
                    case 200:
                        completion(.success("입력하신 이메일로 아이디가 발송되었습니다."))
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
    
    // MARK: - findPW
    
    func findPW(_ userId : String, _ email : String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.Reissuance
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        let body : Parameters = [
            "userId" : userId,
            "schoolEmail" : email
        ]
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseData{
            response in
            
            switch response.result {
                
            case .success:
                if let status = response.response?.statusCode {
                    print(status)
                    switch status {
                    case 200:
                        completion(.success("입력하신 이메일로 아이디가 발송되었습니다."))
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

    // MARK: - 사용자 닉네임 변경
    
    func chageNickname(_ changedNickname : String, completion: @escaping (NetworkResult<Any>) -> Void){
        let URL = APIConstants.NickNamePatch
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Cookie" : KeychainWrapper.standard.string(forKey: "Cookie")!
        ]
        
        let body : Parameters = [
            "nickname" : changedNickname
        ]
        
        Alamofire.request(URL, method: .patch, parameters: body, encoding: JSONEncoding.default, headers: headers).responseData{
            response in
            
            switch response.result {
                
            case .success:
                if let status = response.response?.statusCode {
                    print("changeNickname method:", status)
                    switch status {
                    case 200:
                        completion(.success("nickname chnaged"))
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

    // MARK: - 사용자 프로필 이미지 변경
    
    func changeProfileImage(_ image : [UIImage], completion: @escaping (NetworkResult<Any>) -> Void){
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Cookie" : KeychainWrapper.standard.string(forKey: "Cookie")!
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for img in image {
                if let imageData = img.jpegData(compressionQuality: 0.2) {
                    multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpg")
                }
            }
        }, to: APIConstants.ProfileImagePost, method: .post, headers: headers) { (encodingResult) in
            
            switch encodingResult {
                
            case .success(let upload, _, _):
                upload.responseJSON { (response) in
                    
                    print("changeProfileImage method success")
                    completion(.success(response.result.value as Any))
                }
            case .failure(let encodingError):
                print("changeProfileImage-> ", encodingError.localizedDescription)
            }
        }
    }

    
}
