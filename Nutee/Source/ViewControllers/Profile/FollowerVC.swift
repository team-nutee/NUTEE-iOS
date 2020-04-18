//
//  FollowerVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/06.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper

class FollowerVC: UIViewController {
    
    // MARK: - UI components
    @IBOutlet weak var followerTV: UITableView!
    
    // MARK: - Variables and Properties
    
    var followersList: FollowList?
    var userId = 0
    var followersNums = 0 // ProfileVC가 서버에서 받은 팔로워 개수를 저장할 변수
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFollowersListService()
        
        followerTV.delegate = self
        followerTV.dataSource = self
        followerTV.separatorInset.left = 0
        followerTV.separatorStyle = .none
        
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
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        followersNums = followersList?.count ?? 0
        if followersNums == 0 {
            tableView.setEmptyView(title: "팔로워가 없습니다.", message: "")
        } else {
            tableView.restore()
        }
        
        return followersNums
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowerTVC", for: indexPath) as! FollowerTVC
        
        cell.selectionStyle = .none
        
        let myID = KeychainWrapper.standard.integer(forKey: "id")
        
        if myID == userId {
            cell.followerDeleteBtn.isHidden = false
        } else {
            cell.followerDeleteBtn.isHidden = true
        }
        
//      To do 이미지 변경 확인한 이후 삭제
//        if followersList?[indexPath.row].image.src == "" {
//        cell.followerImgView.imageFromUrl("http://15.164.50.161:9425/settings/nutee_profile.png", defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")
//        } else {
//        cell.followerImgView.imageFromUrl((APIConstants.BaseURL) + "/" + (followersList?[indexPath.row].image.src ?? ""), defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")
//        }
        
        cell.followerImgView.setImageNutee(followersList?[indexPath.row].image.src ?? "")
        cell.followerLabel.text = followersList?[indexPath.row].nickname
        cell.followerLabel.sizeToFit()
        
        cell.followerID = followersList?[indexPath.row].id
        
        cell.followerDeleteBtn.addTarget(self, action: #selector(getFollowersListService), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFollowerUser = followersList?[indexPath.row]
        
        let vc = UIStoryboard.init(name: "Profile", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC
        
        vc?.userId = selectedFollowerUser?.id
        
        navigationController?.pushViewController(vc!, animated: true)
    }
    
}

//MARK: - FollowersList 서버 연결을 위한 Service 실행 구간

extension FollowerVC {
    @objc func getFollowersListService() {
        FollowService.shared.getFollowersList(userId) { responsedata in
            
            switch responsedata {
            case .success(let res):
                let response = res as! FollowList
                self.followersList = response
                
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
    
    @objc func deleteFollowerService(_ id : Int) {
        FollowService.shared.deleteFollow(id) { responsedata in
            
            switch responsedata {
                
            case .success(_):
                print("succests")
                self.getFollowersListService()
                
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
