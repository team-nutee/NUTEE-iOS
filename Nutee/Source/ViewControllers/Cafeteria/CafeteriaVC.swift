//
//  CafeteriaVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/04.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

struct Food {
    let date: String
    let day: String
    let dinner : [String]
    let launch : [String]
}

class CafeteriaVC: UIViewController {
    
    // MARK: - UI components
    
    @IBOutlet weak var cafeteriaTV: UITableView!
    
    // MARK: - Variables and Properties
    
    var test : [Food] = []
    var inside : [String] = ["햄버거\n햄버거\n햄버거\n","햄버거\n햄버거\n햄버거\n","햄버거\n햄버거\n햄버거\n","햄버거\n햄버거\n햄버거\n","햄버거\n햄버거\n햄버거\n"]
    var inside2 : [String] = ["피자\n피자\n피자\n","피자\n피자\n피자\n","피자\n피자\n피자\n","피자\n피자\n피자\n","피자\n피자\n피자\n"]
    var inside3 : [String] = ["가나다라마사바\n가나다라마사바\n가나다라마사바\n","가나다라마사바\n가나다라마사바\n가나다라마사바\n","가나다라마사바\n가나다라마사바\n가나다라마사바\n","가나다라마사바\n가나다라마사바\n가나다라마사바\n","가나다라마사바\n가나다라마사바\n가나다라마사바\n"]

    // MARK: - Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cafeteriaTV.delegate = self
        cafeteriaTV.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // 네비바 border 삭제
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    
    // MARK: -Helpers
    
    
    
    
    
}

// MARK: - UITableView
extension CafeteriaVC : UITableViewDelegate { }

extension CafeteriaVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inside.count == 0{
            tableView.setEmptyView(title: "이번주 식단이 올라오지 않았습니다", message: "")
        } else {
            tableView.restore()
        }
        return inside.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CafeteriaTVC", for: indexPath) as! CafeteriaTVC
        
        cell.meal1TextView.text = "중식\n\n"+inside[indexPath.row]
        cell.meal2TextView.text = "분식\n\n"+inside2[indexPath.row]
        cell.meal3TextView.text = "석식\n\n"+inside3[indexPath.row]

        
        return cell
    }
    
}

