//
//  TableViewCell.swift
//  WeatherUpdate
//
//  Created by Md. Faysal Ahmed on 25/11/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var maxTemp: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
