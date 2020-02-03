//
//  NewsFeedVC.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/01/14.
//  Copyright © 2020 Junhyeon. All rights reserved.
//

import UIKit

class NewsFeedVC: UITableViewController {
    
    // <--- 사용자별 포스팅 데이터 입력 구간
    var dataset = {
        ("누티나무", "안녕하세여 2020학년도를 함꼐하게 되어서 반갑습니다"),
        ("S.OWL", "반갑습니다 이번에 새로운 누티 서비스를 선보이게 되었습니다. 많은 이용 바랍니다!")
    }
    
    lazy var newsList: [NewsFeedVO] = {
        var dataNewsList = [NewsFeedVO]()
        
        for(userId, contents) in self.dataset {
            let newsObj = NewsFeedVO()
            newsObj.userId = userId
            newsObj.contents = contents
            dataUserList.append(newsObj)
        }
        return dataNewsList
    }()
    
    override func viewDidLoad() {
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.newsList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsFeedCell")!
        cell.textLabel?.text = row.userId
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 뉴스피드는 \(indexPath.row) 번쨰 뉴스피드입니다")
    }
    
}
