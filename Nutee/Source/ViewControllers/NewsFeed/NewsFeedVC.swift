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
    
    var refreshControl: UIRefreshControl!
    
    // MARK: - Variables and Properties
    
    var newsPostsArr: NewsPostsContent?
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
        setRefresh()
        
        LoadingHUD.show()
        getNewsPostsService(postCnt: 10, lastId: 10, completionHandler: {(returnedData)-> Void in
            self.newsPostsArr = self.newsPosts
            
            self.viewDidAppear(true)
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.newsTV.reloadData()
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
    
    func setRefresh() {
        refreshControl = UIRefreshControl()
        newsTV.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(updatePosts), for: UIControl.Event.valueChanged)
    }
    
    @objc func updatePosts() {
        getNewsPostsService(postCnt: 10, lastId: 0, completionHandler: {(returnedData)-> Void in
            self.newsPostsArr = self.newsPosts
            self.newsTV.reloadData()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.refreshControl.endRefreshing()
            }
        })
        
    }
    
    func loadMorePosts(lastId: Int) {
        if newsPosts?.count != 0 {
            getNewsPostsService(postCnt: 10, lastId: lastId, completionHandler: {(returnedData)-> Void in
                self.newsPostsArr?.append(contentsOf: self.newsPosts!)
                self.newsTV.reloadData()
                self.newsTV.tableFooterView = nil
            })
        } else {
            print("더 이상 불러올 게시글이 없습니다.")
        }
    }
    
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        // UITableView only moves in one direction, y axis
//        let currentOffset = scrollView.contentOffset.y
//        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
//
//        // Change 10.0 to adjust the distance from bottom
//        if maximumOffset - currentOffset <= 10.0 {
//            // 뷰 마지막 부분을 스크롤 하였을 때 작동 코드
//            let spinner = UIActivityIndicatorView()
//
//            newsTV.tableFooterView = spinner
//            newsTV.tableFooterView?.isHidden = false
//            spinner.hidesWhenStopped = true
//
//            spinner.stopAnimating()
//            newsTV.tableFooterView = nil
//        }
//    }
    
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
        let postItems = newsPostsArr?.count ?? 0
        
        return postItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Custom셀인 'NewsFeedCell' 형식으로 생성
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsFeedCell", for: indexPath) as! NewsFeedCell
        
        // 셀 선택시 백그라운드 변경 안되게 하기 위한 코드
        let bgColorView = UIView()
        bgColorView.backgroundColor = nil
        cell.selectedBackgroundView = bgColorView
        cell.addBorder((.bottom), color: .lightGray, thickness: 0.3)
//        cell.addBorder((.top), color: .lightGray, thickness: 1)

        newsPost = newsPostsArr?[indexPath.row]
        // 생성된 Cell클래스로 NewsPost 정보 넘겨주기
        cell.newsPost = self.newsPost
        cell.initPosting()
        
        // VC 컨트롤 권한을 Cell클래스로 넘겨주기
        cell.newsFeedVC = self
        
        NSLog("선택된 cell은 \(indexPath.row) 번쨰 indexPath입니다")
//        print("testetsts : ", cell.newsPost?.id as! Int)
        
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
    
    // 마지막 셀일 때 loadingIndicator와 함께 새로운 cell 정보 로딩
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 로딩된 cell 중 마지막 셀 찾기
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            
            let spinner = UIActivityIndicatorView()
            
            newsTV.tableFooterView = spinner
            newsTV.tableFooterView?.isHidden = false
            
            if newsPosts?.count != 0 {
                // 불러올 포스팅이 있을 경우
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: newsTV.bounds.width, height: CGFloat(44))
                spinner.hidesWhenStopped = true
                newsTV.tableFooterView = spinner
                newsTV.tableFooterView?.isHidden = false

                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    // Loading more data
                    self.loadMorePosts(lastId: self.newsPost!.id)
                }
            } else {
                // 사용자 NewsFeed의 마지막 포스팅일 경우
                self.newsTV.tableFooterView?.isHidden = true
                spinner.stopAnimating()
//                newsTV.tableFooterView = nil
            }

           
        }
    }
    
}

// MARK: - TabBarController
//extension NewsFeedVC : UITabBarControllerDelegate {
//
//    // 탭바를 누를 경우 최상위 지점으로 TableView의 Cell 자동 스크롤(맨 위로 가기)
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
    func getNewsPostsService(postCnt: Int, lastId: Int, completionHandler: @escaping (_ returnedData: NewsPostsContent) -> Void ) {
        ContentService.shared.getNewsPosts(postCnt, lastId: lastId) { responsedata in
            
            switch responsedata {
            case .success(let res):
                let response = res as! NewsPostsContent
                self.newsPosts = response
                print("newsPosts server connect successful")
                
                LoadingHUD.hide()
                completionHandler(self.newsPosts!)
                
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
