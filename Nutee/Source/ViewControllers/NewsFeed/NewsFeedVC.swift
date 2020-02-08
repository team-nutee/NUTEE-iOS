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

    @IBAction func btnComment(sender: Any) {
        showDetailNewsFeed()
    }
    
    @IBAction func btnMore(sender: AnyObject) {
        let moreAlert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let editAction = UIAlertAction(title: "수정", style: .default){
            (action: UIAlertAction) in
            // Code to edit
        }
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) {
            (action: UIAlertAction) in
            // Code to delete
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        moreAlert.addAction(editAction)
        moreAlert.addAction(deleteAction)
        moreAlert.addAction(cancelAction)
        self.present(moreAlert, animated: true, completion: nil)
    }
    
    // MARK: - Dummy data
    
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTV.delegate = self
        newsTV.dataSource = self

        initColor()
        
        // Register the custom header view which Nib 'PostingTableHeaderSection'
        let nib = UINib(nibName: "PostingTableHeaderSection", bundle: nil)
        self.newsTV.register(nib, forHeaderFooterViewReuseIdentifier: "PostingTableHeaderSection")
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
    
    func initColor() {
        self.tabBarController?.tabBar.barTintColor = UIColor.nuteeGreen
        self.tabBarController?.tabBar.tintColor = UIColor.white
    }
    
    func showDetailNewsFeed() {
        let detailNewsFeedSB = UIStoryboard(name: "DetailNewsFeed", bundle: nil)
        let showDetailNewsFeedVC = detailNewsFeedSB.instantiateViewController(withIdentifier: "DetailNewsFeed") as! DetailNewsFeedVC
        self.navigationController?.pushViewController(showDetailNewsFeedVC, animated: true)
    }
    
}

// MARK: - UITableView
extension NewsFeedVC : UITableViewDelegate { }

extension NewsFeedVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 480
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Custom셀인 'NewsFeedCell' 형식으로 생성
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsFeedCell", for: indexPath) as! NewsFeedCell
 
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 뉴스피드는 \(indexPath.row) 번쨰 뉴스피드입니다")
        showDetailNewsFeed()
    }

}
