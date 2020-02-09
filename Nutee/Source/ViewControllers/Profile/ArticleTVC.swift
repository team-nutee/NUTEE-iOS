//
//  ArticleTableViewCell.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/06.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class ArticleTVC: UITableViewCell {
    
    @IBOutlet weak var articleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        articleLabel.text = "123"
        timeLabel.text = "시간"
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
