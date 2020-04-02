//
//  NameVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/10.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class NameVC: UIViewController {
    // MARK: - UI components
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var guideLabel: UILabel!
    @IBOutlet weak var guideLabel2: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var preBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var buttonYLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var checkLabel: UILabel!
    
    
    // MARK: - Variables and Properties
    var animationDuration: TimeInterval = 1.4
    var flag : Bool = false
    var id : String = ""
    var email : String = ""

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addKeyboardNotification()
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        nextBtn.addTarget(self, action: #selector(checkName), for: .touchUpInside)

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
        
        
        guideLabel.alpha = 0
        guideLabel2.alpha = 0
        nameTextField.alpha = 0
        guideLabel2.alpha = 0
        preBtn.tintColor = .nuteeGreen
        nextBtn.isEnabled = false
        nameTextField.tintColor = .nuteeGreen
        nameTextField.addBorder(.bottom, color: .nuteeGreen, thickness: 1)
        checkLabel.alpha = 0
    }
    
    @objc func toNext(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PassWordVC") as! PassWordVC
        vc.modalPresentationStyle = .fullScreen
        vc.id = self.id
        vc.name = nameTextField.text!
        vc.email = self.email
        vc.modalPresentationStyle = .fullScreen

//        self.navigationController?.pushViewController(vc, animated: false)
        self.present(vc, animated: false)
    }

}

extension NameVC {
  @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
  
    }
}


extension NameVC {
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
    
}

extension NameVC : UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if nameTextField.text != "" {
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

extension NameVC {
    @objc func checkName(){
        UserService.shared.checkNick(nameTextField.text!) { (responsedata) in
            switch responsedata {
                
            case .success(_):
                self.toNext()
                
            case .requestErr(_):
                self.checkLabel.shake(duration: 0.3)
                self.nameTextField.addBorder(.bottom, color: .red, thickness: 1)
                self.checkLabel.textColor = .red
                self.checkLabel.text = "이미 사용중인 닉네임입니다."
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

extension NameVC {
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
                        self.nameTextField.alpha = 1
                        self.nameTextField.transform = CGAffineTransform.init(translationX: -50, y: 0)
                        
        })
        
    }
    
}
