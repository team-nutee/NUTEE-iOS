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
        
        signInBtn.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        
    }
    
    
    // MARK: -Helpers

    // 초기 설정
    func setInit() {
        
        idView.layer.addBorder([.bottom], color: UIColor.pantoneGreen2020, width: 1)
        pwView.layer.addBorder([.bottom], color: UIColor.pantoneGreen2020, width: 1)
        
        self.tabBarController?.tabBar.isHidden = true
        
        signInBtn.tintColor = .white
        signInBtn.backgroundColor = .pantoneGreen2020
        signInBtn.setRounded(radius: 10)
        signUpBtn.tintColor = .white
        signUpBtn.backgroundColor = .pantoneGreen2020
        signUpBtn.setRounded(radius: 10)
        findIdBtn.tintColor = .white
        findIdBtn.backgroundColor = .pantoneGreen2020
        findIdBtn.setRounded(radius: 10)
        findPwBtn.tintColor = .white
        findPwBtn.backgroundColor = .pantoneGreen2020
        findPwBtn.setRounded(radius: 10)

    }
    
    func setDefault() {
        
    }
    
    @objc func signIn() {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "TBC") as! TBC
        vc.modalPresentationStyle = .fullScreen
        
        self.dismiss(animated: false, completion: nil)
        
        self.present(vc, animated: true)
    }
        
}

extension LoginVC : UITextFieldDelegate {
    
    
}
