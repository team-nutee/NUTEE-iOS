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
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowerTVC", for: indexPath) as! FollowerTVC
        
        cell.followerLabel.text = String(indexPath.row) + "번째 팔로워"
        cell.followerLabel.sizeToFit()
        
        return cell

    }
    
    
}
