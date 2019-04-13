//
//  ForecastTableViewCell.swift
//  Weahter Pro
//
//  Created by Shayan on 12/12/18.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var conditionImage: UIImageView!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
