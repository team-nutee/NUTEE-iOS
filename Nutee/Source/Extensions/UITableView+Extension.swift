//
//  UITableView+Extension.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/09.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit
import Then
import SnapKit

extension UITableView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let titleLabel = UILabel().then {
            $0.text = title
            $0.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
            $0.textColor = UIColor.black
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
            $0.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        }
        
        let messageLabel = UILabel().then {
            $0.text = message
            $0.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
            $0.textColor = UIColor.lightGray
            $0.textAlignment = .center
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
            $0.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
            $0.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
            $0.numberOfLines = 0
        }
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        // The only tricky part is here:
        
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
    
    // Main NewsFeed - 불러올 게시글이 없는 경우 표시
    func setNoPostsToShowView(_ cell: NewsFeedCell, emptyView: UIView) {
        emptyView.backgroundColor = .white
        let maxWidthContainer: CGFloat = 375
        let maxHeightContainer: CGFloat = 200

        let zigiSorry = UIImageView()
        zigiSorry.image = #imageLiteral(resourceName: "zigi_sorry")
        let maxWidthImage: CGFloat = 460
        let maxHeightImage: CGFloat = 428

        let msgLabel = UILabel()
        msgLabel.text = "불러올 게시글이 없습니다?"
        msgLabel.textColor = .black
        msgLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        msgLabel.textAlignment = .center

        cell.addSubview(emptyView)
        emptyView.addSubview(zigiSorry)
        emptyView.addSubview(msgLabel)
        
        emptyView.snp.makeConstraints({ (make) in
            make.width.equalTo(emptyView.snp.height).multipliedBy(maxWidthContainer/maxHeightContainer)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        })
        
        zigiSorry.snp.makeConstraints({ (make) in
            make.width.equalTo(zigiSorry.snp.height).multipliedBy(maxWidthImage/maxHeightImage)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(-40)
        })
        
        msgLabel.snp.makeConstraints({ (make) in
            make.centerX.equalTo(zigiSorry)
            make.bottom.equalToSuperview()
        })
    }
    
    // DetailNewsFeed - 보여줄 댓글이 없는 경우 표시
    func setStatusNoReplyView(_ cell: ReplyCell, emptyView: UIView) {
        emptyView.backgroundColor = .white
        let maxWidthContainer: CGFloat = 375
        let maxHeightContainer: CGFloat = 140
        
        let zigiNoReply = UIImageView()
        zigiNoReply.image = #imageLiteral(resourceName: "zigi_no_reply")
        let maxWidthImage: CGFloat = 455
        let maxHeightImage: CGFloat = 684
        
        let msgLabel = UILabel()
        msgLabel.text = "댓글이 없습니다"
        msgLabel.textColor = .black
        msgLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 15)
        msgLabel.font = msgLabel.font.withSize(15)
        msgLabel.textAlignment = .center
        
        cell.addSubview(emptyView)
        emptyView.addSubview(zigiNoReply)
        emptyView.addSubview(msgLabel)
        
        emptyView.snp.makeConstraints({ (make) in
            make.width.equalTo(emptyView.snp.height).multipliedBy(maxWidthContainer/maxHeightContainer)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        })
        
        zigiNoReply.snp.makeConstraints({ (make) in
            make.width.equalTo(zigiNoReply.snp.height).multipliedBy(maxWidthImage/maxHeightImage)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(-30)
        })
        
        msgLabel.snp.makeConstraints({ (make) in
            make.centerX.equalTo(zigiNoReply)
            make.bottom.equalToSuperview()
        })
    }
    
    // FollowerVC - 보여줄 팔로워가 없는 경우 표시
    func setNoFollower(_ cell: FollowerTVC, emptyView: UIView) {
        emptyView.backgroundColor = .white
        let maxWidthContainer: CGFloat = 375
        let maxHeightContainer: CGFloat = 350
        
        let zigiNoFollower = UIImageView()
        zigiNoFollower.image = #imageLiteral(resourceName: "nuteeLoading_09")
        let maxWidthImage: CGFloat = 512
        let maxHeightImage: CGFloat = 512
        
        let msgLabel = UILabel()
        msgLabel.text = "...팔로워가 없어요"
        msgLabel.textColor = .black
        msgLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 18)
        msgLabel.font = msgLabel.font.withSize(18)
        msgLabel.textAlignment = .center
        
        cell.addSubview(emptyView)
        emptyView.addSubview(zigiNoFollower)
        emptyView.addSubview(msgLabel)
        
        emptyView.snp.makeConstraints({ (make) in
            make.width.equalTo(emptyView.snp.height).multipliedBy(maxWidthContainer/maxHeightContainer)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        })
        
        zigiNoFollower.snp.makeConstraints({ (make) in
            make.width.equalTo(zigiNoFollower.snp.height).multipliedBy(maxWidthImage/maxHeightImage)
            make.centerY.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        })
        
        msgLabel.snp.makeConstraints({ (make) in
            make.centerY.equalTo(zigiNoFollower)
            make.trailing.equalTo(zigiNoFollower.snp.leading).offset(170)
        })
    }
    
    // FollowerVC - 보여줄 팔로잉이 없는 경우 표시
    func setNoFollowing(_ cell: FollowingTVC, emptyView: UIView) {
        emptyView.backgroundColor = .white
        let maxWidthContainer: CGFloat = 375
        let maxHeightContainer: CGFloat = 350
        
        let zigiNoFollowing = UIImageView()
        zigiNoFollowing.image = #imageLiteral(resourceName: "nuteeLoading_09")
        let maxWidthImage: CGFloat = 512
        let maxHeightImage: CGFloat = 512
        
        let msgLabel = UILabel()
        msgLabel.text = "...팔로잉이 없어요"
        msgLabel.textColor = .black
        msgLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 18)
        msgLabel.font = msgLabel.font.withSize(18)
        msgLabel.textAlignment = .center
        
        cell.addSubview(emptyView)
        emptyView.addSubview(zigiNoFollowing)
        emptyView.addSubview(msgLabel)
        
        emptyView.snp.makeConstraints({ (make) in
            make.width.equalTo(emptyView.snp.height).multipliedBy(maxWidthContainer/maxHeightContainer)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        })
        
        zigiNoFollowing.snp.makeConstraints({ (make) in
            make.width.equalTo(zigiNoFollowing.snp.height).multipliedBy(maxWidthImage/maxHeightImage)
            make.centerY.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        })
        
        msgLabel.snp.makeConstraints({ (make) in
            make.centerY.equalTo(zigiNoFollowing)
            make.trailing.equalTo(zigiNoFollowing.snp.leading).offset(170)
        })
    }
}
