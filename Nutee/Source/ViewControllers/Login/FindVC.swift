//
//  FindIdVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/04.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class FindVC: UIViewController {
    
    
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var idGuideLabel: UILabel!
    @IBOutlet weak var idGuideLabel2: UILabel!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var idCertificateBtn: UIButton!
    
    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet weak var pwGuideLabel: UILabel!
    @IBOutlet weak var pwGuideLabel2: UILabel!
    @IBOutlet weak var pwGuideLabel3: UILabel!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var pwIDTextField: UITextField!
    @IBOutlet weak var pwCertificateBtn: UIButton!
    
    @IBOutlet weak var idGuideLabelYLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var idTextFieldXLayoutConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var idErrorLabel: UILabel!
    @IBOutlet weak var pwErrorLabel: UILabel!
    @IBOutlet weak var pwError2Label: UILabel!
    
    
    var animationDuration = 1.3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idCertificateBtn.addTarget(self, action: #selector(findid), for: .touchUpInside)
        pwCertificateBtn.addTarget(self, action: #selector(findpw), for: .touchUpInside)
        
        initSetting()
        setAlphaZero()
        closeBtn.addTarget(self, action: #selector(close), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        animate()
    }
    
    func initSetting() {
        closeBtn.tintColor = .nuteeGreen
        idCertificateBtn.isEnabled = false
        pwCertificateBtn.isEnabled = false
        
        idTextField.addBorder(.bottom, color: .nuteeGreen, thickness: 1)
        idTextField.tintColor = .nuteeGreen
        idTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        pwIDTextField.addBorder(.bottom, color: .nuteeGreen, thickness: 1)
        pwIDTextField.tintColor = .nuteeGreen
        pwIDTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        pwTextField.addBorder(.bottom, color: .nuteeGreen, thickness: 1)
        pwTextField.tintColor = .nuteeGreen
        pwTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        pwTextField.delegate = self
        pwIDTextField.delegate = self
        
        
        idGuideLabelYLayoutConstraint.constant = 15
        idTextFieldXLayoutConstraint.constant = 70
        


    }
    
    func setAlphaZero() {
        idGuideLabel.alpha = 0
        idGuideLabel2.alpha = 0
        idTextField.alpha = 0
        idCertificateBtn.alpha = 0
        
        pwGuideLabel.alpha = 0
        pwGuideLabel2.alpha = 0
        pwGuideLabel3.alpha = 0
        pwTextField.alpha = 0
        pwIDTextField.alpha = 0
        pwCertificateBtn.alpha = 0
        idErrorLabel.alpha = 0
        pwErrorLabel.alpha = 0
        pwError2Label.alpha = 0
    }
    
    @objc func findid(){
        findIDServise(idTextField.text!)
    }
    
    @objc func findpw(){
        findPWServise(pwIDTextField.text!, pwTextField.text!)
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
        dePWAnimate()
        
    }

    
}

extension FindVC : UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if idTextField.text?.validateSkhuKrEmail() ?? false || idTextField.text?.validateSkhuCoKrEmail() ?? false || idTextField.text?.validateOfficeEmail() ?? false{
            idCertificateBtn.isEnabled = true
            idCertificateBtn.tintColor = .nuteeGreen
        } else {
            idCertificateBtn.tintColor = nil
            idCertificateBtn.isEnabled = false
        }
        
        if (pwTextField.text?.validateSkhuKrEmail() ?? false || pwTextField.text?.validateSkhuCoKrEmail() ?? false || pwTextField.text?.validateOfficeEmail() ?? false) && pwIDTextField.text != ""  {
            pwCertificateBtn.isEnabled = true
            pwCertificateBtn.tintColor = .nuteeGreen
        } else {
            pwCertificateBtn.tintColor = nil
            pwCertificateBtn.isEnabled = false
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == pwTextField || textField == pwIDTextField {
            pwAnimate()
        }
        
        idErrorLabel.alpha = 0
        pwErrorLabel.alpha = 0
        pwError2Label.alpha = 0

        return true
    }
    
    
}

extension FindVC {
    private func animate(){
        UIView.animate(withDuration: animationDuration,
                       delay: 1,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 1,
                       options: [.curveEaseIn],
                       animations: {
                        // self를 항상 붙여줘야함 (클로저 안에서)
                        self.idGuideLabel.alpha = 1
                        self.idGuideLabel.transform = CGAffineTransform.init(translationX: 0, y: 50)
        })
        UIView.animate(withDuration: animationDuration,
                       delay: animationDuration,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 1,
                       options: [.curveEaseIn],
                       animations: {
                        // self를 항상 붙여줘야함 (클로저 안에서)
                        self.idGuideLabel2.alpha = 1
                        self.idGuideLabel2.transform = CGAffineTransform.init(translationX: 0, y: 50)
        })
        
        UIView.animate(withDuration: animationDuration,
                       delay: animationDuration*2,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 1,
                       options: [.curveEaseIn],
                       animations: {
                        // self를 항상 붙여줘야함 (클로저 안에서)
                        self.pwGuideLabel.alpha = 1
                        self.pwGuideLabel.transform = CGAffineTransform.init(translationX: 0, y: 50)
        })
        UIView.animate(withDuration: animationDuration,
                       delay: animationDuration*2.5,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 1,
                       options: [.curveEaseIn],
                       animations: {
                        // self를 항상 붙여줘야함 (클로저 안에서)
                        self.pwGuideLabel2.alpha = 1
                        self.pwGuideLabel2.transform = CGAffineTransform.init(translationX: 0, y: 50)
                        self.pwGuideLabel3.alpha = 1
                        self.pwGuideLabel3.transform = CGAffineTransform.init(translationX: 0, y: 50)
        })
        
        UIView.animate(withDuration: animationDuration,
                       delay: animationDuration * 1.5,
                       usingSpringWithDamping: 0.85,
                       initialSpringVelocity: 1,
                       options: [.curveEaseIn],
                       animations: {
                        // self를 항상 붙여줘야함 (클로저 안에서)
                        self.idTextField.alpha = 1
                        self.idTextField.transform = CGAffineTransform.init(translationX: -50, y: 0)
                        self.idCertificateBtn.alpha = 1
                        self.idCertificateBtn.transform = CGAffineTransform.init(translationX: -50, y: 0)
        })
        
        UIView.animate(withDuration: animationDuration,
                       delay: animationDuration * 2 * 1.5,
                       usingSpringWithDamping: 0.85,
                       initialSpringVelocity: 1,
                       options: [.curveEaseIn],
                       animations: {
                        // self를 항상 붙여줘야함 (클로저 안에서)
                        self.pwTextField.alpha = 1
                        self.pwTextField.transform = CGAffineTransform.init(translationX: -50, y: 0)
                        self.pwIDTextField.alpha = 1
                        self.pwIDTextField.transform = CGAffineTransform.init(translationX: -50, y: 0)
                        self.pwCertificateBtn.alpha = 1
                        self.pwCertificateBtn.transform = CGAffineTransform.init(translationX: -50, y: 0)

        })
        
        
    }
    
    private func pwAnimate(){
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 1,
                       options: [.curveEaseIn],
                       animations: {
                        // self를 항상 붙여줘야함 (클로저 안에서)
                        self.idGuideLabel.alpha = 0
                        self.idGuideLabel2.alpha = 0
                        self.idTextField.alpha = 0
                        self.idCertificateBtn.alpha = 0
                        self.lineView.alpha = 0
                        self.pwErrorLabel.transform = CGAffineTransform.init(translationX: 0, y: -180)
                        self.pwError2Label.transform = CGAffineTransform.init(translationX: 0, y: -180)

                        self.pwGuideLabel.transform = CGAffineTransform.init(translationX: 0, y: -130)
                        self.pwGuideLabel2.transform = CGAffineTransform.init(translationX: 0, y: -130)
                        self.pwGuideLabel3.transform = CGAffineTransform.init(translationX: 0, y: -130)
                        self.pwTextField.transform = CGAffineTransform.init(translationX: -50, y: -180)
                        self.pwIDTextField.transform = CGAffineTransform.init(translationX: -50, y: -180)
                        self.pwCertificateBtn.transform = CGAffineTransform.init(translationX: -50, y: -180)
        })
    }
    private func dePWAnimate(){
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 1,
                       options: [.curveEaseIn],
                       animations: {
                        // self를 항상 붙여줘야함 (클로저 안에서)
                        self.idGuideLabel.alpha = 1
                        self.idGuideLabel2.alpha = 1
                        self.idTextField.alpha = 1
                        self.idCertificateBtn.alpha = 1
                        self.lineView.alpha = 1
                        self.pwErrorLabel.transform = CGAffineTransform.init(translationX: 0, y: 0)
                        self.pwError2Label.transform = CGAffineTransform.init(translationX: 0, y: 0)

                        self.pwGuideLabel.transform = CGAffineTransform.init(translationX: 0, y: 50)
                        self.pwGuideLabel2.transform = CGAffineTransform.init(translationX: 0, y: 50)
                        self.pwGuideLabel3.transform = CGAffineTransform.init(translationX: 0, y: 50)
                        self.pwTextField.transform = CGAffineTransform.init(translationX: -50, y: 0)
                        self.pwIDTextField.transform = CGAffineTransform.init(translationX: -50, y: 0)
                        self.pwCertificateBtn.transform = CGAffineTransform.init(translationX: -50, y: 0)
        })
    }
}

extension FindVC {
    func findIDServise(_ email : String) {
        UserService.shared.findID(email) { (responsedata) in
            switch responsedata {
                
            // NetworkResult 의 요소들
            case .success(_):
                self.idErrorLabel.alpha = 1
                self.idErrorLabel.text = "이메일 발신 처리 되었습니다."
                self.idErrorLabel.textColor = .nuteeGreen
                self.idErrorLabel.sizeToFit()
                self.idErrorLabel.shake(duration: 0.3)
                self.idTextField.addBorder(.bottom, color: .nuteeGreen, thickness: 1)

                
            case .requestErr(_):
                print(".requestErr")
                
            case .pathErr:
                self.idErrorLabel.alpha = 1
                self.idErrorLabel.text = "해당 이메일은 가입이 되어있지 않습니다."
                self.idErrorLabel.sizeToFit()
                self.idErrorLabel.textColor = .red
                self.idErrorLabel.shake(duration: 0.3)
                self.idTextField.addBorder(.bottom, color: .red, thickness: 1)

            case .serverErr:
                print(".serverErr")
                
            case .networkFail :
                print("failure")
            }
        }
        
    }
    
    func findPWServise(_ userId : String,_ email : String) {
        UserService.shared.findPW(userId, email) { (responsedata) in
            switch responsedata {
                
            // NetworkResult 의 요소들
            case .success(_):
                self.pwErrorLabel.alpha = 1
                self.pwErrorLabel.text = "이메일 발신 처리 되었습니다."
                self.pwErrorLabel.sizeToFit()
                self.pwErrorLabel.textColor = .nuteeGreen
                self.pwErrorLabel.shake(duration: 0.3)
                self.pwError2Label.alpha = 1
                self.pwError2Label.text = "이메일 발신 처리 되었습니다."
                self.pwError2Label.sizeToFit()
                self.pwError2Label.textColor = .nuteeGreen
                self.pwError2Label.shake(duration: 0.3)

                self.pwIDTextField.addBorder(.bottom, color: .nuteeGreen, thickness: 1)
                self.pwTextField.addBorder(.bottom, color: .nuteeGreen, thickness: 1)

            case .requestErr(_):
                self.pwErrorLabel.alpha = 1
                self.pwErrorLabel.text = "아이디 혹은 이메일이 틀립니다."
                self.pwErrorLabel.sizeToFit()
                self.pwErrorLabel.textColor = .red
                self.pwErrorLabel.shake(duration: 0.3)
                self.pwError2Label.alpha = 1
                self.pwError2Label.text = "아이디 혹은 이메일이 틀립니다."
                self.pwError2Label.sizeToFit()
                self.pwError2Label.textColor = .red
                self.pwError2Label.shake(duration: 0.3)

                self.pwIDTextField.addBorder(.bottom, color: .red, thickness: 1)
                self.pwTextField.addBorder(.bottom, color: .red, thickness: 1)

            case .pathErr:
                self.pwErrorLabel.alpha = 1
                self.pwErrorLabel.text = "아이디 혹은 이메일이 틀립니다."
                self.pwErrorLabel.sizeToFit()
                self.pwErrorLabel.textColor = .red
                self.pwErrorLabel.shake(duration: 0.3)
                self.pwError2Label.alpha = 1
                self.pwError2Label.text = "아이디 혹은 이메일이 틀립니다."
                self.pwError2Label.sizeToFit()
                self.pwError2Label.textColor = .red
                self.pwError2Label.shake(duration: 0.3)
                self.pwIDTextField.addBorder(.bottom, color: .red, thickness: 1)
                self.pwTextField.addBorder(.bottom, color: .red, thickness: 1)

            case .serverErr:
                print(".serverErr")
                
            case .networkFail :
                print("failure")
            }
        }
        
    }
    
    
}
