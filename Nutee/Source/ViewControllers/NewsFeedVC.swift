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
    
    var dataset = [
        ("누티나무", "안녕하세여 2020학년도를 함께하게 되어서 반갑습니다. 수강신청과 관련된 공지사항은 하단에 알림마당 탭을 이용하여 확인해주십시오.", "nutee_img.png", "2시간 전"),
        ("S.OWL", "반갑습니다 이번에 새로운 누티 서비스를 선보이게 되었습니다. 많은 이용 바랍니다!", "S_OWL_img.png", "어제 오후 12:01"),
    ]
    
    lazy var newsList: [NewsFeedVO] = {
        var dataNewsList = [NewsFeedVO]()
        
        for(userId, contents, userImg, postTime) in self.dataset {
            let newsObj = NewsFeedVO()
            newsObj.userId = userId
            newsObj.contents = contents
            newsObj.userImg = userImg
            newsObj.postTime = postTime
            dataNewsList.append(newsObj)
        }
        return dataNewsList
    }()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        
        newsTV.delegate = self
        newsTV.dataSource = self
    
    }
    
}

// MARK: - UITableView
extension NewsFeedVC : UITableViewDelegate { }

extension NewsFeedVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row : [NewsFeedVO] = newsList
        
        //Custom셀인 'NewsFeedCell' 형식으로 변환
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsFeedCell", for: indexPath) as! NewsFeedCell
        
        //데이터 소스에 저장된 값을 커스텀 한 NewsFeedCell의 아울렛 변수들에게 전달
        cell.lblUserId.text = row[indexPath.row].userId
        cell.lblContents.text = row[indexPath.row].contents
        cell.imgUserImg.image = UIImage(named: row[indexPath.row].userImg!)
        cell.lblPostTime.text = row[indexPath.row].postTime
        
//        텍스트 레이블 자동 높이 조절 구현 코드. but 작동 실패
//        let height = (60 + (row[indexPath.row].contents!.count / 30) * 20)
//        cell.lblContents?.numberOfLines = height
//        cell.lblContents?.numberOfLines = 0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 뉴스피드는 \(indexPath.row) 번쨰 뉴스피드입니다")
    }
    
}
