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
    
    @IBOutlet weak var pwGuideLabel: UILabel!
    @IBOutlet weak var pwGuideLabel2: UILabel!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var pwCertificateBtn: UIButton!

    @IBOutlet weak var idGuideLabelYLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var idTextFieldXLayoutConstraint: NSLayoutConstraint!
    
    
    var animationDuration = 1.3
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
        pwTextField.addBorder(.bottom, color: .nuteeGreen, thickness: 1)
        pwTextField.tintColor = .nuteeGreen
        pwTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)

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
        pwTextField.alpha = 0
        pwCertificateBtn.alpha = 0
    }

    @objc func close() {
        self.dismiss(animated: true, completion: nil)
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
        
        if pwTextField.text?.validateSkhuEmail() ?? false  {
            pwCertificateBtn.isEnabled = true
            pwCertificateBtn.tintColor = .nuteeGreen
        } else {
            pwCertificateBtn.tintColor = nil
            pwCertificateBtn.isEnabled = false
        }
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
//        self.view.endEditing(true)
//    }
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
                        self.pwCertificateBtn.alpha = 1
                        self.pwCertificateBtn.transform = CGAffineTransform.init(translationX: -50, y: 0)

        })


    }

}
