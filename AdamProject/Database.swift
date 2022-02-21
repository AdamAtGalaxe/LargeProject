//
//  Database.swift
//  AdamProject
//
//  Created by Adam Roberts on 2/18/22.
//

import Foundation
import UIKit
class Database{
    class func downloadImageWithURL(url: String) -> Data{
        let data = try? Data(contentsOf: NSURL(string: url)! as URL)
        return data!
        
    }
    class func register(email: String, password: String, myView : UIViewController){
    
        myView.showIndicator(message: "Authenticating")
        
        let registrationURL = URL(string: BASE_URL + REGISTER)
        //BASE_URL + LOGIN
    
        var registrationRequest = URLRequest(url: registrationURL!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
        
        registrationRequest.httpMethod = "POST"
        registrationRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let params = ["email" : email, "password": password] //as! Dictionary<String, String>
     
        
        registrationRequest.httpBody = try?JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        print(registrationRequest)
        URLSession.shared.dataTask(with: registrationRequest){ (data, response, error) in
                guard error == nil else{
                    print(error as Any)
                    return
                }
            let status = (response as! HTTPURLResponse).statusCode
            print("status: \(status)")
            
            guard status == 200 else{
                DispatchQueue.main.async {
                    failedLogin(data: data!, myView: myView)
                }
                return
            }
            if let Data = data{
                DispatchQueue.main.async {
                    successfullLogin(data: Data, myView: myView)
                }
            }
        }.resume()
        
    }
    class func login(email: String, password: String, myView : UIViewController){
    
        myView.showIndicator(message: "Authenticating")
        
        let loginURL = URL(string: BASE_URL + LOGIN)
        //BASE_URL + LOGIN
    
        var loginRequest = URLRequest(url: loginURL!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
        
        loginRequest.httpMethod = "POST"
        loginRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let params = ["email" : email, "password": password] //as! Dictionary<String, String>
     
        
        loginRequest.httpBody = try?JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        print(loginRequest)
        URLSession.shared.dataTask(with: loginRequest){ (data, response, error) in
                guard error == nil else{
                    print(error as Any)
                    return
                }
            let status = (response as! HTTPURLResponse).statusCode
            guard status == 200 else{
                DispatchQueue.main.async {
                    failedLogin(data: data!, myView: myView)
                }
                return
            }
            if let Data = data{
                DispatchQueue.main.async {
                    print("HEEREE!")
                    print("data \(data!)")
                    successfullLogin(data: Data, myView: myView)
                }
            }
        }.resume()
        
    }
    class func successfullLogin(data: Data, myView: UIViewController ){
        myView.hideIndicator()
        let response = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Any>
        print("response: \(response!)")
        let token = response!["token"]
        UserDefaults.standard.set(token, forKey: "TOKEN")
        
        myView.performSegue(withIdentifier: "LoginSegue", sender: nil)
        
        return
    }
    class func failedLogin(data: Data, myView: UIViewController ){
        myView.hideIndicator()
        myView.showAlert(title: "Error", message: "Username or password is incorrect. Please check them and try again.")
        return
    }
    class func isNetworkAvailable() -> Bool{
        return (Reachability.init(hostname: "\(BASE_URL)")?.isReachable)!
    }
    
    
    class func getUsersList(myView: UIViewController) async throws -> [User]{
        if(!Utilities.isNetworkAvailable()){
            await myView.showAlert(title: "No Network", message: "No Network. Please check your check your internet connection.")
        }
        let userURL = URL(string: BASE_URL+USERS)!
        let (data, response) = try await URLSession.shared.data(from: userURL)
            
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
            print("error")
            return []
        }
        let userData = try? JSONDecoder().decode(Result.self, from: data)
        print(userData!.data[0].first_name)
        return userData!.data
    }

    class func getIndividualUser(myView: UIViewController) async throws-> User?{
        if(!Utilities.isNetworkAvailable()){
            await myView.showAlert(title: "No Network", message: "No Network. Please check your check your internet connection.")
        }
        let userURL = URL(string: BASE_URL+INDIVIDUAL)!
  
        let (data, response) = try await URLSession.shared.data(from: userURL)
            
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
            return nil
        }
        let userData = try? JSONDecoder().decode(Result2.self, from: data)
        return userData!.data

    }

  
}
