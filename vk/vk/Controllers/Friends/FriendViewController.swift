//
//  FriendViewController.swift
//  vk
//
//  Created by Илья Козырев on 04.08.2022.
//

import UIKit

class FriendViewController: UIViewController {

    @IBOutlet weak var avatarView: AvatarView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var lastSeen: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var friend: Friend?
    var photos: [VKPhoto] = [VKPhoto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let currentFriend = friend else { return }
        
        title = currentFriend.nickname
        name.text = "\(currentFriend.firstName) \(currentFriend.lastName)"
        
        if let date = currentFriend.lastSeen {
            lastSeen.text = "last seen \(String(describing: date.formatted()))"
        }
        
        collectionView.register(
            UINib(nibName: Resouces.Cell.photoCollectionViewCell, bundle: nil),
            forCellWithReuseIdentifier: Resouces.CellIdentifiers.photoCollectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        avatarView.loadAndSetImage(from: currentFriend.mSizePhoto, cornerRadius: 50, shadowRadius: 5)
        loadPhotos()
    }
    
    func configure(friend: Friend) {
        self.friend = friend
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

extension FriendViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let photo = photos[indexPath.item]
//        performSegue(withIdentifier: Resouces.Segue.fromFriendToPhoto, sender: photo!)
        
    }
}

extension FriendViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Resouces.CellIdentifiers.photoCollectionView,
            for: indexPath) as! PhotoCollectionViewCell
        
        let photoData = photos[indexPath.item]
        let dataToDownload = photoData.sizes.first { $0.type == "x" }
        
        guard let imageUrl = dataToDownload?.url else { return cell }
        guard let url = URL(string: imageUrl) else { return cell }
        guard let imageData = try? Data(contentsOf: url) else { return cell }
        guard let image = UIImage(data: imageData) else { return cell }
        
        cell.configure(image: image)
        return cell
    }
}

extension FriendViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width
        let whiteSpaces: CGFloat = 10
        let cellWidth = width / 2 - whiteSpaces
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
