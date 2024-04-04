//
//  PizzaAnimationVC.swift
//  PizzaAnimation
//
//  Created by O'ral Nabiyev on 03/04/24.
//

import UIKit
import Lottie

class PizzaAnimationVC: UIViewController {
    
    @IBOutlet weak var breadImg: UIImageView!
    
    @IBOutlet weak var lottieV: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(IngredientsCVC.nib(), forCellWithReuseIdentifier: IngredientsCVC.identifier)
        }
    }
    
    @IBOutlet var pizzaImg: [UIImageView]!
    
    @IBOutlet weak var cutBtnView: UIView!
    
    
    @IBOutlet var sizeOfPizzaV: [UIView]!
    
    @IBOutlet weak var widthOfPizza: NSLayoutConstraint! {
        didSet {
            widthOfPizza.constant = self.view.frame.width*0.65
        }
    }
    
    private var animationView: LottieAnimationView?
    
    var originalWidth = 0
    
    var ingredients: [PizzaIngredientsDM] = [
        PizzaIngredientsDM(title: "Cheese", img: "cheeseBtn"),
        PizzaIngredientsDM(title: "Pepperoni", img: "pepperoniBtn"),
        PizzaIngredientsDM(title: "Spinach", img: "spinachBtn"),
        PizzaIngredientsDM(title: "Tomato", img: "tomatoBtn"),
        PizzaIngredientsDM(title: "Green Pepper", img: "greenPepperBtn"),
        PizzaIngredientsDM(title: "Mushroom", img: "mushroomBtn"),
        ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        originalWidth = Int(widthOfPizza.constant)
        
        breadImg.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        UIView.animateKeyframes(withDuration: 0, delay: 0) { [self] in
            for i in pizzaImg.enumerated() {
                i.element.transform = CGAffineTransform(scaleX: 0, y: 0)
            }
        }
        
        UIView.animateKeyframes(withDuration: 0.7, delay: 0) { [self] in
            breadImg.transform = .identity
        }
        
        
    }
    
    //Lottie
    func setLottie() {
        animationView = .init(name: "done")
        animationView!.frame = lottieV.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 1
        lottieV.addSubview(animationView!)
        animationView!.play()
        Timer.scheduledTimer(withTimeInterval: 1.2, repeats: false, block: { timer in
            self.animationView!.stop()
            self.lottieV.isHidden = true
            self.dismiss(animated: true)
        })
    }
    
    @IBAction func cutTapped(_ sender: Any) {
        if cutBtnView.backgroundColor == .tOrange {
            
            UIView.animateKeyframes(withDuration: 0, delay: 0) { [self] in
                for i in pizzaImg.enumerated() {
                    if i.offset == 6 {
                        i.element.transform = CGAffineTransform(scaleX: 0, y: 0)
                    }
                }
            }
            
            cutBtnView.backgroundColor = .clear
        } else {
            
            UIView.animateKeyframes(withDuration: 0.7, delay: 0) { [self] in
                for i in pizzaImg.enumerated() {
                    if i.offset == 6 {
                        i.element.transform = .identity
                    }
                }
            }
            cutBtnView.backgroundColor = .tOrange
            
        }
    }
    
    @IBAction func trashTapped(_ sender: Any) {
        
        breadImg.transform = CGAffineTransform(scaleX: 0, y: 0)
        cutBtnView.backgroundColor = .clear
        sizeOfPizzaV[1].backgroundColor = .tmain
        
        UIView.animateKeyframes(withDuration: 0, delay: 0) { [self] in
            for i in pizzaImg.enumerated() {
                i.element.transform = CGAffineTransform(scaleX: 0, y: 0)
            }
        }
        
        UIView.animateKeyframes(withDuration: 0.7, delay: 0) { [self] in
            breadImg.transform = .identity
        }
        
    }
    
    
    @IBAction func sizeTapped(_ sender: UIButton) {
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0) { [self] in
            
            switch sender.tag {
            case 0:
                widthOfPizza.constant = CGFloat(originalWidth*4/5)
            case 1:
                widthOfPizza.constant = CGFloat(originalWidth)
            case 2:
                widthOfPizza.constant = CGFloat(originalWidth*6/5)
            default:
                widthOfPizza.constant = CGFloat(originalWidth)
            }
            
            for i in sizeOfPizzaV.enumerated() {
                
                if i.offset == sender.tag {
                    i.element.backgroundColor = .tOrange
                } else {
                    i.element.backgroundColor = .tmain
                }
                
            }
        }
        
    }
    
    @IBAction func orderTapped(_ sender: Any) {
        setLottie()
    }
    
    
}

extension PizzaAnimationVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        UIView.animateKeyframes(withDuration: 0.7, delay: 0) { [self] in
            for i in pizzaImg.enumerated() {
                if indexPath.row == i.offset {
                    i.element.transform = .identity
                }
            }
        }
        
    }
    
}

extension PizzaAnimationVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientsCVC.identifier, for: indexPath) as? IngredientsCVC else { return UICollectionViewCell() }
        
        cell.updateCell(pizza: ingredients[indexPath.row])
        
        return cell
    }
    
}

extension PizzaAnimationVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.height*3/4, height: self.collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
