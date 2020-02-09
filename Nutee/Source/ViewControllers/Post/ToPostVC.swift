//
//  ToPostVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/09.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class ToPostVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        toPost()
    }
    
    func toPost() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PostVC") as! PostVC
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true, completion: nil)
    }
    
}
