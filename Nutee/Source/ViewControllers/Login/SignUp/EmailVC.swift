//
//  EmailVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/10.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class EmailVC: UIViewController {
    
    // MARK: - UI components
    @IBOutlet weak var guideLabel: UILabel!
    @IBOutlet weak var guideLabel2: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var certificationBtn: UIButton!
    @IBOutlet weak var numCertificaionBtn: UIButton!
    @IBOutlet weak var preBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var numTextField: UITextField!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var bottomYLayoutConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var checkLabel: UILabel!
    @IBOutlet weak var otpCheckLabel: UILabel!
    
    // MARK: - Variables and Properties
    
    var animationDuration: TimeInterval = 1.4
    var flag: Bool = false
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeBtn.addTarget(self, action: #selector(close), for: .touchUpInside)
        nextBtn.addTarget(self, action: #selector(toNext), for: .touchUpInside)
        
        emailTextField.addTarget(self, action: #selector(EmailVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        emailTextField.addTarget(self, action: #selector(EmailVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)

        certificationBtn.addTarget(self, action: #selector(certification), for: .touchUpInside)
        numCertificaionBtn.addTarget(self, action: #selector(certifBtn), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setInit()
        animate()
        
        addKeyboardNotification()
        nextBtn.isEnabled = false
        navigationController?.navigationBar.isHidden = true
    }
    
    
    // MARK: - Helper
    
    func setInit() {
        
        progressView.tintColor = .nuteeGreen
        progressView.progress = 0.0
        certificationBtn.isEnabled = false
        
        guideLabel.alpha = 0
        guideLabel2.alpha = 0
        closeBtn.tintColor = .nuteeGreen
        certificationBtn.tintColor = .nuteeGreen
        numCertificaionBtn.tintColor = .nuteeGreen
        numCertificaionBtn.alpha = 0
        
        preBtn.isEnabled = false
        nextBtn.tintColor = .nuteeGreen
        
        emailTextField.tintColor = .nuteeGreen
        emailTextField.addBorder(.bottom, color: .nuteeGreen, thickness: 1)
        
        numTextField.tintColor = .nuteeGreen
        numTextField.addBorder(.bottom, color: .nuteeGreen, thickness: 1)
        numTextField.alpha = 0
        checkLabel.alpha = 0
        otpCheckLabel.alpha = 0
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func toNext(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "IdVC") as! IDVC
        vc.email = self.emailTextField.text ?? ""
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: false)
    }

    
    @objc func certification(){
        sendOTP(emailTextField.text!)
    }
    @objc func certifBtn(){
        checkOTP(numTextField.text!)
    }

    
}

extension EmailVC {
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
  
    }

}


extension EmailVC {
    func addKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification)  {
        if let info = notification.userInfo {
            let duration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
            let curve = info[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
            let keyboardFrame = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let keyboardHeight = keyboardFrame.height
            let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
            let bottomPadding = keyWindow?.safeAreaInsets.bottom
            
            bottomYLayoutConstraint.constant = (keyboardHeight - (bottomPadding ?? 0))
            
            self.view.setNeedsLayout()
            UIView.animate(withDuration: duration, delay: 0, options: .init(rawValue: curve), animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        if let info = notification.userInfo {
            let duration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
            let curve = info[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
            
            bottomYLayoutConstraint.constant = 0
            self.view.setNeedsLayout()
            UIView.animate(withDuration: duration, delay: 0, options: .init(rawValue: curve), animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
}

extension EmailVC : UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if emailTextField.text?.validateSkhuEmail() ?? false  {
            certificationBtn.isEnabled = true
            certificationBtn.tintColor = .nuteeGreen
            certificationBtn.isEnabled = true
        } else {
            certificationBtn.tintColor = .veryLightPink
            certificationBtn.isEnabled = false
        }
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
//        self.view.endEditing(true)
//    }
}

extension EmailVC {
    func sendOTP(_ email : String){
        UserService.shared.sendOTP(email) { (responsedata) in
            switch responsedata {
                
            case .success(_):
                self.checkLabel.text = "해당 이메일에서 인증번호를 확인해주세요"
                self.checkLabel.alpha = 1
                self.checkLabel.textColor = .nuteeGreen
                self.emailTextField.addBorder(.bottom, color: .nuteeGreen, thickness: 1)
                self.certificationAnimate()
                
            case .requestErr(_):
                self.checkLabel.text = "이미 인증된 이메일입니다."
                self.checkLabel.alpha = 1
                self.checkLabel.textColor = .red
                self.emailTextField.addBorder(.bottom, color: .red, thickness: 1)

                print(".requestErr")
            case .pathErr:
                print(".pathErr")
            case .serverErr:
                print(".serverErr")
            case .networkFail:
                print(".networkFail")
            }
        }
    }
    
    func checkOTP(_ otp : String){
        UserService.shared.checkOTP(otp) { (responsedata) in
            switch responsedata {
                
            case .success(_):
                self.otpCheckLabel.text = "인증번호가 확인되었습니다."
                self.otpCheckLabel.alpha = 1
                self.otpCheckLabel.textColor = .nuteeGreen
                self.numTextField.addBorder(.bottom, color: .nuteeGreen, thickness: 1)

                self.nextBtn.isEnabled = true
                
            case .requestErr(_):
                self.otpCheckLabel.text = "인증번호가 틀렸습니다."
                self.otpCheckLabel.alpha = 1
                self.otpCheckLabel.textColor = .nuteeGreen
                self.numTextField.addBorder(.bottom, color: .nuteeGreen, thickness: 1)

                print(".requestErr")
            case .pathErr:
                print(".pathErr")
            case .serverErr:
                print(".serverErr")
            case .networkFail:
                print(".networkFail")
            }
        }
    }

}


extension EmailVC {
    private func animate(){
        UIView.animate(withDuration: animationDuration,
                       delay: 1,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 1,
                       options: [.curveEaseIn],
                       animations: {
                        // self를 항상 붙여줘야함 (클로저 안에서)
                        self.guideLabel.alpha = 1
                        self.guideLabel.transform = CGAffineTransform.init(translationX: 0, y: 50)
        })
        UIView.animate(withDuration: animationDuration,
                       delay: animationDuration,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 1,
                       options: [.curveEaseIn],
                       animations: {
                        // self를 항상 붙여줘야함 (클로저 안에서)
                        self.guideLabel2.alpha = 1
                        self.guideLabel2.transform = CGAffineTransform.init(translationX: 0, y: 50)
        })
        
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       usingSpringWithDamping: 0.85,
                       initialSpringVelocity: 1,
                       options: [.curveEaseIn],
                       animations: {
                        // self를 항상 붙여줘야함 (클로저 안에서)
                        self.progressView.setProgress(0.25, animated: true)
                        
        })

        
    }
    
    private func certificationAnimate(){
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       usingSpringWithDamping: 0.85,
                       initialSpringVelocity: 1,
                       options: [.curveEaseIn],
                       animations: {
                        // self를 항상 붙여줘야함 (클로저 안에서)
                        self.numTextField.alpha = 1
                        self.numTextField.transform = CGAffineTransform.init(translationX: -50, y: 0)

        })

        
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       usingSpringWithDamping: 0.85,
                       initialSpringVelocity: 1,
                       options: [.curveEaseIn],
                       animations: {
                        // self를 항상 붙여줘야함 (클로저 안에서)
                        self.numCertificaionBtn.alpha = 1
                        self.numCertificaionBtn.transform = CGAffineTransform.init(translationX: -50, y: 0)

        })

    }
}
