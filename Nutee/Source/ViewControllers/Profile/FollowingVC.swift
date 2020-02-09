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
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        followingTV.delegate = self
        followingTV.dataSource = self
        
        setInit()
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
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowingTVC", for: indexPath) as! FollowingTVC
        
        cell.followingLabel.text = String(indexPath.row) + "번째 팔로잉"
        cell.followingLabel.sizeToFit()
        
        return cell
    }
    
    
}
