//
//  ViewController.swift
//  Battlebucks
//
//  Created by Praveen Kumar on 16/10/24.
//

import UIKit

class ViewController: UIViewController {
    
    var photoData = [PhotosData]()
    var currentStep: String?
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    @IBOutlet weak var photoCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Image Gallery"
        configeCollectionView()
        DispatchQueue.main.async {
            self.loadPhotoData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    func configeCollectionView(){
        self.photoCollectionView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        layout.itemSize = CGSize(width: screenWidth/2, height: screenWidth/2)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 15
        photoCollectionView.collectionViewLayout = layout
    }
    
    func loadPhotoData(){
            DataManager().getPhotoResponse{ result in
                switch result {
                case .success(let data):
                    for pData in data{
                        self.photoData.append(pData)
                    }
                    DispatchQueue.main.async{
                        self.photoCollectionView.reloadData()
                    }
                case .failure(let error):
                    DispatchQueue.main.async{
                        Common.showAlert(title: "Alert!", message: error.localizedDescription, viewController: self)
                    }
                }
            }
    }

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return photoData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath as IndexPath) as? PhotoCell else{
            return UICollectionViewCell()
        }
        cell.loadPoto(photo: photoData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        guard let controller = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhotoDetailViewController") as? PhotoDetailViewController else{
            return
        }
        controller.photoData = self.photoData
        controller.currentPid = self.photoData[indexPath.row].id
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/2 - 10
        return CGSize(width: width, height: width)
    }
}
