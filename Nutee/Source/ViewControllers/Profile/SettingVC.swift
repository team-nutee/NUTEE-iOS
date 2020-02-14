//
//  SettingVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/09.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {

    @IBOutlet weak var logoutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        logoutBtn.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }
    
    
    @objc func logout(){
        signOutService()
    }
}

extension SettingVC {
    func signOutService() {
        UserService.shared.signOut() { responsedata in
            
            switch responsedata {
                
            // NetworkResult 의 요소들
            case .success(let res):
                let response = res as! String

                UserDefaults.standard.removeObject(forKey: "Cookie")
                print(UserDefaults.standard.value(forKey: "Cookie") ?? "삭제 된 상태입니다")
                print(response)
                self.dismiss(animated: true, completion: nil)
            //                self.successAdd = true
            case .requestErr(_):
                print("request error")
            //                self.successAdd = false
            case .pathErr:
                print(".pathErr")
            //                self.successAdd = false
            case .serverErr:
                print(".serverErr")
            //                self.successAdd = false
            case .networkFail :
                print("failure")
                //                self.successAdd = false
            }
        }
        
    }

}
