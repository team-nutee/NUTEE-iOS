//
//  MyChatTVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/01/27.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class MyChatTVC: UITableViewCell {

    @IBOutlet weak var checkView: UIView!
    @IBOutlet weak var myChatLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        checkView.setRounded(radius: nil)
        checkView.backgroundColor = UIColor.nuteeGreen
        checkView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
