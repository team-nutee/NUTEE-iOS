//
//  SettingVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/09.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

import SwiftKeychainWrapper

class SettingVC: UIViewController {

    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var certificationBtn: UIButton!
    @IBOutlet weak var pwChangeBtn: UIButton!
    @IBOutlet weak var pwGuideLabel: UILabel!
    @IBOutlet weak var pwGuideLabel2: UILabel!
    @IBOutlet weak var pwCertificationTextField: UITextField!
    @IBOutlet weak var pwChangeTextField: UITextField!
    @IBOutlet weak var pwChangeTextField2: UITextField!
    
    @IBOutlet weak var TermsBtn: UIButton!
    @IBOutlet weak var ourInfoBtn: UIButton!
    @IBOutlet weak var pwCertificationErrorLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var certificationErrorLabel: UILabel!

    var animationDuration: TimeInterval = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        setInit()
        alphaZero()

        certificationBtn.addTarget(self,
                                   action: #selector(checkPW),
                                   for: .touchUpInside)
        
        pwChangeBtn.addTarget(self,
                              action: #selector(changePW),
                              for: .touchUpInside)
        
        logoutBtn.addTarget(self,
                            action: #selector(logout),
                            for: .touchUpInside)
        
        pwCertificationTextField.addTarget(self,
                                           action: #selector(checkTextField),
                                           for: .editingChanged)
        
        pwChangeTextField.addTarget(self,
                                    action: #selector(textFieldDidChange(_:)),
                                    for: UIControl.Event.editingChanged)
        
        pwChangeTextField2.addTarget(self,
                                     action: #selector(textFieldDidChange(_:)),
                                     for: UIControl.Event.editingChanged)
        
        ourInfoBtn.addTarget(self,
                             action: #selector(goInfo),
                             for: .touchUpInside)
        
        TermsBtn.addTarget(self,
                                 action: #selector(tapServiceInfo),
                                 for: .touchUpInside)
    }
    
    
    @objc func checkTextField(){
        if pwCertificationTextField.text != "" {
            certificationBtn.isEnabled = true
        } else {
            certificationBtn.isEnabled = false
        }
    }
    
    @objc func pwCheckTextField(){

    }
    

    
    func setInit() {
        logoutBtn.tintColor = .nuteeGreen
        certificationBtn.tintColor = .nuteeGreen
        pwChangeBtn.tintColor = .nuteeGreen
        ourInfoBtn.tintColor = .nuteeGreen
        TermsBtn.tintColor = .nuteeGreen

        pwCertificationTextField.addBorder(.bottom, color: .nuteeGreen, thickness: 1)
        pwChangeTextField.addBorder(.bottom, color: .nuteeGreen, thickness: 1)
        pwChangeTextField2.addBorder(.bottom, color: .nuteeGreen, thickness: 1)
        
        pwCertificationTextField.tintColor = .nuteeGreen
        pwChangeTextField.tintColor = .nuteeGreen
        pwChangeTextField2.tintColor = .nuteeGreen
        
        certificationBtn.isEnabled = false
        pwChangeBtn.isEnabled = false
        
        pwCertificationTextField.delegate = self
        pwChangeTextField.delegate = self
        pwChangeTextField2.delegate = self
        
    }
    
    func alphaZero(){
        pwChangeBtn.alpha = 0
        pwGuideLabel2.alpha = 0
        pwChangeTextField.alpha = 0
        pwChangeTextField2.alpha = 0
        errorLabel.alpha = 0
        certificationErrorLabel.alpha = 0
        pwCertificationErrorLabel.alpha = 0
    }
    
    @objc func logout(){
        simpleAlertWithHandler(title: "로그아웃", msg: "하시겠습니까??") { (action) in
            LoadingHUD.show()
            self.signOutService()
        }
    }
    
    @objc func tapServiceInfo(){
        let vc = UIStoryboard.init(name: "SignUp",
                               bundle: Bundle.main).instantiateViewController(
                                withIdentifier: "TermsVC") as? TermsVC
        self.present(vc!, animated: true, completion: nil)
    }
    
    @objc func goInfo(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OurInfoVC") as! OurInfoVC
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}

extension SettingVC : UITextFieldDelegate {

    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if pwChangeTextField.text?.validatePassword() == false {
            errorLabel.text = "8자 이상의 영어 대문자, 소문자, 숫자가 포함된 비밀번호를 입력해주세요."
            if (errorLabel.alpha == 0){
                errorLabel.shake(duration: 0.3)
            }
            errorLabel.alpha = 1
            errorLabel.textColor = .red
            pwChangeTextField.addBorder(.bottom, color: .red, thickness: 1)
            pwChangeBtn.isEnabled = false
        } else if pwChangeTextField.text?.validatePassword() == true {
            errorLabel.alpha = 0
            pwChangeTextField.addBorder(.bottom, color: .nuteeGreen, thickness: 1)
            pwChangeBtn.isEnabled = false
        }
        
        if pwChangeTextField.text != pwChangeTextField2.text
            && pwChangeTextField2.text != "" {
            if (certificationErrorLabel.alpha == 0){
                certificationErrorLabel.shake(duration: 0.3)
            }
            certificationErrorLabel.text = "비밀번호를 확인해주세요."
            certificationErrorLabel.textColor = .red
            certificationErrorLabel.alpha = 1
            pwChangeTextField2.addBorder(.bottom, color: .red, thickness: 1)
            pwChangeTextField.addBorder(.bottom, color: .red, thickness: 1)
        } else if pwChangeTextField2.text != "" {
            certificationErrorLabel.alpha = 0
            pwChangeTextField2.addBorder(.bottom, color: .nuteeGreen, thickness: 1)
            pwChangeTextField.addBorder(.bottom, color: .nuteeGreen, thickness: 1)
            pwChangeBtn.isEnabled = true
        }
    }
    
}


extension SettingVC {
    func signOutService() {
        UserService.shared.signOut() { responsedata in
            
            switch responsedata {
                
            // NetworkResult 의 요소들
            case .success(let res):
                let response = res as! String
                LoadingHUD.hide()
                KeychainWrapper.standard.removeObject(forKey: "Cookie")
                KeychainWrapper.standard.removeObject(forKey: "id")
                KeychainWrapper.standard.removeObject(forKey: "userId")
                KeychainWrapper.standard.removeObject(forKey: "pw")
                self.dismiss(animated: true, completion: nil)
            //                self.successAdd = true
            case .requestErr(_):
                LoadingHUD.hide()
                self.simpleAlert(title: "로그아웃에", message: "실패했습니다.")
            //                self.successAdd = false
            case .pathErr:
                LoadingHUD.hide()
                self.simpleAlert(title: "로그아웃에", message: "실패했습니다.")
            //                self.successAdd = false
            case .serverErr:
                LoadingHUD.hide()
                self.simpleAlert(title: "로그아웃에", message: "실패했습니다.")
            //                self.successAdd = false
            case .networkFail :
                LoadingHUD.hide()
                self.simpleAlert(title: "로그아웃에", message: "실패했습니다.")
                //                self.successAdd = false
            }
        }
        
    }

    @objc func checkPW(){
        UserService.shared.checkPW(pwCertificationTextField.text!) { (responsedata) in
            switch responsedata {
                
            case .success(_):
                self.certificationAnimate()
                self.pwCertificationErrorLabel.alpha = 0
                self.pwCertificationTextField.addBorder(.bottom, color: .nuteeGreen, thickness: 1)

                
            case .requestErr(_):
                self.pwCertificationErrorLabel.alpha = 1
                self.pwCertificationErrorLabel.textColor = .red
                self.pwCertificationErrorLabel.shake(duration: 0.3)
                self.pwCertificationErrorLabel.text = "비밀번호가 잘못 입력되엇습니다."
                self.pwCertificationTextField.addBorder(.bottom, color: .red, thickness: 1)
                
            case .pathErr:
                self.pwCertificationErrorLabel.alpha = 1
                self.pwCertificationErrorLabel.textColor = .red
                self.pwCertificationErrorLabel.shake(duration: 0.3)
                self.pwCertificationErrorLabel.text = "비밀번호가 잘못 입력되엇습니다."
                self.pwCertificationTextField.addBorder(.bottom, color: .red, thickness: 1)

            case .serverErr:
                self.pwCertificationErrorLabel.alpha = 1
                self.pwCertificationErrorLabel.textColor = .red
                self.pwCertificationErrorLabel.shake(duration: 0.3)
                self.pwCertificationErrorLabel.text = "서버 요청이 실패했습니다."
                self.pwCertificationTextField.addBorder(.bottom, color: .red, thickness: 1)

            case .networkFail:
                self.pwCertificationErrorLabel.alpha = 1
                self.pwCertificationErrorLabel.textColor = .red
                self.pwCertificationErrorLabel.shake(duration: 0.3)
                self.pwCertificationErrorLabel.text = "서버 요청이 실패했습니다."
                self.pwCertificationTextField.addBorder(.bottom, color: .red, thickness: 1)
            }
        }
    }
    
    @objc func changePW(){
        UserService.shared.changePW(pwChangeTextField.text!) { (responsedata) in
            switch responsedata {
                
            case .success(_):
                self.simpleDismissAlert(title: "비밀번호 변경에 성공했습니다!!", msg: "다시 한번 로그인 해주세요!!") { (action) in
                                    
                    KeychainWrapper.standard.removeObject(forKey: "Cookie")
                    KeychainWrapper.standard.removeObject(forKey: "id")
                    KeychainWrapper.standard.removeObject(forKey: "userId")
                    KeychainWrapper.standard.removeObject(forKey: "pw")

                    self.dismiss(animated: true, completion: nil)
                }

            case .requestErr(_):
                self.pwCertificationErrorLabel.alpha = 1
                self.pwCertificationErrorLabel.textColor = .red
                self.pwCertificationErrorLabel.shake(duration: 0.3)

                
            case .pathErr:
                self.pwCertificationErrorLabel.alpha = 1
                self.pwCertificationErrorLabel.textColor = .red
                self.pwCertificationErrorLabel.shake(duration: 0.3)

                
            case .serverErr:
                print(".serverErr")
                
            case .networkFail:
                print(".networkFail")
            }
        }
    }


}

extension SettingVC {
    
    private func certificationAnimate(){
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       usingSpringWithDamping: 0.85,
                       initialSpringVelocity: 1,
                       options: [.curveEaseIn],
                       animations: {
                        // self를 항상 붙여줘야함 (클로저 안에서)
                        self.pwChangeTextField.alpha = 1
                        self.pwChangeTextField.transform = CGAffineTransform.init(translationX: -50, y: 0)
                        self.pwChangeTextField2.alpha = 1
                        self.pwChangeTextField2.transform = CGAffineTransform.init(translationX: -50, y: 0)
                        self.pwGuideLabel2.alpha = 1
                        self.pwGuideLabel2.transform = CGAffineTransform.init(translationX: -50, y: 0)
                        self.pwChangeBtn.alpha = 1
                        self.pwChangeBtn.transform = CGAffineTransform.init(translationX: -50, y: 0)
        })

    }

}
