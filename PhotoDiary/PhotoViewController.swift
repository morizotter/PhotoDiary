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
    let documentsDir = NSHomeDirectory() + "/Documents"
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let item = item else { return }
        
        let id = item["ID"] as? String ?? ""
        let year = item["YEAR"] as? String ?? ""
        let day = item["DAY"] as? String ?? ""
        navigationItem.title = "\(year) \(day)"
        
        let image = UIImage(contentsOfFile: photoPath(id))
        photoImageView.image = image
    }
    
    func photoPath(id: String) -> String {
        return documentsDir + "/" + id + ".jpg"
    }
}
