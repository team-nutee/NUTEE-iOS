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
    @IBOutlet weak var certificationBtn: UIButton!
    @IBOutlet weak var pwChangeBtn: UIButton!
    @IBOutlet weak var pwGuideLabel: UILabel!
    @IBOutlet weak var pwGuideLabel2: UILabel!
    @IBOutlet weak var pwCertificationTextField: UITextField!
    @IBOutlet weak var pwChangeTextField: UITextField!
    @IBOutlet weak var pwChangeTextField2: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInit()
        logoutBtn.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }
    
    
    func setInit() {
        logoutBtn.tintColor = .nuteeGreen
        certificationBtn.tintColor = .nuteeGreen
        pwChangeBtn.tintColor = .nuteeGreen
        
        pwCertificationTextField.addBorder(.bottom, color: .nuteeGreen, thickness: 1)
        pwChangeTextField.addBorder(.bottom, color: .nuteeGreen, thickness: 1)
        pwChangeTextField2.addBorder(.bottom, color: .nuteeGreen, thickness: 1)
        
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
                UserDefaults.standard.removeObject(forKey: "userId")
                UserDefaults.standard.removeObject(forKey: "pw")
//                print(UserDefaults.standard.value(forKey: "Cookie") ?? "삭제 된 상태입니다")
                print(response)
                self.dismiss(animated: true, completion: ProfileVC.viewDidLoad(.init()))
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
