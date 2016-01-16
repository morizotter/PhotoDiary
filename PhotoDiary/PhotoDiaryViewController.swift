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
    let dataPath = NSHomeDirectory() + "/Documents/items.data"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "saveItems:", name: UIApplicationWillTerminateNotification, object: nil)
    }
    
    func loadItems() {
        guard let data = NSData(contentsOfFile: dataPath) else { return }
        guard let items = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [[String: AnyObject]] else { return }
        self.items = items
    }
    
    @objc
    func saveItems(notification: NSNotification) {
        let archive = NSKeyedArchiver.archivedDataWithRootObject(items)
        archive.writeToFile(dataPath, atomically: true)
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCell
        cell.photoImageView.image = item["IMAGE"] as? UIImage
        cell.yearLabel.text = item["YEAR"] as? String
        cell.dayLabel.text = item["DAY"] as? String
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
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            dismissViewControllerAnimated(true) { [weak self] () -> Void in
                guard let s = self else { return }
                
                let now = NSDate()
                let yearFormatter = NSDateFormatter()
                yearFormatter.dateFormat = "yyyy"
                let dayFormatter = NSDateFormatter()
                dayFormatter.dateFormat = "M/d"
                
                let dict: [String: AnyObject] = [
                    "ID": NSUUID().UUIDString,
                    "YEAR": yearFormatter.stringFromDate(now),
                    "DAY": dayFormatter.stringFromDate(now),
                    "IMAGE": image
                ]
                
                s.items.append(dict)
                s.collectionView.reloadData()
            }
        }
    }
}