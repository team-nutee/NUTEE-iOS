//
//  FollowingVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/06.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class FollowingVC: UIViewController {
    
    // MARK: - UI components
    @IBOutlet weak var followingTV: UITableView!
    
    // MARK: - Variables and Properties
    
    var followingsList: FollowList?
    var userId = 0
    var followingsNums = 0 // ProfileVC가 서버에서 받은 팔로잉 개수를 저장할 변수
    
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFollowingsListService()
        
        followingTV.delegate = self
        followingTV.dataSource = self
        followingTV.separatorInset.left = 0
        followingTV.separatorStyle = .none
                
    }
    
    // MARK: -Helpers

}

extension FollowingVC : UITableViewDelegate { }

extension FollowingVC : UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        followingsNums = followingsList?.count ?? 0
        if followingsNums == 0 {
            tableView.setEmptyView(title: "팔로워가 없습니다.", message: "")
        } else {
            tableView.restore()
        }
        
        return followingsNums
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowingTVC", for: indexPath) as! FollowingTVC
        
        cell.selectionStyle = .none
        
        let myID = KeychainWrapper.standard.integer(forKey: "id")
        
        if myID == userId {
            cell.followingDeleteBtn.isHidden = false
        } else {
            cell.followingDeleteBtn.isHidden = true
        }
        
        print("img", followingsList?[indexPath.row].image.src)
        if followingsList?[indexPath.row].image.src == "" {
        cell.followingImgView.imageFromUrl("http://15.164.50.161:9425/settings/nutee_profile.png", defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")
        }else{
        cell.followingImgView.imageFromUrl((APIConstants.BaseURL) + "/" + (followingsList?[indexPath.row].image.src ?? ""), defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")
        }
        
        cell.followingLabel.text = followingsList?[indexPath.row].nickname
        cell.followingLabel.sizeToFit()
        
        return cell
    }
        
}

//MARK: - Followerings 서버 연결을 위한 Service 실행 구간

extension FollowingVC {
    
    func getFollowingsListService() {
        FollowService.shared.getFollowingsList(userId) { responsedata in
            
            switch responsedata {
            case .success(let res):
                let response = res as! FollowList
                self.followingsList = response
                
                self.followingTV.reloadData()
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
