//
//  NewsFeedVC.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/01/14.
//  Copyright © 2020 Junhyeon. All rights reserved.
//

import UIKit

class NewsFeedVC: UIViewController {
    
    // MARK: - UI components
        
    @IBOutlet var newsTV: UITableView!
    
    // MARK: - Variables and Properties

    
    // MARK: - Dummy data
    
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTV.delegate = self
        newsTV.dataSource = self

        initColor()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
//        checkLogin()
    }
    
    // MARK: -Helper
    
    // 로그인이 되어있는지 체크
    func checkLogin() {
        if UserDefaults.standard.data(forKey: "Cookies") == nil {
            
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "LoginVC") as! LoginVC
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            
            self.present(vc, animated: true, completion: nil)
        }
    }
    
}

// MARK: - UITableView
extension NewsFeedVC : UITableViewDelegate { }

extension NewsFeedVC : UITableViewDataSource {
    
    func initColor() {
        self.tabBarController?.tabBar.barTintColor = UIColor.nuteeGreen
        self.tabBarController?.tabBar.tintColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Custom셀인 'NewsFeedCell' 형식으로 변환
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsFeedCell", for: indexPath) as! NewsFeedCell
        
        if indexPath.row % 2 == 1 {
            cell.backgroundColor = .lightGray
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 뉴스피드는 \(indexPath.row) 번쨰 뉴스피드입니다")
        
        let detailNewsFeedSB = UIStoryboard(name: "DetailNewsFeed", bundle: nil)
        let showDetailNewsFeedVC = detailNewsFeedSB.instantiateViewController(withIdentifier: "DetailNewsFeed") as! DetailNewsFeedVC
        self.navigationController?.pushViewController(showDetailNewsFeedVC, animated: true)
    }
    
}
