//
//  NewsFeedVO.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/01/14.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class NewsFeedCell: UITableViewCell {
    
    //MARK: - UI components
    
    @IBOutlet var imgUserImg: UIImageView!
    @IBOutlet var lblUserId: UILabel!
    @IBOutlet var lblPostTime: UILabel!
    @IBOutlet var cvPostImg: UICollectionView!
    @IBOutlet var imgvwPostImg: UIImageView!
    @IBOutlet var lblContents: UILabel!
    @IBOutlet var btnRepost: UIButton!
    @IBOutlet var btnLike: UIButton!
    @IBOutlet var btnComment: UIButton!
    

    //MARK: - Variables and Properties
    
    var numLike = 0
    var numRepost = 0
    var numComment = 0
    
    var isClickedLike: Bool = false
    var isClickedRepost: Bool = false
    var isClickedComment: Bool = false
    
    // .normal 상태에서의 버튼 AttributedStringTitle의 색깔 지정
    let normalAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
    // .selected 상태에서의 Repost버튼 AttributedStringTitle의 색깔 지정
    let selectedRepostAttributes = [NSAttributedString.Key.foregroundColor: UIColor.nuteeGreen]
    // .selected 상태에서의 Like버튼 AttributedStringTitle의 색깔 지정
    let selectedLikeAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemPink]
    
    //MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initPosting()
    }
    
    //MARK: - Clicked Action
    
    @IBAction func btnRepost(_ sender: UIButton) {
        // .selected State를 활성화 하기 위한 코드
        btnRepost.isSelected = !btnRepost.isSelected
        if isClickedRepost {
            numRepost -= 1
            setButtonAttributed(btn: sender, num: numRepost, color: .gray, state: .normal)
            isClickedRepost = false
        } else {
            numRepost += 1
            setButtonAttributed(btn: sender, num: numRepost, color: .nuteeGreen, state: .selected)
            isClickedRepost = true
        }
    }
    
    @IBAction func btnLike(_ sender: UIButton) {
        // .selected State를 활성화 하기 위한 코드
        btnLike.isSelected = !btnLike.isSelected
        if isClickedLike {
//            btnLike.isSelected = false
            numLike -= 1
            setButtonAttributed(btn: sender, num: numLike, color: .gray, state: .normal)
//            sender.setImage(UIImage(named: "heart"), for: .normal)
            isClickedLike = false
        } else {
//            btnLike.isSelected = true
            numLike += 1
            setButtonAttributed(btn: sender, num: numLike, color: .systemPink, state: .selected)
//            sender.setImage(UIImage(named: "heart-filled"), for: .normal)
            isClickedLike = true
        }
    }
    
    @IBAction func btnComment(_ sender: UIButton) {
        
        /*
        btnComment.isSelected = !btnComment.isSelected
        if isClickedComment {
            numComment -= 1
            setButtonPlain(btn: sender, num: numComment, color: .gray, state: .normal)
            isClickedComment = false
        } else {
            numComment += 1
            btnComment.setTitle(" " + String(numComment), for: .selected)
            btnComment.tintColor = .blue
            btnComment.setTitleColor(.blue, for: .selected)
            isClickedComment = true
        }
        */
    }
        
    //MARK: - Helper
    
    //포스팅 내용 초기설정
    func initPosting() {
        imgUserImg.image = #imageLiteral(resourceName: "defaultProfile")
        imgUserImg.setRounded(radius: nil)
        
        lblContents.text = "Hi~"
//        imgvwPostImg.image = #imageLiteral(resourceName: "nutee_zigi")
        
        setButtonAttributed(btn: btnLike, num: numLike, color: .gray, state: .normal)
        setButtonAttributed(btn: btnRepost, num: numRepost, color: .gray, state: .normal)
        setButtonPlain(btn: btnComment, num: numComment, color: .gray, state: .normal)
    }

    func setButtonPlain(btn: UIButton, num: Int, color: UIColor, state: UIControl.State) {
        btn.setTitle(" " + String(num), for: state)
        btnComment.tintColor = color
        btnComment.setTitleColor(color, for: state)
    }
    
    func setButtonAttributed(btn: UIButton, num: Int, color: UIColor, state: UIControl.State) {
        let stateAttributes = [NSAttributedString.Key.foregroundColor: color]
        btn.setAttributedTitle(NSAttributedString(string: " " + String(num), attributes: stateAttributes), for: state)
        btn.tintColor = color
    }
}
