//
//  LoginVC.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/01/14.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit
import Alamofire

class LoginVC: UIViewController {
    
    // MARK: - UI components    
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var findBtn: UIButton!
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var centerYLayoutConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var autoSignUpBtn: UIButton!
    @IBOutlet weak var autoSignUpBtn2: UIButton!
    
    @IBOutlet weak var idErrorLabel: UILabel!
    @IBOutlet weak var pwErrorLabel: UILabel!
    
    // MARK: - Variables and Properties
    
    var signin : SignIn?
    var autoSignUp : Bool = false
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("로그인 확인 : ",UserDefaults.standard.value(forKey: "Cookie") ?? "로그인 안함")
        checkSignIn()
        
        setInit()
        
        signInBtn.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        signUpBtn.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        findBtn.addTarget(self, action: #selector(find), for: .touchUpInside)
        
        animate()
        
        navigationController?.navigationBar.isHidden = true
    }
    
    
    // MARK: -Helpers
    
    // 초기 설정
    func setInit() {
        
        signInBtn.backgroundColor = .veryLightPink
        signInBtn.isEnabled = false
        idTextField.tintColor = .nuteeGreen
        pwTextField.tintColor = .nuteeGreen
        idTextField.addBorder(.bottom, color: .nuteeGreen, thickness: 1)
        pwTextField.addBorder(.bottom, color: .nuteeGreen, thickness: 1)
        
        self.tabBarController?.tabBar.isHidden = true
        autoSignUpBtn.tintColor = .nuteeGreen
        autoSignUpBtn.titleLabel?.textColor = .nuteeGreen
        autoSignUpBtn.setRounded(radius: nil)
        autoSignUpBtn.borderWidth = 1
        autoSignUpBtn.borderColor = .nuteeGreen
        autoSignUpBtn2.tintColor = .nuteeGreen
        autoSignUpBtn2.titleLabel?.textColor = .nuteeGreen
        pwErrorLabel.alpha = 0
        idErrorLabel.alpha = 0
        
        signInBtn.tintColor = .white
        signInBtn.setRounded(radius: 10)
        signUpBtn.tintColor = .nuteeGreen
        findBtn.tintColor = .nuteeGreen
        
        idTextField.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        pwTextField.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        autoSignUpBtn.addTarget(self, action: #selector(autoSignUpBt), for: .touchUpInside)
        autoSignUpBtn2.addTarget(self, action: #selector(autoSignUpBt), for: .touchUpInside)
        
        logoLabel.textColor = .nuteeGreen
        logoLabel.alpha = 0
    }
    
    func setDefault() {
        
    }
    
    func checkSignIn(){
        let userid = UserDefaults.standard.value(forKey: "userId")
        let password = UserDefaults.standard.value(forKey: "pw")
        
        if userid != nil && password != nil {
            signInService(userid as! String, password as! String)
        } else {
            return
        }
    }
    
    func toMain() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "TBC") as! TBC
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true)
    }
    
    @objc func signIn() {
        LoadingHUD.show()
        
        print("id :",idTextField.text!)
        print("pw :",pwTextField.text!)
        if autoSignUp == true {
            UserDefaults.standard.setValue(idTextField.text, forKey: "userId")
            UserDefaults.standard.setValue(pwTextField.text, forKey: "pw")
        }
        print("id userdefault : ", (UserDefaults.standard.value(forKey: "userId")) ?? "")
        print("pw userdefault : ", (UserDefaults.standard.value(forKey: "pw")) ?? "")
        
        signInService(idTextField.text!, pwTextField.text!)
        
        signInBtn.backgroundColor = .veryLightPink
        signInBtn.isEnabled = false
        idTextField.text = ""
        pwTextField.text = ""
    }
    
    @objc func signUp() {
        
        let sb = UIStoryboard(name: "SignUp", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "EmailVC") as! EmailVC
        vc.modalPresentationStyle = .fullScreen
        
//        self.navigationController?.pushViewController(vc, animated: false)
        self.present(vc, animated: false)
    }
    
    @objc func find() {
        
        let sb = UIStoryboard(name: "Find", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "FindVC") as! FindVC
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true)
    }
    
    
    @objc func autoSignUpBt() {
        if autoSignUp == false {
            autoSignUp = true
            autoSignUpBtn.backgroundColor = .nuteeGreen
            
        } else {
            autoSignUp = false
            autoSignUpBtn.backgroundColor = nil
            
        }
    }
    
}

extension LoginVC : UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if idTextField.text != "" && pwTextField.text != "" {
            signInBtn.backgroundColor = .nuteeGreen
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

extension LoginVC {
    private func animate(){
        UIView.animate(withDuration: 3,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 1,
                       options: [.curveEaseIn],
                       animations: {
                        // self를 항상 붙여줘야함 (클로저 안에서)
                        self.logoLabel.alpha = 1
        })
    }
    
    private func errorAnimate(){
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       usingSpringWithDamping: 0.1,
                       initialSpringVelocity: 0.1,
                       options: [.curveEaseIn],
                       animations: {
                        // self를 항상 붙여줘야함 (클로저 안에서)
                        //                        self.idTextField.transform = CGAffineTransform.init(translationX: -2, y: 0)
                        //                        self.pwTextField.transform = CGAffineTransform.init(translationX: -2, y: 0)
                        self.idErrorLabel.transform = CGAffineTransform.init(translationX: -5, y: 0)
                        self.pwErrorLabel.transform = CGAffineTransform.init(translationX: -5, y: 0)
                        self.idErrorLabel.alpha = 1
                        self.pwErrorLabel.alpha = 1
        })
        UIView.animate(withDuration: 0.2,
                       delay: 0.2,
                       usingSpringWithDamping: 0.1,
                       initialSpringVelocity: 0.1,
                       options: [.curveEaseIn],
                       animations: {
                        // self를 항상 붙여줘야함 (클로저 안에서)
                        //                        self.idTextField.transform = CGAffineTransform.init(translationX: 2, y: 0)
                        //                        self.pwTextField.transform = CGAffineTransform.init(translationX: 2, y: 0)
                        self.idErrorLabel.transform = CGAffineTransform.init(translationX: 5, y: 0)
                        self.pwErrorLabel.transform = CGAffineTransform.init(translationX: 5, y: 0)
        })
        
    }
}

// MARK: - server service

extension LoginVC {
    func error(){
        
        self.idTextField.addBorder(.bottom, color: .red, thickness: 1)
        self.pwTextField.addBorder(.bottom, color: .red, thickness: 1)
        self.idErrorLabel.text = "아이디 혹은 비밀번호가 다릅니다"
        self.pwErrorLabel.text = "아이디 혹은 비밀번호가 다릅니다"
        self.idErrorLabel.sizeToFit()
        self.pwErrorLabel.sizeToFit()
        self.errorAnimate()
    }
    
    func signInService(_ userId: String, _ password: String) {
        UserService.shared.signIn(userId, password) { responsedata in
            
            switch responsedata {
                
            // NetworkResult 의 요소들
            case .success(_):
                
                LoadingHUD.hide()
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "TBC") as! TBC
                vc.modalPresentationStyle = .fullScreen
                
                self.present(vc, animated: true)
                
            //                self.successAdd = true
            case .requestErr(_):
                LoadingHUD.hide()
                self.error()
                print("request error")
            //                self.successAdd = false
            case .pathErr:
                LoadingHUD.hide()
                self.error()
                print(".pathErr")
                
            //                self.successAdd = false
            case .serverErr:
                LoadingHUD.hide()
                self.error()
                print(".serverErr")
            //                self.successAdd = false
            case .networkFail :
                LoadingHUD.hide()
                self.error()
                print("failure")
                //                self.successAdd = false
            }
        }
        
    }
    
    
}
