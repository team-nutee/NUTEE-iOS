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
        
        UserDefaults.standard.removeObject(forKey: "cookie")
        print(UserDefaults.standard.value(forKey: "cookie") ?? "삭제 된 상태입니다")
        
        self.dismiss(animated: true, completion: nil)
    }
}
