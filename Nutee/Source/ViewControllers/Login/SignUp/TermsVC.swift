//
//  TermsVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/04/19.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class TermsVC: UIViewController {

    @IBOutlet weak var dissmissBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dissmissBtn.tintColor = .nuteeGreen
        dissmissBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
    }
    
    @objc func back(){
        
        self.dismiss(animated: true, completion: nil)
    }


}
