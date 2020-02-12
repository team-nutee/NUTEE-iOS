//
//  PassWordVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/10.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class PassWordVC: UIViewController {
    
    // MARK: - UI components
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var guideLabel: UILabel!
    @IBOutlet weak var guideLabel2: UILabel!
    @IBOutlet weak var guideLabel3: UILabel!
    @IBOutlet weak var preBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordTextField2: UITextField!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var alertLabel2: UILabel!
    
    @IBOutlet weak var buttonYLayoutConstraint: NSLayoutConstraint!
    // MARK: - Variables and Properties
    var animationDuration: TimeInterval = 2
    var flag: Bool = false
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addKeyboardNotification()
        
        passwordTextField.addTarget(self, action: #selector(PassWordVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        passwordTextField2.addTarget(self, action: #selector(PassWordVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        preBtn.addTarget(self, action: #selector(forDismiss), for: .touchUpInside)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setInit()
        animate()
    }
    
    
    
    // MARK: - Helper
    
    func setInit() {
        
        progressView.tintColor = .nuteeGreen
        progressView.progress = 0.5
        
        alertLabel.alpha = 0
        alertLabel2.alpha = 0
        
        guideLabel.alpha = 0
        guideLabel2.alpha = 0
        guideLabel3.alpha = 0
        passwordTextField.alpha = 0
        passwordTextField2.alpha = 0
        preBtn.tintColor = .nuteeGreen
        nextBtn.tintColor = .nuteeGreen
        passwordTextField.tintColor = .nuteeGreen
        passwordTextField.layer.addBorder([.bottom], color: .nuteeGreen, width: 1)
        passwordTextField2.tintColor = .nuteeGreen
        passwordTextField2.layer.addBorder([.bottom], color: .nuteeGreen, width: 1)
        //        numTextField.isHidden = true
    }
    
    @objc func forDismiss() {
        self.dismiss(animated: false, completion: nil)
    }


    
}

// MARK: - KeyBoard

extension PassWordVC {
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
            let window = UIApplication.shared.keyWindow
            let bottomPadding = window?.safeAreaInsets.bottom
            
            buttonYLayoutConstraint.constant = (keyboardHeight - bottomPadding!)
            
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
            
            buttonYLayoutConstraint.constant = 0
            self.view.setNeedsLayout()
            UIView.animate(withDuration: duration, delay: 0, options: .init(rawValue: curve), animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
}

extension PassWordVC : UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if passwordTextField.text?.validatePassword() == false  {
            alertAnimation()
            alertLabel.text = "8자 이상의 영어 대문자, 소문자, 숫자가 포함된 비밀번호를 입력해주세요."
            passwordTextField.layer.addBorder([.bottom], color: .red, width: 1)
        } else if passwordTextField.text?.validatePassword() == true{
            //            alertLabel.text = "8자 이상의 영어 대문자, 소문자, 숫자가 포함된 비밀번호를 입력해주세요."
            passwordTextField.layer.addBorder([.bottom], color: .nuteeGreen, width: 1)
            reversAlertAnimation()
        }
        
        if passwordTextField2.text != passwordTextField.text && passwordTextField2.text != "" {
            alertLabel.text = "비밀번호를 확인해주세요"
            alertAnimation2()
            alertAnimation()
            passwordTextField2.layer.addBorder([.bottom], color: .red, width: 1)
            passwordTextField.layer.addBorder([.bottom], color: .red, width: 1)
        } else if passwordTextField2.text != "" {
            passwordTextField.layer.addBorder([.bottom], color: .nuteeGreen, width: 1)
            passwordTextField2.layer.addBorder([.bottom], color: .nuteeGreen, width: 1)
            reversAlertAnimation()
            reversAlertAnimation2()
        }
    }
    
}

// MARK: - animation

extension PassWordVC {
    
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
                        self.guideLabel3.alpha = 1
                        self.guideLabel3.transform = CGAffineTransform.init(translationX: 0, y: 50)
                        
        })
        
        UIView.animate(withDuration: animationDuration,
                       delay: 1,
                       usingSpringWithDamping: 0.85,
                       initialSpringVelocity: 1,
                       options: [.curveEaseIn],
                       animations: {
                        // self를 항상 붙여줘야함 (클로저 안에서)
                        self.progressView.setProgress(0.75, animated: true)
                        
        })
        
        UIView.animate(withDuration: animationDuration,
                       delay: animationDuration * 1.5,
                       usingSpringWithDamping: 0.85,
                       initialSpringVelocity: 1,
                       options: [.curveEaseIn],
                       animations: {
                        // self를 항상 붙여줘야함 (클로저 안에서)
                        self.passwordTextField.alpha = 1
                        self.passwordTextField.transform = CGAffineTransform.init(translationX: -50, y: 0)
                        self.passwordTextField2.alpha = 1
                        self.passwordTextField2.transform = CGAffineTransform.init(translationX: -50, y: 0)
                        
        })
        
    }
    
    private func alertAnimation(){
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 0.5,
                       options: [.curveEaseOut],
                       animations: {
                        // self를 항상 붙여줘야함 (클로저 안에서)
                        self.alertLabel.alpha = 1
                        self.alertLabel.transform = CGAffineTransform.init(translationX: 10, y: 0)
        })
    }
    
    private func alertAnimation2(){
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 0.2,
                       options: [.curveEaseOut],
                       animations: {
                        // self를 항상 붙여줘야함 (클로저 안에서)
                        self.alertLabel2.alpha = 1
                        self.alertLabel2.transform = CGAffineTransform.init(translationX: 10, y: 0)
        })
    }
    
    private func reversAlertAnimation(){
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: [.curveEaseOut],
                       animations: {
                        // self를 항상 붙여줘야함 (클로저 안에서)
                        self.alertLabel.alpha = 0
                        self.alertLabel.transform = CGAffineTransform.init(translationX: -10, y: 0)
                        
        })
    }
    
    private func reversAlertAnimation2(){
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: [.curveEaseOut],
                       animations: {
                        // self를 항상 붙여줘야함 (클로저 안에서)
                        self.alertLabel2.alpha = 0
                        self.alertLabel2.transform = CGAffineTransform.init(translationX: -10, y: 0)
        })
    }
    
}
