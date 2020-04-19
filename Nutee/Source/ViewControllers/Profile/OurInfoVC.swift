//
//  OurInfoVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/04/19.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class OurInfoVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    let name : [String] = ["이문혁", "오준현", "임우찬", "김희재", "김은우", "박진수", "정우경", "고병우", "김지원", "박세연"]
    let part : [String] = ["프론트엔드 & 백엔드", "iOS", "백엔드", "iOS", "백엔드", "Android", "QA", "QA", "QA", "QA"]
    let year : [String] = ["2019~","2019~","2019~2020","2019~","2019~","2020~","2020~","2020~","2020~","2020~"]
    let url : [String] = ["MoonHKLee","5anniversary","dladncks1217","iowa329","suuum12","jinsu4755","","kohbwoo","gwonkim","SEYEON-PARK"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.dataSource = self
        tableview.delegate = self
        tableview.separatorInset.left = 0
    }
    
}

extension OurInfoVC : UITableViewDelegate {}

extension OurInfoVC : UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OurInfoTVC", for: indexPath) as! OurInfoTVC
        
        cell.nameLabel.text = name[indexPath.row]
        cell.partLabel.text = part[indexPath.row]
        cell.yearLabel.text = year[indexPath.row]
        cell.gitAdress = "https://github.com/" + url[indexPath.row]
        return cell
    }
    
    
}
