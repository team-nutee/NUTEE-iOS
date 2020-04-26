//
//  IDVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/10.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class IDVC: UIViewController {
    // MARK: - UI components
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var guideLabel: UILabel!
    @IBOutlet weak var guideLabel2: UILabel!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var preBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var bottomYLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var checkLabel: UILabel!
    
    // MARK: - Variables and Properties
    var animationDuration: TimeInterval = 1.4
    var flag: Bool = false
    var email : String = ""
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addKeyboardNotification()
        idTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        nextBtn.addTarget(self, action: #selector(checkID), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setInit()
        animate()
    }
    
    
    
    // MARK: - Helper
    
    func setInit() {
        
        progressView.tintColor = .nuteeGreen
        progressView.progress = 0.25
        
        closeBtn.tintColor = .nuteeGreen
        
        guideLabel.alpha = 0
        guideLabel2.alpha = 0
        idTextField.alpha = 0
        guideLabel2.alpha = 0
        preBtn.tintColor = .nuteeGreen
        nextBtn.isEnabled = false
        idTextField.tintColor = .nuteeGreen
        idTextField.addBorder(.bottom, color: .nuteeGreen, thickness: 1)
        checkLabel.alpha = 0
        
    }
    @objc func check(){
        
    }
    
    @objc func toNext(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NameVC") as! NameVC
        vc.id = idTextField.text!
        vc.email = self.email
        vc.modalPresentationStyle = .fullScreen

        self.present(vc, animated: false)
    }
    
}

extension IDVC {
  @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
  
    }
}


extension IDVC {
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

extension IDVC : UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if idTextField.text != "" && idTextField.text?.validateID() == true {
            nextBtn.isEnabled = true
            nextBtn.tintColor = .nuteeGreen
        } else {
            nextBtn.isEnabled = false
            nextBtn.tintColor = nil
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}

extension IDVC {
    @objc func checkID(){
        UserService.shared.checkID(idTextField.text!) { (responsedata) in
            switch responsedata {
                
            case .success(_):
                self.toNext()
                
            case .requestErr(_):
                self.checkLabel.shake(duration: 0.3)
                self.idTextField.addBorder(.bottom, color: .red, thickness: 1)
                self.checkLabel.textColor = .red
                self.checkLabel.text = "이미 사용중인 아이디입니다."
                self.checkLabel.sizeToFit()
                self.checkLabel.alpha = 1
                
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

extension IDVC {
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
                        self.progressView.setProgress(0.5, animated: true)
                        
        })
        
        UIView.animate(withDuration: animationDuration,
                       delay: animationDuration * 1.5,
                       usingSpringWithDamping: 0.85,
                       initialSpringVelocity: 1,
                       options: [.curveEaseIn],
                       animations: {
                        // self를 항상 붙여줘야함 (클로저 안에서)
                        self.closeBtn.alpha = 0
                        self.closeBtn.transform = CGAffineTransform.init(translationX: -30, y: 0)
                        
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
                        
        })
        
    }
    
}
