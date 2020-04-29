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
//        toPost()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.selectedIndex = 0
    }
    
    func toPost() {
        print(#function)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PostVC") as! PostVC
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true, completion: nil)
    }
    
}
