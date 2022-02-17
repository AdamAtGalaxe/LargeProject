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
        if Utilities.isNetworkAvailable() == false{
            showAlert(title: "Network Alert", message: "Please check your network. You are not connected to the internet")
            //showIndicator(message: "test")
            return
        }
        self.showIndicator(message: "Authenticating")
        
        let loginURL = URL(string: "https:reqres.in/api/login")
        //BASE_URL + LOGIN
    
        var loginRequest = URLRequest(url: loginURL!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
        
        loginRequest.httpMethod = "POST"
        loginRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let params = ["email" : emailField.text!, "password": passwordField.text!] //as! Dictionary<String, String>
     
        
        loginRequest.httpBody = try?JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        print(loginRequest)
        URLSession.shared.dataTask(with: loginRequest){ (data, response, error) in
                guard error == nil else{
                    print(error as Any)
                    return
                }
            let status = (response as! HTTPURLResponse).statusCode
            guard status == 200 else{
                print(status)
                return
            }
            if let Data = data{
                DispatchQueue.main.async {
                    self.getData(data: Data)
                }
            }
        }.resume()
    }
    func getData(data: Data){
        self.hideIndicator()
        let response = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, String>
        let token = response!["token"]
        print(token!)
        
        UserDefaults.standard.set(token, forKey: "TOKEN")
        
        self.performSegue(withIdentifier: "LoginSegue", sender: nil)
        
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
