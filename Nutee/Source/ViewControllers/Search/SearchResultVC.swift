//
//  SearchResultVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/04/03.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class SearchResultVC: UIViewController {
    
    // MARK: - UI components
    @IBOutlet weak var SearchTV: UITableView!
    
    
    // MARK: - Variables and Properties
    
    var searchResult: String?
    var newsPostsArr: NewsPostsContent?
    var newsPosts: NewsPostsContent?
    var newsPost: NewsPostsContentElement?

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchTV.delegate = self
        SearchTV.dataSource = self
        SearchTV.separatorInset.left = 0
        SearchTV.register(UINib(nibName: "FeedTVC", bundle: nil), forCellReuseIdentifier: "FeedTVC")
        searchService(text: searchResult!,
                      postCnt: 10,
                      lastID: 0,
                      completionHandler: {(returnedData) -> Void in
                        self.newsPostsArr = self.newsPosts
                        self.SearchTV.reloadData()
        })
        
        self.navigationItem.title = searchResult

    }
    
    // MARK: - Helper
    
    func loadMorePosts(lastId: Int) {
        if newsPosts?.count != 0 {
            searchService(text: searchResult!, postCnt: 10, lastID: lastId, completionHandler: {(returnedData)-> Void in
                self.newsPostsArr?.append(contentsOf: self.newsPosts!)
                self.SearchTV.reloadData()
                self.SearchTV.tableFooterView = nil
            })
        } else {
            print("더 이상 불러올 게시글이 없습니다.")
        }
    }

}

// MARK: - extension에 따라 적당한 명칭 작성
extension SearchResultVC : UITableViewDelegate { }
extension SearchResultVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let postItems = newsPostsArr?.count ?? 0
        
        if postItems == 0 {
            SearchTV.setEmptyView(title: searchResult!, message: "에 대한 검색 결과가 없습니다")
        } else {
            SearchTV.restore()
        }

        return postItems
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                    
        return UITableView.automaticDimension
    }

        
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTVC", for: indexPath) as! FeedTVC
       
        newsPost = newsPostsArr?[indexPath.row]
        
        // 셀 선택시 백그라운드 변경 안되게 하기 위한 코드
        cell.addBorder((.bottom), color: .lightGray, thickness: 0.3)
        cell.selectionStyle = .none

        
        cell.newsPost = self.newsPost
        cell.initPosting()
        
        // VC 컨트롤 권한을 Cell클래스로 넘겨주기
        cell.newsFeedVC = self
        
        // 사용자 프로필 이미지 탭 인식 설정
        cell.setClickActions()
        

        return cell
    }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // DetailNewsFeed 창으로 전환
            let detailNewsFeedSB = UIStoryboard(name: "DetailNewsFeed", bundle: nil)
            let showDetailNewsFeedVC = detailNewsFeedSB.instantiateViewController(withIdentifier: "DetailNewsFeed") as! DetailNewsFeedVC

            // 현재 게시물 id를 DetailNewsFeedVC로 넘겨줌
            showDetailNewsFeedVC.postId = newsPostsArr?[indexPath.row].id
            showDetailNewsFeedVC.getPostService(postId: showDetailNewsFeedVC.postId!, completionHandler: {(returnedData)-> Void in
                showDetailNewsFeedVC.replyTV.reloadData()
            })
            
            self.navigationController?.pushViewController(showDetailNewsFeedVC, animated: true)
        }
        
        // 마지막 셀일 때 ActivateIndicator와 함께 새로운 cell 정보 로딩
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            // 로딩된 cell 중 마지막 셀 찾기
            let lastSectionIndex = tableView.numberOfSections - 1
            let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
            if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
                
                let spinner = UIActivityIndicatorView()
                
                SearchTV.tableFooterView = spinner
                SearchTV.tableFooterView?.isHidden = false
                
                if newsPosts?.count != 0 && newsPosts?.count != nil {
                    // 불러올 포스팅이 있을 경우
                    spinner.startAnimating()
                    spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: SearchTV.bounds.width, height: CGFloat(44))
                    spinner.hidesWhenStopped = true
                    SearchTV.tableFooterView = spinner
                    SearchTV.tableFooterView?.isHidden = false

                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.loadMorePosts(lastId: self.newsPost?.id ?? 0)
                    }
                } else {
                    // 사용자 NewsFeed의 마지막 포스팅일 경우
                    self.SearchTV.tableFooterView?.isHidden = true
                    spinner.stopAnimating()
    //                newsTV.tableFooterView = nil
                }

               
            }
        }

    
}


extension SearchResultVC {
    func searchService(text: String, postCnt: Int, lastID: Int, completionHandler: @escaping (_ returnedData: NewsPostsContent) -> Void ) {
        ContentService.shared.searchPost(text: text, postCnt: postCnt, lastId: lastID) { responsedata in
            
            switch responsedata {
                
            case .success(let res):
                self.newsPosts = (res as! NewsPostsContent)

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
