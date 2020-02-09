//
//  CafeteriaVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/04.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class CafeteriaVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var chaneBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = "피너츠"
        chaneBtn.setTitle("이름 변경", for: .normal)
        chaneBtn.sizeToFit()
        chaneBtn.addTarget(self, action: #selector(change), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(changeName), name: .forChangeName, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

    }
    
    
    @objc func change(){
        NotificationCenter.default.post(name: .forChangeName, object: nil)
    }

    @objc func changeName(){
        nameLabel.text = "스누피"
    }

}
