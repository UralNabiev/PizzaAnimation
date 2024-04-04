//
//  StartVC.swift
//  PizzaAnimation
//
//  Created by O'ral Nabiyev on 03/04/24.
//

import UIKit

class StartVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func startTapped(_ sender: Any) {
        
        let vc = PizzaAnimationVC(nibName: "PizzaAnimationVC", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
    
}
