//
//  PhotoViewController.swift
//  PhotoDiary
//
//  Created by MORITANAOKI on 2016/01/08.
//  Copyright © 2016年 molabo. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    var item: PhotoItem?
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let item = item else { return }
        
        navigationItem.title = item.yearString + item.dayString
        photoImageView.image = item.image
    }
}
