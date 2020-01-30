//
//  detailNewsFeedVC.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/01/30.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class detailNewsFeedVC: UIViewController {
    
    //MARK: - UI components
    
    @IBOutlet var imgUserImg: UIImageView!
    @IBOutlet var lblUserId: UILabel!
    @IBOutlet var lblPostTime: UILabel!
    @IBOutlet var lblContents: UILabel!
    @IBOutlet var imgPostImg: UIImageView!
    
    //MARK: - Variables and Properties
    
    //MARK: - Dummy data
    
    //MARK: - Life Cycle
    
    
    override func viewDidLoad() {
        loadSelectedNewsFeed()
    }

    
    //MARK: - data
    func loadSelectedNewsFeed() {
        let cell = NewsFeedCell()
        self.imgUserImg = cell.imgUserImg
        self.lblUserId.text = cell.lblUserId?.text
        self.lblPostTime.text = cell.lblPostTime?.text
        self.lblContents.text = cell.lblContents?.text
    }
}
