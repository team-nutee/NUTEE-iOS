//
//  OurInfoTVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/04/19.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class OurInfoTVC: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var partLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var gitBtn: UIButton!
    
    var gitAdress : String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gitBtn.tintColor = .nuteeGreen
        gitBtn.addTarget(self, action: #selector(goGit), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @objc func goGit(){
        if let url = URL(string: gitAdress ?? "") {
            UIApplication.shared.open(url, options: [:])
        }
    }

}
