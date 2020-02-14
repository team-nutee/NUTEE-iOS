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
        newsTV.separatorInset.left = 0
        
        initColor()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
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
    
    func initColor() {
        self.tabBarController?.tabBar.tintColor = .nuteeGreen
    }
    
}

// MARK: - UITableView
extension NewsFeedVC : UITableViewDelegate { }

extension NewsFeedVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 480
//        NSLog(UITableView.automaticDimension.description + "<---MainVC height")
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        NSLog(UITableView.automaticDimension.description + "<---MainVC height")
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let test : [String] = ["","","",""]
        
        return test.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Custom셀인 'NewsFeedCell' 형식으로 생성
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsFeedCell", for: indexPath) as! NewsFeedCell
        cell.newsFeedVC = self
        
        cell.indexPath = indexPath.row
        cell.showImgFrame()
        
        NSLog("선택된 cell은 \(indexPath.row) 번쨰 indexPath입니다")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 뉴스피드는 \(indexPath.row) 번쨰 뉴스피드입니다")
    }

}
