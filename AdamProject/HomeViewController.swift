//
//  HomeViewController.swift
//  AdamProject
//
//  Created by Adam Roberts on 2/3/22.
//

import UIKit
class Downloader{
    class func downloadImageWithURL(url: String) -> Data{
        let data = try? Data(contentsOf: NSURL(string: url)! as URL)
        return data!
        
    }
}
class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddUserProtocolDelegate{

    var users2 : [User] = []

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

        //users2 = await Database.getUsersList(myView: self)

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        Task{
            showIndicator(message: "Getting Users")
            users2 = try await Database.getUsersList(myView: self)
            userTableView.reloadData()
            hideIndicator()
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "User", for: indexPath) as! HomeTableViewCell
        cell.userName.text = "\(users2[indexPath.row].first_name)  \(users2[indexPath.row].last_name)"
        cell.userEmail.text = users2[indexPath.row].email
        print(users2[indexPath.row].avatar)
        users2[indexPath.row].photo = Downloader.downloadImageWithURL(url: users2[indexPath.row].avatar)
        cell.userImage.image = UIImage(data: users2[indexPath.row].photo!)!

        return cell
    }


    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if userTableView.indexPathForSelectedRow?.row == 3 {
            return false
        }
        
        return true
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "UserDetailSegue"{
            let userDetailViewController = segue.destination as! UserDetailViewController
            userDetailViewController.user = users2[userTableView.indexPathForSelectedRow!.row]
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
        users2.insert(user, at:0)
        controller.dismiss(animated: true, completion: nil)
        userTableView.reloadData()
        
    }


}
