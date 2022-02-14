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
class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var users2 = [User]()

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
        getUsersList()
        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {


        return users2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "User", for: indexPath) as! HomeTableViewCell
        cell.userName.text = "\(users2[indexPath.row].first_name)  \(users2[indexPath.row].last_name)"
        cell.userEmail.text = users2[indexPath.row].email
        users2[indexPath.row].photo = Downloader.downloadImageWithURL(url: users2[indexPath.row].avatar)
        cell.userImage.image = UIImage(data: users2[indexPath.row].photo!)!

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
        let users = try? JSONDecoder().decode(Result.self, from: data)
        self.users2 = users!.data
        userTableView.reloadData()
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

    }


}
