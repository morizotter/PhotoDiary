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
        
        navigationItem.title = item?.yearString
        photoImageView.image = item?.image
    }
}
