//
//  ProfileViewController.swift
//  AdamProject
//
//  Created by Adam Roberts on 2/4/22.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var user : User?
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [#colorLiteral(red: 0.1529411765, green: 0.6666666667, blue: 0.8823529412, alpha: 1).cgColor, #colorLiteral(red: 0.06274509804, green: 0.4470588235, blue: 0.7294117647, alpha: 1).cgColor]
        gradientLayer.shouldRasterize = true
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        getUsersList()
        // Do any additional setup after loading the view.
    }
    func getUsersList(){
        if(!Utilities.isNetworkAvailable()){
            showAlert(title: "No Network", message: "No Network. Please check your check your internet connection.")
        }
        showIndicator(message: "Getting User")
        let userURL = URL(string: BASE_URL+INDIVIDUAL)!
        let userRequest = URLRequest(url: userURL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
        
        URLSession.shared.dataTask(with: userRequest){
            (data, response, error) in
            guard let Data = data, error == nil
            else{
                print(error as Any)
                return
            }
            if let httpStatus = (response as? HTTPURLResponse){
                if httpStatus.statusCode != 200{
                    print(httpStatus.statusCode)
                    return
                }
            }
            DispatchQueue.main.async {
                self.extractData(data: Data)
            }
            

        }.resume()
    }
    func extractData(data: Data){
        print("Got data!")
        hideIndicator()
        let user1 = try? JSONDecoder().decode(Result2.self, from: data)
        print(user1!)
        self.user = user1!.data
        firstNameLabel.text = user!.first_name
        lastNameLabel.text = user!.last_name
        emailLabel.text = user!.email
        user!.photo = Downloader.downloadImageWithURL(url: user!.avatar)
        userImage.image = UIImage(data: user!.photo!)!
        print(user!.first_name)
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

///api/users?page =2
