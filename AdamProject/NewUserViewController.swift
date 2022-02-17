//
//  NewUserViewController.swift
//  AdamProject
//
//  Created by Adam Roberts on 2/4/22.
//

import UIKit
protocol AddUserProtocolDelegate: AnyObject{
    func cancelAddingUser(_ controller: NewUserViewController)
    func addNewUser(_ controller: NewUserViewController, user: User)
    
}

class NewUserViewController: UIViewController {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    
    weak var addUserDelegate: AddUserProtocolDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [#colorLiteral(red: 0.1529411765, green: 0.6666666667, blue: 0.8823529412, alpha: 1).cgColor, #colorLiteral(red: 0.06274509804, green: 0.4470588235, blue: 0.7294117647, alpha: 1).cgColor]
        gradientLayer.shouldRasterize = true
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func cancelAddingUser(_ sender: Any) {
        addUserDelegate?.cancelAddingUser(self)
    }
    @IBAction func saveUser(_ sender: Any) {
        let user = User(image: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0e/Jonah_Hill-4939_%28cropped%29_%28cropped%29.jpg/800px-Jonah_Hill-4939_%28cropped%29_%28cropped%29.jpg", first: firstName.text!, last: lastName.text!, myEmail: email.text!)
        addUserDelegate?.addNewUser(self, user: user)
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
