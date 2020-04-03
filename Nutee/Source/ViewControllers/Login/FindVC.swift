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
        if idTextField.text?.validateSkhuEmail() ?? false  {
            idCertificateBtn.isEnabled = true
            idCertificateBtn.tintColor = .nuteeGreen
        } else {
            idCertificateBtn.tintColor = nil
            idCertificateBtn.isEnabled = false
        }
        
        if pwTextField.text?.validateSkhuEmail() ?? false && pwIDTextField.text != ""  {
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
            case .success(let res):
                let response = res as! String
                
                print(response)
                
                self.simpleAlert(title: "", message: "이메일 발송이 완료되었습니다.")
                
            case .requestErr(_):
                print(".requestErr")
                
            case .pathErr:
                print(".pathErr")
                
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
            case .success(let res):
                let response = res as! String
                
                print(response)
                
                self.simpleAlert(title: "", message: "이메일 발송이 완료되었습니다.")
                
            case .requestErr(_):
                print(".requestErr")
                
            case .pathErr:
                print(".pathErr")
                
            case .serverErr:
                print(".serverErr")
                
            case .networkFail :
                print("failure")
            }
        }
        
    }
    
    
}
