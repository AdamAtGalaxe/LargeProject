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
//        if Utilities.isNetworkAvailable(){
//            showAlert(title: "Network Alert", message: "Please check your network. You are not connected to the internet")
//            //showIndicator(message: "test")
//            return
//        }
    }
    
    @IBAction func alert(_ sender: Any) {
        
    }
    
    @IBAction func loginUser(_ sender: Any) {
        if emailField.text!.isEmpty || passwordField.text!.isEmpty {
            showAlert(title: "Field Error", message: "Both Email and Password are mandatory")
            return
        }
        print(Utilities.isNetworkAvailable() )
        if Utilities.isNetworkAvailable() == false{
            showAlert(title: "Network Alert", message: "Please check your network. You are not connected to the internet")
            //showIndicator(message: "test")
            return
        }
        self.showIndicator(message: "Authenticating")
        
        let loginURL = BASE_URL + LOGIN
        
        var loginRequest = URLRequest(url: URL(string: loginURL)!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
        
        let params = ["email" : emailField.text, "password": passwordField.text]
        
        loginRequest.httpBody = try?JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        
        URLSession.shared.dataTask(with: loginRequest){ (data, response, error) in
           
            guard let Data = data, error == nil else{
                
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200
            {
                return
            }
            DispatchQueue.main.async {
                self.getData(data: Data)
            }
        }.resume()
    }
    func getData(data: Data){
        return
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
