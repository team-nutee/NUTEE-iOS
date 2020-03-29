//
//  FollowerVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/06.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit
import Alamofire

class FollowerVC: UIViewController {
    
    // MARK: - UI components
    @IBOutlet weak var followerTV: UITableView!
    
    // MARK: - Variables and Properties
    
    var followersList: FollowList?
    var userId = 0
    var followersNums = 0 // ProfileVC가 서버에서 받은 팔로워 개수를 저장할 변수
    
    var noFollowers = UIView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFollowersListService()
        
        followerTV.delegate = self
        followerTV.dataSource = self
        followerTV.separatorInset.left = 0
        followerTV.separatorStyle = .none
        
        self.view.addSubview(noFollowers)
        
        setInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    // MARK: -Helpers

    // 초기 설정
    func setInit() {}
    
    func setDefault() {}
}

extension FollowerVC : UITableViewDelegate { }

extension FollowerVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if followersList?.count == 0 || followersList?.count == nil {
            return followerTV.frame.height - tabBarController!.tabBar.frame.size.height
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if followersList?.count == 0 || followersList?.count == nil {
            return followerTV.frame.height - tabBarController!.tabBar.frame.size.height
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        followersNums = followersList?.count ?? 0
        if followersNums == 0 {
            followersNums = 1
        }
        
        return followersNums
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowerTVC", for: indexPath) as! FollowerTVC
        
        cell.selectionStyle = .none
        
        if followersList?.count == 0 || followersList?.count == nil {
            followerTV.setNoFollower(cell, emptyView: noFollowers)
            noFollowers.isHidden = false
            cell.contentsCell.isHidden = true
        } else {
            noFollowers.isHidden = true
            cell.contentsCell.isHidden = false
            
            let follower = followersList?[indexPath.row]
            let followerName = follower?.nickname ?? "FollowerError"
            cell.followerLabel.text = followerName
            cell.followerLabel.sizeToFit()
        }
        
        return cell
    }
    
}

//MARK: - FollowersList 서버 연결을 위한 Service 실행 구간

extension FollowerVC {
    func getFollowersListService() {
        FollowService.shared.getFollowersList(userId) { responsedata in
            
            switch responsedata {
            case .success(let res):
                let response = res as! FollowList
                self.followersList = response
                print("followerList server connect successful")
                
                self.followerTV.reloadData()
            case .requestErr(_):
                print("request error")
            
            case .pathErr:
                print(".pathErr")
            
            case .serverErr:
                print(".serverErr")
            
            case .networkFail :
                print("failure")
                }
        }
        
    }

}
