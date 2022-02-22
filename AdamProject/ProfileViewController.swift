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
        Task{
            showIndicator(message: "Getting Users")
            user = try await Database.getIndividualUser(myView: self)
            hideIndicator()
            firstNameLabel.text = user!.first_name
            lastNameLabel.text = user!.last_name
            emailLabel.text = user!.email
            user!.photo = Database.downloadImageWithURL(url: user!.avatar)
            userImage.image = UIImage(data: user!.photo!)!
            
            
        }
        // Do any additional setup after loading the view.
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
