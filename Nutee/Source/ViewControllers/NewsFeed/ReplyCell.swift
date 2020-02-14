//
//  ReplyCell.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/02/03.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class ReplyCell: UITableViewCell{
    
    //MARK: - UI components
    
    @IBOutlet var imgCommentUser: UIImageView!
    @IBOutlet var lblCommentUserId: UILabel!
    @IBOutlet var lblCommentTime: UILabel!
    @IBOutlet var txtvwCommentContents: UITextView!
    
    //MARK: - Variables and Properties
    
    
    
    //MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initComments()
    }
    
    //MARK: - Helper
    
    func initComments() {
        imgCommentUser.image = #imageLiteral(resourceName: "nutee_zigi")
        imgCommentUser.setRounded(radius: nil)
        
        lblCommentUserId.text = "CommentUser"
        lblCommentUserId.sizeToFit()
        lblCommentTime.text = "2 min"
        
        txtvwCommentContents.sizeToFit()
        txtvwCommentContents.text = "Peng-Ha! Education Boardcasting System."
    }
}
