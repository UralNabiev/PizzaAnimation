//
//  IngredientsCVC.swift
//  PizzaAnimation
//
//  Created by O'ral Nabiyev on 03/04/24.
//

import UIKit

class IngredientsCVC: UICollectionViewCell {
    
    @IBOutlet weak var ingredientsImg: UIImageView!
    
    @IBOutlet weak var ingredientsLbl: UILabel!
    
    
    
    static func nib() -> UINib {
        UINib(nibName: "IngredientsCVC", bundle: nil)
    }
    
    static let identifier: String = "IngredientsCVC"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell(pizza: PizzaIngredientsDM) {
        ingredientsImg.image = UIImage(named: pizza.img)
        ingredientsLbl.text = pizza.title
    }

}
