//
//  YourChatTVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/01/27.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class YourChatTVC: UITableViewCell {

    @IBOutlet weak var youChatView: UIView!
    @IBOutlet weak var youCheckView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        youChatView.setRounded(radius: 5)
        youCheckView.setRounded(radius: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
