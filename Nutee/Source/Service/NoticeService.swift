//
//  NoticeService.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/14.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import Foundation
import Alamofire

struct NoticeService {
    
    private init() {}
    
    static let shared = NoticeService()
    
    func getBachelorNotice(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = "http://nutee.kr:9709/crawl/haksa"
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
        ]
        
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseData{
            response in
            
            switch response.result {
                
            case .success:
                // parameter 위치
                if let value = response.result.value {
                    //response의 respones안에 있는 statusCode를 추출
                    if let status = response.response?.statusCode {
                        switch status {
                        case 200:
                            do{
                                let decoder = JSONDecoder()
                                let result = try
                                    decoder.decode(Notice.self, from: value)
                                
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
    
    
    func getClassNotice(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = "http://nutee.kr:9709/crawl/sooup"
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
        ]
        
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseData{
            response in
            
            switch response.result {
                
            case .success:
                // parameter 위치
                if let value = response.result.value {
                    //response의 respones안에 있는 statusCode를 추출
                    if let status = response.response?.statusCode {
                        switch status {
                        case 200:
                            do{
                                let decoder = JSONDecoder()
                                let result = try
                                    decoder.decode(Notice.self, from: value)
                                
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
    
    
    func getExchangeNotice(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = "http://nutee.kr:9709/crawl/hakjum"
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
        ]
        
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseData{
            response in
            
            switch response.result {
                
            case .success:
                // parameter 위치
                if let value = response.result.value {
                    //response의 respones안에 있는 statusCode를 추출
                    if let status = response.response?.statusCode {
                        switch status {
                        case 200:
                            do{
                                let decoder = JSONDecoder()
                                let result = try
                                    decoder.decode(Notice.self, from: value)
                                
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
    
    
    func getScholarshipNotice(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = "http://nutee.kr:9709/crawl/janghak"
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
        ]
        
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseData{
            response in
            
            switch response.result {
                
            case .success:
                // parameter 위치
                if let value = response.result.value {
                    //response의 respones안에 있는 statusCode를 추출
                    if let status = response.response?.statusCode {
                        switch status {
                        case 200:
                            do{
                                let decoder = JSONDecoder()
                                let result = try
                                    decoder.decode(Notice.self, from: value)
                                
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
    
    
    func getGeneralNotice(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = "http://nutee.kr:9709/crawl/ilban"
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
        ]
        
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseData{
            response in
            
            switch response.result {
                
            case .success:
                // parameter 위치
                if let value = response.result.value {
                    //response의 respones안에 있는 statusCode를 추출
                    if let status = response.response?.statusCode {
                        switch status {
                        case 200:
                            do{
                                let decoder = JSONDecoder()
                                let result = try
                                    decoder.decode(Notice.self, from: value)
                                
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
    
    
    func getEventNotice(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = "http://nutee.kr:9709/crawl/hangsa"
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
        ]
        
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseData{
            response in
            
            switch response.result {
                
            case .success:
                // parameter 위치
                if let value = response.result.value {
                    //response의 respones안에 있는 statusCode를 추출
                    if let status = response.response?.statusCode {
                        switch status {
                        case 200:
                            do{
                                let decoder = JSONDecoder()
                                let result = try
                                    decoder.decode(Notice.self, from: value)
                                
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
    func getNotice(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = "http://nutee.kr:9709/crawl/haksa"
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
        ]
        
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseData{
            response in
            
            switch response.result {
                
            case .success:
                // parameter 위치
                if let value = response.result.value {
                    //response의 respones안에 있는 statusCode를 추출
                    if let status = response.response?.statusCode {
                        switch status {
                        case 200:
                            do{
                                let decoder = JSONDecoder()
                                let result = try
                                    decoder.decode(Notice.self, from: value)
                                
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

}
