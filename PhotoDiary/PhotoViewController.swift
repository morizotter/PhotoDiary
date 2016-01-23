//
//  PhotoViewController.swift
//  PhotoDiary
//
//  Created by MORITANAOKI on 2016/01/08.
//  Copyright © 2016年 molabo. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    var item: [String: AnyObject]?
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let item = item else { return }
        
        let year = item["YEAR"] as? String ?? ""
        let day = item["DAY"] as? String ?? ""
        navigationItem.title = "\(year) \(day)"
        
        if let imagePath = item["IMAGE_PATH"] as? String {
            let image = UIImage(contentsOfFile: imagePath)
            photoImageView.image = image
        }
    }
}
