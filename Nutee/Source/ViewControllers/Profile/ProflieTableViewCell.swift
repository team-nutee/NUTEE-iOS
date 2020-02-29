//
//  ProflieTableViewCell.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/14.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class ProflieTableViewCell: UITableViewCell {

    @IBOutlet weak var profileIMG: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var articleTextView: UITextView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var replyBtn: UIButton!
    @IBOutlet weak var moreBtn: UIButton!
    
    var userInfo: SignIn?
    var userPost: PostContent?
    var indexPath = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileIMG.setRounded(radius: nil)
        profileIMG.backgroundColor = .lightGray
        shareBtn.tintColor = .lightGray
        shareBtn.titleLabel?.textColor = .lightGray
        likeBtn.tintColor = .lightGray
        likeBtn.titleLabel?.textColor = .lightGray
        replyBtn.tintColor = .lightGray
        replyBtn.titleLabel?.textColor = .lightGray
        moreBtn.tintColor = .lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    let postId = userInfo?.posts[self.indexPath].id ?? 0
//    print("----------------------------->indexPath값은 ", self.indexPath)
//    getUserPostService(postId: postId)
//
//    if indexPath == 0 {
//        cell.backgroundColor = .lightGray
//    }
//    textViewDidChange(cell.articleTextView)
//    cell.profileNameLabel.text = userPost?.user.nickname
//    cell.articleTextView.text = userPost?.content
//    cell.articleTextView.sizeToFit()
//
//
//    func getUserPostService(postId: Int) {
//        ContentService.shared.getPost(postId) { responsedata in
//
//            switch responsedata {
//            case .success(let res):
//                self.userPost = res as! PostContent
//                print("userPost server connect successful")
//            case .requestErr(_):
//                print("request error")
//
//            case .pathErr:
//                print(".pathErr")
//
//            case .serverErr:
//                print(".serverErr")
//
//            case .networkFail :
//                print("failure")
//                }
//        }
//
//    }
}
