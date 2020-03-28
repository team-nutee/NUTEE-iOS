//
//  FollowingVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/06.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class FollowingVC: UIViewController {
    
    // MARK: - UI components
    @IBOutlet weak var followingTV: UITableView!
    
    // MARK: - Variables and Properties
    
    var followingsList: FollowList?
    var followingsNums = 0 // ProfileVC가 서버에서 받은 팔로잉 개수를 저장할 변수
    
    var noFollowings = UIView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        print("loadView 실행")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFollowingsListService()
        
        followingTV.delegate = self
        followingTV.dataSource = self
        followingTV.separatorInset.left = 0
        followingTV.separatorStyle = .none
        
        self.view.addSubview(noFollowings)
        
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

extension FollowingVC : UITableViewDelegate { }

extension FollowingVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if followingsList?.count == 0 || followingsList?.count == nil {
            return followingTV.frame.height - tabBarController!.tabBar.frame.size.height
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if followingsList?.count == 0 || followingsList?.count == nil {
            return followingTV.frame.height - tabBarController!.tabBar.frame.size.height
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        followingsNums = followingsList?.count ?? 0
        if followingsNums == 0 {
            followingsNums = 1
        }
        
        return followingsNums
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowingTVC", for: indexPath) as! FollowingTVC
        
        cell.selectionStyle = .none
        
        if followingsList?.count == 0 || followingsList?.count == nil {
            followingTV.setNoFollowing(cell, emptyView: noFollowings)
            noFollowings.isHidden = false
            cell.contentsCell.isHidden = true
        } else {
            noFollowings.isHidden = true
            cell.contentsCell.isHidden = false
            
            let following = followingsList?[indexPath.row]
            let followingName = following?.nickname ?? "FollowingError"
            cell.followingLabel.text = followingName
            cell.followingLabel.sizeToFit()
        }
        
        return cell
    }
        
}

//MARK: - Followerings 서버 연결을 위한 Service 실행 구간

extension FollowingVC {
    
    func getFollowingsListService() {
        FollowService.shared.getFollowingsList("6") { responsedata in
            // "6"은 현재 testtest의 서버 내부 아이디 주소 값. 차후 값 넘겨받아 자동으로 id값을 넘길 수 있게 구현 필요.
            
            switch responsedata {
            case .success(let res):
                let response = res as! FollowList
                self.followingsList = response
                print("followingList server connect successful")
                
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
