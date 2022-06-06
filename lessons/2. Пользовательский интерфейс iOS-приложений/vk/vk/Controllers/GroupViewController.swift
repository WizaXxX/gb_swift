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
    
}
