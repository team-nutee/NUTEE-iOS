//
//  NewsFeedTableHeaderSection.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/02/03.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class NewsFeedTableHeaderSection: UITableViewHeaderFooterView {
    
    @IBOutlet var imgvwUserImg: UIImageView!
    @IBOutlet var lblUserId: UILabel!
    @IBOutlet var lblPostTime: UILabel!
    @IBOutlet var lblContents: UILabel!
    @IBOutlet var imgvwPostImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        initUserImage()
    }
    
    func initUserImage() {
        imgvwUserImg.image = #imageLiteral(resourceName: "defaultProfile")
        imgvwUserImg.setRounded(radius: nil)
        lblContents.text = "Hi~"
        imgvwPostImg.image = #imageLiteral(resourceName: "nutee_zigi")
    }
    
}
