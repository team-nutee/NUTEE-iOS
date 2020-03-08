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
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        print("loadView 실행")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        followingTV.delegate = self
        followingTV.dataSource = self
        
        print("viewDidLoad 실행1")
        getFollowingsListService()
        print("viewDidLoad 실행2")
        
        setInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("viewWillAppear 실행")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("viewDidAppear 실행")
    }
    
    // MARK: -Helpers

    // 초기 설정
    func setInit() {

    }
    
    func setDefault() {

    }
}

extension FollowingVC : UITableViewDelegate { }

extension FollowingVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("numberRowSection 실행")
        return followingsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("celForRowAt 실행")
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowingTVC", for: indexPath) as! FollowingTVC
        
        let following = followingsList?[indexPath.row]
        let followingName = following?.nickname ?? "그런 팔로잉 없어요"
        print(followingName)
        cell.followingLabel.text = followingName
        cell.followingLabel.sizeToFit()
        
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
