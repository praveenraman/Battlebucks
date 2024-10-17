//
//  PhotoDetailViewController.swift
//  Battlebucks
//
//  Created by Praveen Kumar on 16/10/24.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    var photoData = [PhotosData]()
    var currentPid: Int!
    
    @IBOutlet weak var img: ImageViewHandler!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeRight.direction = .right
            self.view.addGestureRecognizer(swipeRight)

            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeLeft.direction = .left
            self.view.addGestureRecognizer(swipeLeft)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadImage()
    }
    
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                self.Previous()
            case .left:
                self.Next()
            default:
                break
            }
        }
    }
    
    func loadImage(){
        let data = loadCurrentPhotoData(photoData: photoData)
        img.loadAsyncFrom(url: data.url ?? "", placeholder:  UIImage(named: "User"))
        titleLbl.text = data.title?.capitalized
    }
    /*
    func loadCurrentImage(photoData: [PhotosData])-> String{
        var imgUrl = ""
        let _: [()] = photoData.filter{$0.id == currentPid}.compactMap { photo in
            imgUrl = photo.url ?? ""
        }
        return imgUrl
    }
    */
    
    func loadCurrentPhotoData(photoData: [PhotosData])-> PhotosData{
        let photo = photoData.filter{$0.id == currentPid}
        return photo[0]
    }
    
   func Previous() {
        guard currentPid > 1 else {
            return
        }
        currentPid -= 1
        loadImage()
    }

    func Next() {
        guard currentPid < photoData.count - 1 else {
            return
        }
        currentPid += 1
        loadImage()
    }
    
}
