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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        checkView.setRounded(radius: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
