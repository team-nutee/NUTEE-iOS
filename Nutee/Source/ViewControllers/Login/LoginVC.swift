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
        signUpBtn.addTarget(self, action: #selector(signUp), for: .touchUpInside)

    }
    
    
    // MARK: -Helpers

    // 초기 설정
    func setInit() {
        
        signInBtn.backgroundColor = .veryLightPink
        signInBtn.isEnabled = false
        
        idTextField.tintColor = .nuteeGreen
        pwTextField.tintColor = .nuteeGreen
        idTextField.layer.addBorder([.bottom], color: .pantoneGreen2020, width: 1)
        pwTextField.layer.addBorder([.bottom], color: .pantoneGreen2020, width: 1)
        
        self.tabBarController?.tabBar.isHidden = true
        
        signInBtn.tintColor = .white
//        signInBtn.backgroundColor = .pantoneGreen2020
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

        idTextField.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        pwTextField.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)


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
        
    
    @objc func signUp() {
        
        let sb = UIStoryboard(name: "SignUp", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        vc.modalPresentationStyle = .fullScreen
        
        self.dismiss(animated: false, completion: nil)
        
        self.present(vc, animated: true)
    }

}

extension LoginVC : UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if idTextField.text?.validateSkhuEmail() ?? false && pwTextField.text?.validatePassword() ?? false {                    signInBtn.backgroundColor = .pantoneGreen2020
            signInBtn.isEnabled = true
        } else {
            signInBtn.backgroundColor = .veryLightPink
            signInBtn.isEnabled = false
        }
    }
}
