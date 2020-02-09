//
//  SingUpVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/04.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    // MARK: - UI components
    
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var certificationBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var checkPwTextField: UITextField!
    
    @IBOutlet weak var checkPwLabel: UILabel!
    @IBOutlet weak var checkPwLabel2: UILabel!

    // MARK: - Variables and Properties
    
    var checkCer = false
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setInit()
        
        closeBtn.addTarget(self, action: #selector(close), for: .touchUpInside)
        certificationBtn.addTarget(self, action: #selector(certification), for: .touchUpInside)
        signUpBtn.addTarget(self, action: #selector(signUp), for: .touchUpInside)

        checkTextField()
        
    }
    
    // MARK: -Helpers

    func setInit() {
        closeBtn.setTitleColor(.nuteeGreen, for: .normal)
//        certificationBtn.setTitleColor(.nuteeGreen, for: .normal)
        certificationBtn.isEnabled = false
//        signUpBtn.setTitleColor(.nuteeGreen, for: .normal)
        signUpBtn.isEnabled = false
        
        emailTextField.tintColor = .nuteeGreen
        nameTextField.tintColor = .nuteeGreen
        pwTextField.tintColor = .nuteeGreen
        checkPwTextField.tintColor = .nuteeGreen
        
        checkPwLabel.isHidden = true
        checkPwLabel2.isHidden = true
        checkPwLabel.sizeToFit()
        checkPwLabel2.sizeToFit()
        emailTextField.layer.addBorder([.bottom], color: .nuteeGreen, width: 1)
        nameTextField.layer.addBorder([.bottom], color: .nuteeGreen, width: 1)
        pwTextField.layer.addBorder([.bottom], color: .nuteeGreen, width: 1)
        checkPwTextField.layer.addBorder([.bottom], color: .nuteeGreen, width: 1)
    }
    
    func checkTextField() {
        emailTextField.addTarget(self, action: #selector(SignUpVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        nameTextField.addTarget(self, action: #selector(SignUpVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        pwTextField.addTarget(self, action: #selector(SignUpVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        checkPwTextField.addTarget(self, action: #selector(SignUpVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
//        pwTextField.addTarget(self, action: #selector(SignUpVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
//        checkPwTextField.addTarget(self, action: #selector(SignUpVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)

    }
    
    @objc func close(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func certification(){
                        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CertificationVC") as! CertificationVC
        
        vc.email = emailTextField.text ?? ""
        
        vc.modalPresentationStyle = .currentContext
        
        self.present(vc, animated: true, completion: nil)
//        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @objc func signUp(){
        // ToDo : 서버 api 나오면 연결
    }

}

extension SignUpVC : UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if emailTextField.text?.validateSkhuEmail() == true  {
            certificationBtn.isEnabled = true
            certificationBtn.setTitleColor(.nuteeGreen, for: .normal)
        } else {
            certificationBtn.isEnabled = false
            certificationBtn.setTitleColor(.veryLightPink, for: .normal)
        }
        
        if pwTextField.text == checkPwTextField.text && pwTextField.text?.validatePassword() ?? false {
            checkPwTextField.layer.addBorder([.bottom], color: .nuteeGreen, width: 1)
            pwTextField.layer.addBorder([.bottom], color: .nuteeGreen, width: 1)
            checkPwLabel.isHidden = true
            checkPwLabel2.isHidden = true
        } else if pwTextField.text?.validatePassword() == false && checkPwTextField.text?.validatePassword() == false {
            checkPwTextField.layer.addBorder([.bottom], color: .red, width: 1)
            pwTextField.layer.addBorder([.bottom], color: .red, width: 1)
            checkPwLabel.isHidden = false
            checkPwLabel2.isHidden = false
            checkPwLabel.text = "8자 이상의 영어 대문자, 소문자, 숫자가 포함된 비밀번호를 입력해주세요"
            checkPwLabel2.text = "8자 이상의 영어 대문자, 소문자, 숫자가 포함된 비밀번호를 입력해주세요"
            checkPwLabel.sizeToFit()
            checkPwLabel2.sizeToFit()
        }  else {
            checkPwTextField.layer.addBorder([.bottom], color: .red, width: 1)
            pwTextField.layer.addBorder([.bottom], color: .red, width: 1)
            checkPwLabel.isHidden = false
            checkPwLabel2.isHidden = false
            checkPwLabel.text = "비밀번호를 확인해주세요"
            checkPwLabel2.text = "비밀번호를 확인해주세요"
            checkPwLabel.sizeToFit()
            checkPwLabel2.sizeToFit()
        }
        
        if emailTextField.text?.validateSkhuEmail() ?? false && nameTextField.text != nil && pwTextField.text == checkPwTextField.text && checkCer {
            signUpBtn.isEnabled = true
            signUpBtn.setTitleColor(.nuteeGreen, for: .normal)
        }
        
    }
    
}
