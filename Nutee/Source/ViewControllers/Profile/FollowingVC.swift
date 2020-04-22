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
            tableView.setEmptyView(title: "팔로잉을 해보세요!!", message: "")
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
                
        cell.followingImgView.setImageNutee(followingsList?[indexPath.row].image.src ?? "")
        
        cell.followingLabel.text = followingsList?[indexPath.row].nickname
        cell.followingLabel.sizeToFit()
        
        cell.followingID = followingsList?[indexPath.row].id
        
//        cell.followingDeleteBtn.addTarget(self, action: #selector(getFollowingsListService), for: .touchUpInside)

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFollowingUser = followingsList?[indexPath.row]
        
        let vc = UIStoryboard.init(name: "Profile", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC
        
        vc?.userId = selectedFollowingUser?.id
        
        navigationController?.pushViewController(vc!, animated: true)
    }
}

//MARK: - Followerings 서버 연결을 위한 Service 실행 구간

extension FollowingVC {
    
    @objc func getFollowingsListService() {
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
