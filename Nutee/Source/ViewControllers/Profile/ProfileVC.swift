//
//  ProfileVC.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/01/14.
//  Copyright © 2020 Junhyeon. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    // MARK: - UI components
    
    @IBOutlet var imgViewUserImage: UIImageView!
    @IBOutlet var lblUserId: UILabel!
    @IBOutlet weak var profileLineView: UIView!
    @IBOutlet weak var profileTV: UITableView!
    
    // MARK: - Variables and Properties
    
    
    // MARK: - Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileTV.delegate = self
        profileTV.dataSource = self
        profileTV.register(UITableView.self, forCellReuseIdentifier: "MyArticleTVC")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         // 네비바 border 삭제
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

    }

    
    // MARK: -Helpers
    
    // 초기 설정
    func setInit() {
        imgViewUserImage.image = UIImage(named: "nutee_zigi")
        lblUserId.text = "zigi"
        
        //        myArticleTV.layer.addBorder([.top], color: .veryLightPink, width: 1)
        imgViewUserImage.setRounded(radius: nil)
        
    }
    
    func setDefault() {
        
    }
    
}

extension ProfileVC : UITableViewDelegate { }

extension ProfileVC : UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyArticleTVC", for: indexPath) as! MyArticleTVC

        cell.articelLabel.text = "테스트입니다"
        cell.backgroundColor = .veryLightPink
        
        return cell
    }
    
    
}

