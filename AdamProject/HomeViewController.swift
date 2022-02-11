//
//  HomeViewController.swift
//  AdamProject
//
//  Created by Adam Roberts on 2/3/22.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var users = UserRepo().getUsers()
    
    override func viewDidLoad() {
        //super.viewDidLoad()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [#colorLiteral(red: 0.1529411765, green: 0.6666666667, blue: 0.8823529412, alpha: 1).cgColor, #colorLiteral(red: 0.06274509804, green: 0.4470588235, blue: 0.7294117647, alpha: 1).cgColor]
        gradientLayer.shouldRasterize = true
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        getUsersList()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "User", for: indexPath) as! HomeTableViewCell
        cell.userName.text = "\(users[indexPath.row].userFirstName)  \(users[indexPath.row].userLastName)"
        cell.userEmail.text = users[indexPath.row].userEmail
        cell.userImage.image = UIImage(named: users[indexPath.row].userAvatar)
       
        print("here")
        return cell
        
    }
    func getUsersList(){
        if(!Utilities.isNetworkAvailable()){
            showAlert(title: "No Network", message: "No Network. Please check your check your internet connection.")
        }
        showIndicator(message: "Getting Users")
        let userURL = URL(string: BASE_URL+USERS)!
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
