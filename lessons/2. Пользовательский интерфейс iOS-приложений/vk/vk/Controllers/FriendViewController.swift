//
//  FriendViewController.swift
//  vk
//
//  Created by WizaXxX on 30.05.2022.
//

import UIKit

class FriendViewController: UIViewController {
    
    @IBInspectable var inactiveIndicatorColor: UIColor = UIColor.lightGray
    @IBInspectable var activeIndicatorColor: UIColor = UIColor.black
    
    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var galleryView: UIView!
    
    var friend: Friend? = nil
    
    private var interactiveAnimator: UIViewPropertyAnimator!
    private var mainImageView = UIImageView()
    private var secondaryImageView = UIImageView()
    private var isLeftSwipe = false
    private var isRightSwipe = false
    private var chooseFlag = false
    private var currentIndex = 0
    private var customPageView = UIPageControl()
    
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
        
        setupGallery()
        
    }
    
    func configure(friend: Friend) {
        self.friend = friend
    }
    
    private func setupGallery() {
        galleryView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        galleryView.addGestureRecognizer(recognizer)
        
        mainImageView.frame = galleryView.bounds
        galleryView.addSubview(mainImageView)
        
        secondaryImageView.frame = galleryView.bounds
        secondaryImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
        galleryView.addSubview(secondaryImageView)
        
        customPageView.frame = CGRect(x: 1, y: 1, width: 150, height: 50)
        customPageView.layer.zPosition = 100
        customPageView.numberOfPages = 1
        customPageView.currentPage = 0
        customPageView.pageIndicatorTintColor = self.inactiveIndicatorColor
        customPageView.currentPageIndicatorTintColor = self.activeIndicatorColor
        galleryView.addSubview(customPageView)
        customPageView.translatesAutoresizingMaskIntoConstraints = false
        customPageView.centerXAnchor.constraint(equalTo: galleryView.centerXAnchor).isActive = true
        customPageView.bottomAnchor.constraint(
            equalTo: galleryView.bottomAnchor,
            constant: -galleryView.bounds.height / 15).isActive = true
        customPageView.numberOfPages = friend?.photos.count ?? 0
        mainImageView.image = friend?.photos.first
    }
    
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        if let animator = interactiveAnimator,
           animator.isRunning {
            return
        }
        
        switch recognizer.state {
        case .began:
            self.mainImageView.transform = .identity
            self.mainImageView.image = self.friend?.photos[currentIndex]
            self.secondaryImageView.transform = .identity
            galleryView.bringSubviewToFront(self.mainImageView)
            
            interactiveAnimator?.startAnimation()
            interactiveAnimator = UIViewPropertyAnimator(duration: 0.5,
                                                         curve: .easeInOut,
                                                         animations: { [weak self] in
                self?.mainImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0).getWithScale()
            })
            interactiveAnimator.pauseAnimation()
            isLeftSwipe = false
            isRightSwipe = false
            
        case .changed:
            var translation = recognizer.translation(in: galleryView)
            if translation.x < 0 && (!isLeftSwipe) {
                if self.currentIndex == ((self.friend?.photos.count ?? 0) - 1) {
                    interactiveAnimator.stopAnimation(true)
                    return
                }
                onChange(isLeft: true)
                interactiveAnimator.stopAnimation(true)
                interactiveAnimator.addAnimations { [weak self] in
                    self?.mainImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0).getWithScale()
                    self?.secondaryImageView.transform = .identity
                }
                interactiveAnimator.addCompletion({ [weak self] _ in
                    self?.onChangeCompletion(isLeft: true)
                })
                
                interactiveAnimator.startAnimation()
                interactiveAnimator.pauseAnimation()
                isLeftSwipe = true
            }
            
            if translation.x > 0 && (!isRightSwipe) {
                if self.currentIndex == 0 {
                    interactiveAnimator.stopAnimation(true)
                    return
                }
                onChange(isLeft: false)
                interactiveAnimator.stopAnimation(true)
                interactiveAnimator.addAnimations { [weak self] in
                    self?.mainImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
                    self?.secondaryImageView.transform = .identity
                }
                interactiveAnimator.addCompletion({ [weak self] _ in
                    self?.onChangeCompletion(isLeft: false)
                })
                interactiveAnimator.startAnimation()
                interactiveAnimator.pauseAnimation()
                isRightSwipe = true
            }
            
            if isRightSwipe && (translation.x < 0) {return}
            if isLeftSwipe && (translation.x > 0) {return}
            
            if translation.x < 0 {
                translation.x = -translation.x
            }
            interactiveAnimator.fractionComplete = translation.x / (UIScreen.main.bounds.width)
            print(interactiveAnimator.fractionComplete)
            
        case .ended:
            if let animator = interactiveAnimator,
               animator.isRunning {
                return
            }
            var translation = recognizer.translation(in: galleryView)
            if translation.x < 0 {translation.x = -translation.x}
            
            if (translation.x / (UIScreen.main.bounds.width)) > 0.1  {
                interactiveAnimator.startAnimation()
            }
            else {
                interactiveAnimator.stopAnimation(true)
                interactiveAnimator.finishAnimation(at: .start)
                interactiveAnimator.addAnimations { [weak self] in
                    self?.mainImageView.transform = .identity
                    guard let weakSelf = self else {return}
                    if weakSelf.isLeftSwipe {
                        self?.secondaryImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
                    }
                    if weakSelf.isRightSwipe {
                        self?.secondaryImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
                    }
                }
                
                interactiveAnimator.addCompletion({ [weak self] _ in
                    self?.mainImageView.transform = .identity
                    self?.secondaryImageView.transform = .identity
                    self?.secondaryImageView.image = nil
                })
                
                interactiveAnimator.startAnimation()
            }
        default:
            return
        }
    }
    
    private func onChange(isLeft: Bool) {
        self.mainImageView.transform = .identity
        self.secondaryImageView.transform = .identity
        self.mainImageView.image = self.friend?.photos[currentIndex]
        
        if isLeft {
            self.secondaryImageView.image = self.friend?.photos[self.currentIndex + 1]
            self.secondaryImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
        }
        else {
            self.secondaryImageView.image = self.friend?.photos[currentIndex - 1]
            self.secondaryImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0).getWithScale()
        }
    }
    
    private func onChangeCompletion(isLeft: Bool) {
        self.mainImageView.transform = .identity
        self.secondaryImageView.transform = .identity
        if isLeft {
            self.currentIndex += 1
        }
        else {
            self.currentIndex -= 1
        }
        self.mainImageView.image = self.friend?.photos[self.currentIndex]
        galleryView.bringSubviewToFront(self.mainImageView)
        self.customPageView.currentPage = self.currentIndex
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
    
    @IBAction func changePhotoControll(_ sender: UISegmentedControl) {
        collectionView.isHidden = sender.selectedSegmentIndex != 0
        galleryView.isHidden = !collectionView.isHidden
        
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

extension CGAffineTransform {
    
    func getWithScale() -> CGAffineTransform {
        self.concatenating(CGAffineTransform(scaleX: 0.5, y: 0.5))
    }
}
