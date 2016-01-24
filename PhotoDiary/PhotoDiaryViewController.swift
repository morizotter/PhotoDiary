//
//  PhotoDiaryViewController.swift
//  PhotoDiary
//
//  Created by MORITANAOKI on 2016/01/07.
//  Copyright © 2016年 molabo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var photoButton: UIButton!
    
    var items = [[String: AnyObject]]()
    let documentsDir = NSHomeDirectory() + "/Documents"
    let dataFileName = "items.data"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "saveItems:", name: UIApplicationWillTerminateNotification, object: nil)
    }
    
    func dataPath() -> String {
        return documentsDir + "/" + dataFileName
    }
    
    func photoPath(id: String) -> String {
        return documentsDir + "/" + id + ".jpg"
    }
    
    func loadItems() {
        guard let data = NSData(contentsOfFile: dataPath()) else { return }
        guard let items = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [[String: AnyObject]] else {
            return
        }
        self.items = items
    }
    
    @objc
    func saveItems(notification: NSNotification) {
        let archive = NSKeyedArchiver.archivedDataWithRootObject(items)
        archive.writeToFile(dataPath(), atomically: true)
    }
    
    @IBAction func photoButtonTapped(sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .Camera
        presentViewController(picker, animated: true, completion: nil)
    }
    
    // MARK:-
    // MARK:UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        let id = item["ID"] as? String ?? ""
        let year = item["YEAR"] as? String
        let day = item["DAY"] as? String
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCell
        cell.yearLabel.text = year
        cell.dayLabel.text = day
        
        let image = UIImage(contentsOfFile: photoPath(id))
        cell.photoImageView.image = image
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let length = CGFloat(floor(UIScreen.mainScreen().bounds.width / 3.0))
        return CGSize(width: length, height: length)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PhotoViewController") as! PhotoViewController
        vc.item = items[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK:-
    // MARK:UIImagePickerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        guard let imageData = UIImageJPEGRepresentation(image, 0.7) else { return }
        
        let uuid = NSUUID().UUIDString
        imageData.writeToFile(photoPath(uuid), atomically: true)
        
        let now = NSDate()
        let yearFormatter = NSDateFormatter()
        yearFormatter.dateFormat = "yyyy"
        let year = yearFormatter.stringFromDate(now)
        
        let dayFormatter = NSDateFormatter()
        dayFormatter.dateFormat = "M/d"
        let day = dayFormatter.stringFromDate(now)
        
        let dict: [String: AnyObject] = [
            "ID": uuid,
            "YEAR": year,
            "DAY": day,
        ]
        
        items.append(dict)
        collectionView.reloadData()
    }
}