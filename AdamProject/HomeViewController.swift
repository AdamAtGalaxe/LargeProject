//
//  HomeViewController.swift
//  AdamProject
//
//  Created by Adam Roberts on 2/3/22.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddUserProtocolDelegate{

    var users : [User] = []

    @IBOutlet weak var userTableView: UITableView!
    let itemsPerBatch = 15
    var currentRow: Int = 1
    
    override func viewDidLoad() {
        //super.viewDidLoad()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [#colorLiteral(red: 0.1529411765, green: 0.6666666667, blue: 0.8823529412, alpha: 1).cgColor, #colorLiteral(red: 0.06274509804, green: 0.4470588235, blue: 0.7294117647, alpha: 1).cgColor]
        gradientLayer.shouldRasterize = true
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        Task{
            showIndicator(message: "Getting Users")
            users = try await Database.getUsersList(myView: self)
            userTableView.reloadData()
            hideIndicator()
        }
    }

    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "User", for: indexPath) as! HomeTableViewCell
        cell.userName.text = "\(users[indexPath.row].first_name)  \(users[indexPath.row].last_name)"
        cell.userEmail.text = users[indexPath.row].email
        users[indexPath.row].photo = Database.downloadImageWithURL(url: users[indexPath.row].avatar)
        cell.userImage.image = UIImage(data: users[indexPath.row].photo!)!
        
        cell.userImage.layer.cornerRadius = cell.userImage.frame.height/2
        cell.userImage.layer.masksToBounds = true

        return cell
    }


    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "UserDetailSegue"{
            let userDetailViewController = segue.destination as! UserDetailViewController
            userDetailViewController.user = users[userTableView.indexPathForSelectedRow!.row]
        }
        if segue.identifier == "AddUserSegue"{
            let addUserController = segue.destination as! NewUserViewController
            addUserController.addUserDelegate = self
            
        }

    }
    func cancelAddingUser(_ controller: NewUserViewController) {
        controller.dismiss(animated: true, completion: nil)
        
    }
    
    func addNewUser(_ controller: NewUserViewController, user: User) {
        users.insert(user, at:0)
        controller.dismiss(animated: true, completion: nil)
        userTableView.reloadData()
        
    }


}
