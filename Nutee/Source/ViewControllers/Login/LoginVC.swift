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
    @IBOutlet weak var findBtn: UIButton!
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var centerYLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var pwIconBtn: UIButton!
   
    // MARK: - Variables and Properties
    
    var iconClick = true
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkSignIn()
        
        setInit()
        
        signInBtn.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        signUpBtn.addTarget(self, action: #selector(signUp), for: .touchUpInside)
//        addKeyboardNotification()
    }
    
    
    // MARK: -Helpers
    
    // 초기 설정
    func setInit() {
        
        signInBtn.backgroundColor = .veryLightPink
        signInBtn.isEnabled = false
        pwIconBtn.tintColor = .nuteeGreen
        idTextField.tintColor = .nuteeGreen
        pwTextField.tintColor = .nuteeGreen
        idTextField.layer.addBorder([.bottom], color: .pantoneGreen2020, width: 1)
        pwTextField.layer.addBorder([.bottom], color: .pantoneGreen2020, width: 1)
        
        self.tabBarController?.tabBar.isHidden = true
        

        signInBtn.tintColor = .white
        signInBtn.setRounded(radius: 10)
        signUpBtn.tintColor = .pantoneGreen2019
        signUpBtn.setRounded(radius: 10)
        findBtn.tintColor = .pantoneGreen2019
        findBtn.setRounded(radius: 10)
        
        idTextField.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        pwTextField.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
    }
    
    func setDefault() {
        
    }
    
    func checkSignIn(){
        if UserDefaults.standard.value(forKey: "cookie") != nil {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "TBC") as! TBC
            vc.modalPresentationStyle = .fullScreen
            
            self.dismiss(animated: false, completion: nil)
            
            self.present(vc, animated: true)
        } else {
            return
        }
    }
    
    @objc func signIn() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "TBC") as! TBC
        vc.modalPresentationStyle = .fullScreen
        
        UserDefaults.standard.setValue(idTextField.text, forKey: "cookie")
        
        
        
        self.dismiss(animated: false, completion: nil)
        
        self.present(vc, animated: true)
        
        signInBtn.backgroundColor = .veryLightPink
        signInBtn.isEnabled = false
        idTextField.text = ""
        pwTextField.text = ""
    }
    
    @objc func signUp() {
        
        let sb = UIStoryboard(name: "SignUp", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "EmailVC") as! EmailVC
        vc.modalPresentationStyle = .fullScreen
        
        self.dismiss(animated: false, completion: nil)
        
        self.present(vc, animated: true)
    }
    
    @IBAction func iconAction(sender: AnyObject) {
        if(iconClick == true) {
            pwTextField.isSecureTextEntry = false
        } else {
            pwTextField.isSecureTextEntry = true
//            pwTextField.clearsOnBeginEditing = false
        }

        iconClick = !iconClick
    }

    
}

extension LoginVC : UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if idTextField.text != "" && pwTextField.text?.validatePassword() ?? false {                    signInBtn.backgroundColor = .pantoneGreen2020
            signInBtn.isEnabled = true
        } else {
            signInBtn.backgroundColor = .veryLightPink
            signInBtn.isEnabled = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == idTextField {
            pwTextField.becomeFirstResponder()
        } else {
            pwTextField.resignFirstResponder()
        }
        return true
    }
    

}

