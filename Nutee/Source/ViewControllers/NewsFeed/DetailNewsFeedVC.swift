//
//  detailNewsFeedVC.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/01/30.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class DetailNewsFeedVC: UIViewController {
    
    //MARK: - UI components
    
    @IBOutlet var newsTV: UITableView!
    
    //MARK: - Variables and Properties
    
    var indexPath = 0
    //MARK: - Dummy data
    
    //MARK: - Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTV.delegate = self
        newsTV.dataSource = self
        
        //        loadSelectedNewsFeed()
        
        // Register the custom header view which Nib 'NewsFeedTableHeaderSection'
        let nib = UINib(nibName: "NewsFeedTableHeaderSection", bundle: nil)
        self.newsTV.register(nib, forHeaderFooterViewReuseIdentifier: "NewsFeedTableHeaderSection")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

    }
    
}

//MARK: - data
extension DetailNewsFeedVC : UITableViewDelegate { }

extension DetailNewsFeedVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        // Dequeue with the reuse identifier
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "NewsFeedTableHeaderSection")
//        cell.detailNew = self
//        cell.indexPath = self.indexPath
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
////        return 700
//        return UITableView.automaticDimension
//    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let test : [String] = ["","","","",""]
        
        return test.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Custom셀인 'ReplyCell' 형식으로 변환
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReplyCell", for: indexPath) as! ReplyCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 댓글은 \(indexPath.row) 번쨰 댓글입니다")
    }
    
}
