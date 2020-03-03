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
    
    var newsPosts: NewsPostsContent?
    var newsPost: NewsPostsContentElement?
    
    // MARK: - Dummy data
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTV.delegate = self
        newsTV.dataSource = self
        newsTV.separatorInset.left = 0
        newsTV.separatorStyle = .none
        
//        self.tabBarController?.delegate = self
                
        initColor()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        getNewsPostsService(postCnt: 10)
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

        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsPosts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Custom셀인 'NewsFeedCell' 형식으로 생성
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsFeedCell", for: indexPath) as! NewsFeedCell

        
        // 셀 선택시 백그라운드 변경 안되게 하기 위한 코드
        let bgColorView = UIView()
        bgColorView.backgroundColor = nil
        cell.selectedBackgroundView = bgColorView
        cell.addBorder((.bottom), color: .lightGray, thickness: 0.1)
//        cell.addBorder((.top), color: .lightGray, thickness: 1)

        newsPost = newsPosts?[indexPath.row]
        // 생성된 Cell클래스로 NewsPost 정보 넘겨주기
        cell.newsPost = self.newsPost
        cell.initPosting()
        
        // VC 컨트롤 권한을 Cell클래스로 넘겨주기
        cell.newsFeedVC = self
        
        NSLog("선택된 cell은 \(indexPath.row) 번쨰 indexPath입니다")
//        print("testetsts : ", cell.newsPost?.id as! Int)
        print("")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsFeedCell", for: indexPath) as! NewsFeedCell
   
        let detailNewsFeedSB = UIStoryboard(name: "DetailNewsFeed", bundle: nil)
        let showDetailNewsFeedVC = detailNewsFeedSB.instantiateViewController(withIdentifier: "DetailNewsFeed") as! DetailNewsFeedVC
//        print("testetsts : ", cell.newsPost?.id as! Int)
        showDetailNewsFeedVC.contentId = cell.contentId
        
        self.navigationController?.pushViewController(showDetailNewsFeedVC, animated: true)
    }

}

// MARK: - TabBarController
//extension NewsFeedVC : UITabBarControllerDelegate {
//
//    // 탭바를 누를 경우 최상위 내용으로 TableView의 Cell 자동 스크롤(맨 위로 가기)
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        let tabBarIndex = tabBarController.selectedIndex
//
//        print("You tapped tabBarItem index : ", tabBarIndex)
//
//        if tabBarIndex == 0 {
////            self.newsTV.setContentOffset(CGPoint.zero, animated: true)
//            let indexPath = IndexPath(row: 0, section: 0)
//            newsTV.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
//        }
//    }
//
//}

extension NewsFeedVC {
    func getNewsPostsService(postCnt: Int) {
        ContentService.shared.getNewsPosts(postCnt) { responsedata in
            
            switch responsedata {
            case .success(let res):
                let response = res as! NewsPostsContent
                self.newsPosts = response
                print("newsPosts server connect successful")
                
                self.newsTV.reloadData()
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
