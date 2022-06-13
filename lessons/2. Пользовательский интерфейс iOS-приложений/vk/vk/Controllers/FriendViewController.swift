//
//  FriendViewController.swift
//  vk
//
//  Created by WizaXxX on 30.05.2022.
//

import UIKit

class FriendViewController: UIViewController {
    
    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var friend: Friend? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = friend?.name
        friendImage.image = friend!.image
        ageLabel.text = "\(friend!.age)"
        nickNameLabel.text = friend!.nickName
        
        collectionView.register(
            UINib(nibName: Resouces.Cell.photoCollectionViewCell, bundle: nil),
            forCellWithReuseIdentifier: Resouces.CellIdentifiers.photoCollectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    func configure(friend: Friend) {
        self.friend = friend
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Resouces.Segue.fromFriendToPhoto else {
            return
        }
        
        guard let image = sender as? UIImage else {
            return
        }
        
        let view = segue.destination as! PhotoViewerUIViewController
        view.configure(image: image)
    }
    
}

extension FriendViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let photo = friend?.photos[indexPath.item]
        performSegue(withIdentifier: Resouces.Segue.fromFriendToPhoto, sender: photo!)
        
    }
}

extension FriendViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friend?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Resouces.CellIdentifiers.photoCollectionView,
            for: indexPath) as! PhotoCollectionViewCell
        cell.configure(image: (friend?.photos[indexPath.item])!)
        
        return cell
    }
}

extension FriendViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width
        let whiteSpaces: CGFloat = 20
        let cellWidth = width / 2 - whiteSpaces
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
