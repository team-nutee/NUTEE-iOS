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
    
    @IBOutlet var contentsCell: UIView!
    
    // 댓글 표시
    @IBOutlet var imgCommentUser: UIImageView!
    @IBOutlet var lblCommentUserId: UILabel!
    @IBOutlet var lblCommentTime: UILabel!
    @IBOutlet var txtvwCommentContents: UITextView!

    //MARK: - Variables and Properties
    
    weak var newsTV: UITableView?
    
    var comment: Comment?
    
    //MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        initComments()
    }
    
    //MARK: - Helper
    
    func initComments() {
        imgCommentUser.image = #imageLiteral(resourceName: "nutee_zigi")
        imgCommentUser.setRounded(radius: imgCommentUser.frame.height/2)
        
        lblCommentUserId.text = comment?.user.nickname
        lblCommentUserId.sizeToFit()
        let originPostTime = comment?.createdAt
        let postTimeDateFormat = originPostTime?.getDateFormat(time: originPostTime!)
        lblCommentTime.text = postTimeDateFormat?.timeAgoSince(postTimeDateFormat!)
        
        txtvwCommentContents.sizeToFit()
        txtvwCommentContents.text = comment?.content
    }
    
}
