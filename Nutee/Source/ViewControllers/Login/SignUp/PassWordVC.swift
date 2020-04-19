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
    @IBOutlet weak var agreeCircleBtn: UIButton!
    @IBOutlet weak var agreeBtn: UIButton!
    @IBOutlet weak var viewAgreeBtn: UIButton!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordTextField2: UITextField!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var alertLabel2: UILabel!
    
    @IBOutlet weak var buttonYLayoutConstraint: NSLayoutConstraint!
    // MARK: - Variables and Properties
    var animationDuration: TimeInterval = 1.4
    var flag: Bool = false
    var id : String = ""
    var name : String = ""
    var email : String = ""
    var isAgree : Bool = false
    var isPassword : Bool = false
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addKeyboardNotification()
        
        passwordTextField.addTarget(self, action: #selector(PassWordVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        passwordTextField2.addTarget(self, action: #selector(PassWordVC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        agreeBtn.addTarget(self, action: #selector(agree), for: .touchUpInside)
        agreeCircleBtn.addTarget(self, action: #selector(agree), for: .touchUpInside)
        viewAgreeBtn.addTarget(self, action: #selector(viewAgree), for: .touchUpInside)

        nextBtn.addTarget(self, action: #selector(toNext), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setInit()
        
        animate()
    }
    
    
    
    // MARK: - Helper
        
    func setInit() {
        
        progressView.tintColor = .nuteeGreen
        progressView.progress = 0.75
        
        alertLabel.alpha = 0
        alertLabel2.alpha = 0
        
        guideLabel.alpha = 0
        guideLabel2.alpha = 0
        guideLabel3.alpha = 0
        passwordTextField.alpha = 0
        passwordTextField2.alpha = 0
        preBtn.tintColor = .nuteeGreen
        nextBtn.tintColor = .nuteeGreen
        nextBtn.isEnabled = false
        passwordTextField.tintColor = .nuteeGreen
        passwordTextField2.tintColor = .nuteeGreen
        passwordTextField.addBorder(.bottom, color: .nuteeGreen, thickness: 1)
        passwordTextField2.addBorder(.bottom, color: .nuteeGreen, thickness: 1)
        
        agreeBtn.alpha = 0
        agreeCircleBtn.alpha = 0
        viewAgreeBtn.alpha = 0
        agreeCircleBtn.makeRounded(cornerRadius: nil)
        agreeCircleBtn.borderColor = .nuteeGreen
        agreeCircleBtn.borderWidth = 1
        agreeBtn.tintColor = .nuteeGreen
        viewAgreeBtn.tintColor = .nuteeGreen

    }
    
    @objc func toNext(){
        signUpService(id, passwordTextField.text!, name)
    }
    
    @IBAction func dis(_ sender: UIButton){
        
    }
    
    @objc func agree(){
        if isAgree {
            isAgree = false
            agreeCircleBtn.backgroundColor = nil
            nextBtn.isEnabled = false
        } else {
            isAgree = true
            agreeCircleBtn.backgroundColor = .nuteeGreen
            if isPassword {
                nextBtn.isEnabled = false
            } else {
                passwordTextField.addBorder(.bottom, color: .nuteeGreen, thickness: 1)
                passwordTextField2.addBorder(.bottom, color: .nuteeGreen, thickness: 1)
                reversAlertAnimation()
                reversAlertAnimation2()
                nextBtn.isEnabled = true
            }
        }
    }
    
    @objc func viewAgree(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TermsVC") as! TermsVC
        
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension PassWordVC {
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
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
            let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            //            let window = UIApplication.shared.keyWindow
            let bottomPadding = keyWindow?.safeAreaInsets.bottom
            
            buttonYLayoutConstraint.constant = (keyboardHeight - (bottomPadding ?? 0))
            
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
            passwordTextField.addBorder(.bottom, color: .red, thickness: 1)
            nextBtn.isEnabled = false
            isPassword = false

        } else if passwordTextField.text?.validatePassword() == true{
            passwordTextField.addBorder(.bottom, color: .nuteeGreen, thickness: 1)
            reversAlertAnimation()
            nextBtn.isEnabled = false
            isPassword = false

        }
        
        if passwordTextField2.text != passwordTextField.text && passwordTextField2.text != ""  {
            alertLabel.text = "비밀번호를 확인해주세요"
            alertAnimation2()
//            alertAnimation()
            passwordTextField2.addBorder(.bottom, color: .red, thickness: 1)
            passwordTextField.addBorder(.bottom, color: .red, thickness: 1)
            nextBtn.isEnabled = false
            isPassword = false

        } else if passwordTextField2.text != "" && passwordTextField2.text?.validatePassword() == true {
            passwordTextField.addBorder(.bottom, color: .nuteeGreen, thickness: 1)
            passwordTextField2.addBorder(.bottom, color: .nuteeGreen, thickness: 1)
            reversAlertAnimation()
            reversAlertAnimation2()
        } else if passwordTextField2.text != "" && passwordTextField2.text?.validatePassword() == true && isAgree {
            nextBtn.isEnabled = true
            isPassword = true

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
                        self.guideLabel.alpha = 1
                        self.guideLabel.transform = CGAffineTransform.init(translationX: 0, y: 50)
        })
        
        UIView.animate(withDuration: animationDuration,
                       delay: animationDuration,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 1,
                       options: [.curveEaseIn],
                       animations: {
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
                        self.progressView.setProgress(1, animated: true)
                        
        })
        
        UIView.animate(withDuration: animationDuration,
                       delay: animationDuration * 1.5,
                       usingSpringWithDamping: 0.85,
                       initialSpringVelocity: 1,
                       options: [.curveEaseIn],
                       animations: {
                        self.passwordTextField.alpha = 1
                        self.passwordTextField.transform = CGAffineTransform.init(translationX: -50, y: 0)
                        self.passwordTextField2.alpha = 1
                        self.passwordTextField2.transform = CGAffineTransform.init(translationX: -50, y: 0)
                        self.agreeBtn.alpha = 1
                        self.agreeBtn.transform = CGAffineTransform.init(translationX: -50, y: 0)
                        self.agreeCircleBtn.alpha = 1
                        self.agreeCircleBtn.transform = CGAffineTransform.init(translationX: -50, y: 0)
                        self.viewAgreeBtn.alpha = 1
                        self.viewAgreeBtn.transform = CGAffineTransform.init(translationX: -50, y: 0)

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

extension PassWordVC {
    func error(){
        self.passwordTextField.addBorder(.bottom, color: .red, thickness: 1)
        self.passwordTextField2.addBorder(.bottom, color: .red, thickness: 1)
        self.passwordTextField.text = "에러로 인해 회원가입이 진행되지 않았습니다."
        self.passwordTextField2.text = "에러로 인해 회원가입이 진행되지 않았습니다."
        self.passwordTextField.sizeToFit()
        self.passwordTextField2.sizeToFit()
        print("request error")
    }
    
    func signUpService(_ userId: String, _ password: String,_ nickname : String) {
        UserService.shared.signUp(userId, password, nickname, email) { responsedata in
            
            switch responsedata {
                
            // NetworkResult 의 요소들
            case .success(let res):
                let response = res as! SignUp
                
                print("회원가입 완료")
                print(response)
                
                self.oneAlertWithHandler(title: "회원가입이", msg: "완료되었습니다.", handler: { (action) in
                    self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
                })
                
            case .requestErr(_):
                self.alertAnimation()
                self.error()

            case .pathErr:
                self.alertAnimation()
                self.error()
                print(".pathErr")
         
            case .serverErr:
                self.alertAnimation()
                self.error()
                print(".serverErr")
         
            case .networkFail :
                self.alertAnimation()
                self.error()
                print("failure")
            }
        }
        
    }
    
}
