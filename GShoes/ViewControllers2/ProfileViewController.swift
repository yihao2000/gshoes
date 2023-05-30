//
//  ProfileViewController.swift
//  CaseMaking
//
//  Created by Athalia Tifanny on 20/05/23.
//

import UIKit

class ProfileViewController: UIViewController {
    var username: String?
    var idCardNumber: String?
    var email: String?
    
    @IBOutlet weak var idCardNumberLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        usernameLabel.text = username
        emailLabel.text = email
        idCardNumberLabel.text = idCardNumber
        
    }
    
    
    @IBAction func backSubmit(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func logoutSubmit(_ sender: Any) {
        performSegue(withIdentifier: "ProfileRegisterSegue", sender: self)
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
