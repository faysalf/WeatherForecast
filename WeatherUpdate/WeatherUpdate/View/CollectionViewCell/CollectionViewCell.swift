//
//  CollectionViewCell.swift
//  WeatherUpdate
//
//  Created by Md. Faysal Ahmed on 25/11/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var fareheit: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
