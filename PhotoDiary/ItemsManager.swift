//
//  ItemsManager.swift
//  PhotoDiary
//
//  Created by MORITANAOKI on 2016/01/08.
//  Copyright © 2016年 molabo. All rights reserved.
//

import UIKit

class ItemsManager {
    static let sharedInstance = ItemsManager()
    var items = [PhotoItem]()
    
    var dataPath = NSHomeDirectory() + "/Documents/items.data"
    
    func loadItems() {
        if let data = NSData(contentsOfFile: dataPath) {
            if let dicts = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [[String: String]] {
                var items = [PhotoItem]()
                for dict in dicts {
                    let item = PhotoItem(dictionary: dict)
                    items.append(item)
                }
                self.items = items
            }
        }
    }
    
    func saveItems() {
        var dicts = [[String: AnyObject]]()
        for item in items {
            dicts.append(item.dictionary())
        }
        
        let archive = NSKeyedArchiver.archivedDataWithRootObject(dicts)
        archive.writeToFile(dataPath, atomically: true)
    }
}