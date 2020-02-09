//
//  InitVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/01/06.
//  Copyright © 2020 Junhyeon. All rights reserved.
//

import UIKit

class InitVC : UIViewController {
    
    // MARK: - UI components
    @IBOutlet weak var copyLabel: UILabel!
    
    // MARK: - Variables and Properties
    
    // MARK: - Variables and Properties
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        copyLabel.isHidden = true
        setInit()
    }
    
    // MARK: -Helpers

    // 초기 설정
    func setInit() {

    }
    
    func setDefault() {

    }
    
}
