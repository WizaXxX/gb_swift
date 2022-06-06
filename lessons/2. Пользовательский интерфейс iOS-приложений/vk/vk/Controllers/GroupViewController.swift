//
//  GoupViewController.swift
//  vk
//
//  Created by WizaXxX on 05.06.2022.
//

import UIKit

class GroupViewController: UIViewController {

    @IBOutlet weak var segmentControll: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var group: Group? = nil
    
    @IBAction func controlChangeValue(_ sender: Any) {
        guard let data = sender as? UISegmentedControl else {
            return
        }
        
        textView.isHidden = data.selectedSegmentIndex != 0
        collectionView.isHidden = data.selectedSegmentIndex != 1
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.isHidden = false
        collectionView.isHidden = true
        
        segmentControll.setTitle("Описание", forSegmentAt: 0)
        segmentControll.setTitle("Пользователи (\(group?.countOfPeople ?? 0))", forSegmentAt: 1)
        
        title = group?.name
        textView.text = group?.desc
        imageView.image = group?.image
        
        collectionView.register(
            UINib(nibName: Resouces.Cell.photoCollectionViewCell, bundle: nil),
            forCellWithReuseIdentifier: Resouces.CellIdentifiers.photoCollectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        print(UIDevice.current.orientation.rawValue)
        
        if UIDevice.current.orientation == .landscapeRight {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 300.0, right: 0.0)
            scrollView?.contentInset = contentInsets
            scrollView?.scrollIndicatorInsets = contentInsets
        }
    }
    
    func configure(group: Group) {
        self.group = group
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Resouces.Segue.fromGroupMembersToFriend else {
            return
        }
        
        guard let friend = sender as? Friend else {
            return
        }
        
        let view = segue.destination as! FriendViewController
        view.configure(friend: friend)
    }
    
}

extension GroupViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let friend = group?.people[indexPath.item]
        performSegue(withIdentifier: Resouces.Segue.fromGroupMembersToFriend, sender: friend)
        
    }
}

extension GroupViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return group?.people.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Resouces.CellIdentifiers.photoCollectionView,
            for: indexPath) as! PhotoCollectionViewCell
        cell.configure(image: (group?.people[indexPath.item].image)!)
        
        return cell
    }
}

extension GroupViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width
        let whiteSpaces: CGFloat = 20
        let cellWidth = width / 4 - whiteSpaces
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
