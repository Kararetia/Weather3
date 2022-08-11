//
//  CustomTableViewCell.swift
//  Weather2
//
//  Created by Dima  on 02.08.2022.
//

import UIKit
import Foundation

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak private(set) var cityLabel: UILabel!
    @IBOutlet weak private(set) var tempLabel: UILabel!
    @IBOutlet weak private(set) var dateLabel: UILabel!
    
    
    override var reuseIdentifier: String? {
        return "CustomTableViewCell"
    }
    
//    func configure(with model: ForecastData) {
//        self.cityLabel.text = "\(String(model.city))"
//    }
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
