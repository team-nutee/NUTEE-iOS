//
//  CafeteriaTTableViewCell.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/10.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class CafeteriaTVC: UITableViewCell {

    @IBOutlet weak var meal1TextView: UITextView!
    @IBOutlet weak var meal2TextView: UITextView!
    @IBOutlet weak var meal3TextView: UITextView!
    @IBOutlet weak var dayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        meal1TextView.translatesAutoresizingMaskIntoConstraints = false
        meal1TextView.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 10).isActive = true
        meal1TextView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        meal1TextView.heightAnchor.constraint(equalToConstant: contentView.bounds.height).isActive = true
        meal1TextView.widthAnchor.constraint(equalToConstant: (contentView.bounds.width-20)/3).isActive = true
        
        meal2TextView.translatesAutoresizingMaskIntoConstraints = false
        meal2TextView.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 10).isActive = true
        meal2TextView.leftAnchor.constraint(equalTo: meal1TextView.rightAnchor, constant: 5).isActive = true
        meal2TextView.heightAnchor.constraint(equalToConstant: contentView.bounds.height).isActive = true
        meal2TextView.widthAnchor.constraint(equalToConstant: (contentView.bounds.width-20)/3).isActive = true
        
        meal3TextView.translatesAutoresizingMaskIntoConstraints = false
        meal3TextView.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 10).isActive = true
        meal3TextView.leftAnchor.constraint(equalTo: meal2TextView.rightAnchor, constant: 5).isActive = true
        meal3TextView.heightAnchor.constraint(equalToConstant: contentView.bounds.height).isActive = true
        meal3TextView.widthAnchor.constraint(equalToConstant: (contentView.bounds.width-20)/3).isActive = true
        
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20 ).isActive = true
        dayLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        dayLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        dayLabel.widthAnchor.constraint(equalToConstant: (contentView.bounds.width)).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
