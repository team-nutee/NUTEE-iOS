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

    }
    
    // MARK: - Helper
    
    
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
        cell.newsPost = self.newsPost

        return cell
    }
    
    
}


extension SearchResultVC {
    
}
