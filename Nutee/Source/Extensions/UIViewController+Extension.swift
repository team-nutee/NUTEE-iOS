//
//  UIViewController+Extension.swift
//  Nutee
//
//  Created by Junhyeon on 2020/01/24.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

extension UIViewController {
    
    
    // 2칸인 alert title - up, message - down
    func simpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let action = UIAlertAction(title: "확인", style: .default) { (action) in
            
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    // 예 버튼을 누를때 핸들러로 핸들링하는 Alert with cancel
    func simpleAlertWithHandler(title: String, msg: String?, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "예", style: .cancel, handler: handler)
        let noAction = UIAlertAction(title: "아니오", style: .default)
        
        alert.addAction(noAction)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }

    // 예 버튼을 누를때 핸들러로 핸들링하는 Alert without cancel
    func simpleDismissAlert(title: String, msg: String, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "예", style: .cancel, handler: handler)
        alert.addAction(okAction)
        
        self.present(alert, animated: true)
    }

    
}
