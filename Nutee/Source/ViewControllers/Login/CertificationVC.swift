//
//  CertificationVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/09.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class CertificationVC: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var certificationTextField: UITextField!
    @IBOutlet weak var certificationBtn: UIButton!
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    
    var email = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailLabel.text = email
        certificationTextField.tintColor = .nuteeGreen
        closeBtn.tintColor = .nuteeGreen
        certificationBtn.isEnabled = false
        checkBtn.isEnabled = false
        closeBtn.addTarget(self, action: #selector(close), for: .touchUpInside)
        
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }

}
