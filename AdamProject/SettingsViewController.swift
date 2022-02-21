//
//  SettingsViewController.swift
//  AdamProject
//
//  Created by Adam Roberts on 2/21/22.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var myButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [#colorLiteral(red: 0.1529411765, green: 0.6666666667, blue: 0.8823529412, alpha: 1).cgColor, #colorLiteral(red: 0.06274509804, green: 0.4470588235, blue: 0.7294117647, alpha: 1).cgColor]
        gradientLayer.shouldRasterize = true
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
       
            myButton.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
            myButton.layer.cornerRadius = 0.5 * myButton.bounds.size.width
            myButton.clipsToBounds = true
            //button.setImage(UIImage(named:"thumbsUp.png"), for: .normal)
            //myButton.addTarget(self, action: #selector(logout(_:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logout(_ sender: Any) {
        self.view.window?.rootViewController?.presentedViewController!.dismiss(animated: true, completion: nil)
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
