//
//  PhotoCell.swift
//  PhotoDiary
//
//  Created by MORITANAOKI on 2016/01/07.
//  Copyright © 2016年 molabo. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    override func prepareForReuse() {
        photoImageView.image = nil
        yearLabel.text = nil
        dayLabel.text = nil
    }
}
