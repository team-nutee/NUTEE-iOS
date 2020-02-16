//
//  PopUpVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/07.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class PopUpVC: UIViewController {

    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var contentTextView: UITextView!
    
    var content : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        nextBtn.tintColor = .nuteeGreen
        contentTextView.text = content
        contentTextView.centerVertically()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
