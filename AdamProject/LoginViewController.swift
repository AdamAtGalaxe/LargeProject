//
//  LoginViewController.swift
//  AdamProject
//
//  Created by Adam Roberts on 2/1/22.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet var backgroundGradientView: UIView!
    
    override func viewDidLoad() {
        //showAlert(title: "Test", message: "test")
        super.viewDidLoad()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [#colorLiteral(red: 0.1529411765, green: 0.6666666667, blue: 0.8823529412, alpha: 1).cgColor, #colorLiteral(red: 0.06274509804, green: 0.4470588235, blue: 0.7294117647, alpha: 1).cgColor]
        gradientLayer.shouldRasterize = true
        self.view.layer.insertSublayer(gradientLayer, at: 0)

    }
    override func viewDidAppear(_ animated: Bool) {
        var network = "NA"
        if network != "Available" {
            //showAlert(title: "Network Alert", message: "Please check your network. You are not connected to the internet")
            showIndicator(message: "test")
        }
    }
    
    @IBAction func alert(_ sender: Any) {
        
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
