//
//  FollowerVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/06.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class FollowerVC: UIViewController {
    
    // MARK: - UI components
    @IBOutlet weak var followerTV: UITableView!
    
    // MARK: - Variables and Properties
    
    var followersList: FollowersList?
    var followersNums = 0 // ProfileVC가 서버에서 받은 팔로워 개수를 저장할 변수
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFollowersListService()
        
        followerTV.delegate = self
        followerTV.dataSource = self
        
        
        setInit()
    }
    
    // MARK: -Helpers

    // 초기 설정
    func setInit() {

    }
    
    func setDefault() {

    }
}

extension FollowerVC : UITableViewDelegate { }

extension FollowerVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return followersNums
        return followersList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowerTVC", for: indexPath) as! FollowerTVC
        
        let follower = followersList?[indexPath.row]
        let followerName = follower?.nickname ?? "그런 사람 없어요"
        cell.followerLabel.text = followerName
        cell.followerLabel.sizeToFit()
        
        return cell

    }
    
    
}

extension FollowerVC {
    func getFollowersListService() {
        FollowersService.shared.getFollowersList("6") { responsedata in
            // "6"은 현재 testtest의 서버 내부 아이디 주소 값. 차후 값 넘겨받아 자동으로 id값을 넘길 수 있게 구현 필요.
            
            switch responsedata {
            case .success(let res):
                let response = res as! FollowersList
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
