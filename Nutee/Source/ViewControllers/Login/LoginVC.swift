//
//  LoginVC.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/01/14.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    // MARK: - UI components
    @IBOutlet weak var idView: UIView!
    @IBOutlet weak var pwView: UIView!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var findIdBtn: UIButton!
    @IBOutlet weak var findPwBtn: UIButton!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var quitBtn: UIButton!
    
    // MARK: - Variables and Properties
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setInit()
        
        quitBtn.addTarget(self, action: #selector(quit), for: .touchUpInside)
        
    }
    
    
    // MARK: -Helpers

    // 초기 설정
    func setInit() {
        
        idView.layer.addBorder([.bottom], color: UIColor.nuteeGreen, width: 1)
        pwView.layer.addBorder([.bottom], color: UIColor.nuteeGreen, width: 1)
        
        signInBtn.tintColor = .white
        signInBtn.backgroundColor = .nuteeGreen
        signInBtn.setRounded(radius: 10)
        signUpBtn.tintColor = .white
        signUpBtn.backgroundColor = .nuteeGreen
        signUpBtn.setRounded(radius: 10)
        findIdBtn.tintColor = .white
        findIdBtn.backgroundColor = .nuteeGreen
        findIdBtn.setRounded(radius: 10)
        findPwBtn.tintColor = .white
        findPwBtn.backgroundColor = .nuteeGreen
        findPwBtn.setRounded(radius: 10)

    }
    
    func setDefault() {
        
    }
    
    @objc func quit() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension LoginVC {
    
}
