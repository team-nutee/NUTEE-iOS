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
    
    // 댓글 표시
    @IBOutlet var imgCommentUser: UIImageView!
    @IBOutlet var lblCommentUserId: UILabel!
    @IBOutlet var lblCommentTime: UILabel!
    @IBOutlet var txtvwCommentContents: UITextView!

    //MARK: - Variables and Properties
    
    weak var newsTV: UITableView?
    
    //MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initComments()
    }
    
    //MARK: - Helper
    
    func initComments() {
        imgCommentUser.image = #imageLiteral(resourceName: "nutee_zigi")
        imgCommentUser.setRounded(radius: imgCommentUser.frame.height/2)
        
        lblCommentUserId.text = "CommentUser"
        lblCommentUserId.sizeToFit()
        lblCommentTime.text = "2 min"
        
        txtvwCommentContents.sizeToFit()
        txtvwCommentContents.text = "Peng-Ha! Educational Boardcasting System. First you need to set equal width and height for getting Circular ImageView.Below I set width and height as 100,100.If you want to set equal width and height according to your required size,set here."
    }
    
}
