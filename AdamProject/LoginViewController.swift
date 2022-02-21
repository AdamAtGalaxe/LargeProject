//
//  LoginViewController.swift
//  AdamProject
//
//  Created by Adam Roberts on 2/1/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
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
        if UserDefaults.standard.object(forKey: "TOKEN") != nil {
            print("here")
            performSegue(withIdentifier: "LoginSegue", sender: nil)
        }
    }
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue){
        passwordField.text = ""
        emailField.text = ""
        
        UserDefaults.standard.removeObject(forKey: "TOKEN")
        
    }
    
    @IBAction func loginUser(_ sender: Any) {
        if !emailField.text!.isValidEmail{
            showAlert(title: "Field Error", message: "Email is not a valid email address")
            return
        }
        if passwordField.text!.isEmpty {
            showAlert(title: "Field Error", message: "Both Email and Password are mandatory")
            return
        }
        if !Database.isNetworkAvailable(){
            showAlert(title: "Network Alert", message: "Please check your network. You are not connected to the internet")
            return
        }
        
        Database.login(email: emailField.text!, password: passwordField.text!, myView: self)
    }

}
