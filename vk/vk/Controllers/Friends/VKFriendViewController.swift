//
//  VKFriendViewController.swift
//  vk
//
//  Created by Илья Козырев on 04.08.2022.
//

import UIKit

class VKFriendViewController: UIViewController {

    @IBOutlet weak var avatarView: AvatarView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var lastSeen: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var friend: VKFriend?
    var photos: [VKPhoto] = [VKPhoto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let currentFriend = friend else { return }
        
        title = currentFriend.nickname
        name.text = "\(currentFriend.firstName) \(currentFriend.lastName)"
        lastSeen.text = "last seen \(currentFriend.lastSeen?.time)"
        
        collectionView.register(
            UINib(nibName: Resouces.Cell.photoCollectionViewCell, bundle: nil),
            forCellWithReuseIdentifier: Resouces.CellIdentifiers.photoCollectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        loadImage()
        loadPhotos()
    }
    
    func configure(friend: VKFriend) {
        self.friend = friend
    }
    
    private func loadImage() {
        guard let currentFriend = friend else { return }
        
        guard let url = URL(string: currentFriend.mSizePhoto) else { return }
        guard let imageData = try? Data(contentsOf: url) else { return }
        
        avatarView.imageView.image = UIImage(data: imageData)
        avatarView.clipsToBounds = false
        avatarView.layer.cornerRadius = 50
        avatarView.layer.shadowColor = UIColor.black.cgColor
        avatarView.layer.shadowOffset = CGSize(width: 5, height: 5)
        avatarView.layer.shadowRadius = 5
        avatarView.layer.shadowOpacity = 0.7
        avatarView.backgroundColor = .white

        avatarView.imageView.clipsToBounds = true
        avatarView.imageView.layer.cornerRadius = avatarView.layer.cornerRadius
    }
    
    private func loadPhotos() {
        guard let currentFriend = friend else { return }
        
        Networker.shared.getPhotos(ownerId: currentFriend.id) { [weak self] photos in
            DispatchQueue.main.async {
                self?.photos = photos
                self?.collectionView.reloadData()
            }
        }
    }
}

extension VKFriendViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let photo = photos[indexPath.item]
//        performSegue(withIdentifier: Resouces.Segue.fromFriendToPhoto, sender: photo!)
        
    }
}

extension VKFriendViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Resouces.CellIdentifiers.photoCollectionView,
            for: indexPath) as! PhotoCollectionViewCell
        
        let photoData = photos[indexPath.item]
        let dataToDownload = photoData.sizes.first { $0.type == "m" }
        
        guard let imageUrl = dataToDownload?.url else { return cell }
        guard let url = URL(string: imageUrl) else { return cell }
        guard let imageData = try? Data(contentsOf: url) else { return cell }
        guard let image = UIImage(data: imageData) else { return cell }
        
        cell.configure(image: image)
        return cell
    }
}

extension VKFriendViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width
        let whiteSpaces: CGFloat = 0
        let cellWidth = width / 3 - whiteSpaces
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
