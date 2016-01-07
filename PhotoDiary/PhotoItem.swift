//
//  PhotoItem.swift
//  PhotoDiary
//
//  Created by MORITANAOKI on 2016/01/07.
//  Copyright © 2016年 molabo. All rights reserved.
//

import UIKit

struct PhotoItem {
    let id: String
    let dateString: String
    var image: UIImage?
    
    var imagePath: String {
        return NSHomeDirectory() + "/Documents/\(id).jpg"
    }
    
    init(image: UIImage) {
        self.id = NSUUID().UUIDString
        self.image = image
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy年M月d日 H:mm:ss"
        self.dateString = formatter.stringFromDate(NSDate())
    }
    
    init(dictionary: [String: AnyObject]) {
        self.id = dictionary["ID"] as! String
        self.dateString = dictionary["DATE"] as! String
        self.image = UIImage(contentsOfFile: imagePath)
    }
    
    func dictionary() -> [String: AnyObject] {
        if let image = image {
            let data = UIImageJPEGRepresentation(image, 0.7)
            if !NSFileManager.defaultManager().fileExistsAtPath(imagePath) {
                data?.writeToFile(imagePath, atomically: true)
            }
        }
        
        var dict = [String: AnyObject]()
        dict["ID"] = id
        dict["DATE"] = dateString
        return dict
    }
}