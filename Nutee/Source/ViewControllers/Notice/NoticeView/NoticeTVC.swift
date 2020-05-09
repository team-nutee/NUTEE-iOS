//
//  NoticeTVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/05/07.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class NoticeTVC: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var isNoticeView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        isNoticeView.setRounded(radius: nil)
//        isNoticeView.backgroundColor = .greenLight
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
