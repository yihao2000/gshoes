//
//  ViewController.swift
//  CaseMaking
//
//  Created by William on 20/05/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var idNumberTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var confirmPasswordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func validateEmail(_ email: String) -> Bool {
        if email.contains("@"), email.hasSuffix(".com"){
            return true
        }else {
            return false
        }
    }
    
    func validateID(_ id: String) -> Bool{
        let numbericSet = CharacterSet.decimalDigits
        let numericString = id.components(separatedBy: numbericSet.inverted).joined()
        return numericString.count == 16
    }
    
    func validateAlphanumeric(_ password: String) -> Bool{
        let alphanumericSet = CharacterSet.alphanumerics
        return password.rangeOfCharacter(from: alphanumericSet.inverted) == nil
    }
    
    func checkEquality(_ string1: String, _ string2: String) -> Bool {
        return string1 == string2
    }
    
    func showAlert(_ title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default){ _ in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func submitButton(_ sender: Any) {
        
        
        guard let username = usernameTF.text else{
            return
        }
        
        guard let email = emailTF.text else{
            return
        }
        
        guard let id = idNumberTF.text else{
            return
        }
        
        guard let password = passwordTF.text else{
            return
        }
        
        guard let confirmPassword = confirmPasswordTF.text else {
            return
        }
        
        if username.count <= 5{
            showAlert("Invalid Username", message: "Username must contains more than 5 characters !")
            
        }else if validateEmail(email) == false{
                showAlert("Invalid Email", message: "Email must contains '@' and ends with '.com' !")
        }else if validateID(id) == false{
            showAlert("Invalid ID", message: "ID must be 16 digits of numbers !")
        }else if validateAlphanumeric(password) == false{
            showAlert("Invalid Password", message: "Password must be alphanumeric !")
        }else if checkEquality(password, confirmPassword) == false{
            showAlert("Invalid Confirm Password", message: "Confirm password must match inputted password!")
        }else{
            performSegue(withIdentifier: "RegisterHomeSegue", sender: self)
           
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RegisterHomeSegue"{
            if let destinationVC = segue.destination as? HomeViewController{
                if sender is ViewController {
                    destinationVC.username = usernameTF.text! as String
                }
            }
        }
    }
    
}

