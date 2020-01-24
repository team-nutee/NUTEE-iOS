//
//  NewsFeedVO.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/01/14.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class NewsFeedCell: UITableViewCell {
    
    @IBOutlet var imgUserImg: UIImageView!
    @IBOutlet var lblUserId: UILabel!
    @IBOutlet var lblPostTime: UILabel!
    @IBOutlet var lblContents: UILabel!
    
    @IBAction func btnRepost(_ sender: Any) { }
    
    @IBAction func btnLike(_ sender: Any) { }
    
    @IBAction func btnReply(_ sender: Any) { }
    
    @IBAction func btnMore(_ sender: Any) { }
    
}
