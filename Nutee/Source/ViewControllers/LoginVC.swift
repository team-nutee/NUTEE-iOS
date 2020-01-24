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
    
    // MARK: - Variables and Properties
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setInit()
    }
    
    // MARK: -Helpers

    // 초기 설정
    func setInit() {
        idView.layer.addBorder([.bottom], color: UIColor.nuteeGreen, width: 1)
        pwView.layer.addBorder([.bottom], color: UIColor.nuteeGreen, width: 1)
        
        signInBtn.tintColor = UIColor.black
        signUpBtn.tintColor = UIColor.black
        findIdBtn.tintColor = UIColor.black
        findPwBtn.tintColor = UIColor.black
    }
    
    func setDefault() {

    }
    

    
}
