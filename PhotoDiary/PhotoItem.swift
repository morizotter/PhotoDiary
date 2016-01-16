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
    let yearString: String
    let dayString: String
    var image: UIImage?
    
    var imagePath: String {
        return NSHomeDirectory() + "/Documents/\(id).jpg"
    }
    
    init(image: UIImage) {
        self.id = NSUUID().UUIDString
        self.image = image
        
        let now = NSDate()
        let yearFormatter = NSDateFormatter()
        yearFormatter.dateFormat = "yyyy"
        self.yearString = yearFormatter.stringFromDate(now)
        
        let dayFormatter = NSDateFormatter()
        dayFormatter.dateFormat = "M/d"
        self.dayString = dayFormatter.stringFromDate(now)
    }
    
    init(dictionary: [String: AnyObject]) {
        self.id = dictionary["ID"] as! String
        self.yearString = dictionary["YEAR"] as! String
        self.dayString = dictionary["DAY"] as! String
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
        dict["YEAR"] = yearString
        dict["DAY"] = dayString
        return dict
    }
}