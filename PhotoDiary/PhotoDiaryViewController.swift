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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ItemsManager.sharedInstance.items.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let item = ItemsManager.sharedInstance.items[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCell
        cell.photoImageView.image = item.image
        cell.yearLabel.text = item.yearString
        cell.dayLabel.text = item.dayString
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let length = CGFloat(floor(UIScreen.mainScreen().bounds.width / 3.0))
        return CGSize(width: length, height: length)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PhotoViewController") as! PhotoViewController
        vc.item = ItemsManager.sharedInstance.items[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func photoButtonTapped(sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .Camera
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            dismissViewControllerAnimated(true) { [weak self] () -> Void in
                guard let s = self else { return }
                let photoItem = PhotoItem(image: image)
                ItemsManager.sharedInstance.items.append(photoItem)
                s.collectionView.reloadData()
            }
        }
    }
}

