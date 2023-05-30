//
//  HomeViewController.swift
//  CaseMaking
//
//  Created by William on 20/05/23.
//

import UIKit

class HomeViewController: UIViewController {
    var username: String?
    var idCardNumber: String?
    var email: String?
    
    var walletBalance: Double? = 0
    
    var item1Price: Double? = 250
    var item2Price: Double? = 300
    var item3Price: Double? = 140
    
    var item1Tax: Double = 15
    var item2Tax: Double = 10
    var item3Tax: Double = 10
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var walletLabel: UILabel!
    
    @IBOutlet weak var topupTF: UITextField!
    
    //Item 1
    @IBOutlet weak var item1ImageView: UIImageView!
   
    @IBOutlet weak var item1TaxLabel: UILabel!
    @IBOutlet weak var item1PriceLabel: UILabel!
    @IBOutlet weak var item1QuantityTF: UITextField!
    
    
    //Item 2
    @IBOutlet weak var item2ImageView: UIImageView!
    @IBOutlet weak var item2TaxLabel: UILabel!
    @IBOutlet weak var item2QuantityTF: UITextField!
    @IBOutlet weak var item2PriceLabel: UILabel!
    
    //Item 3
    @IBOutlet weak var item3PriceLabel: UILabel!
    @IBOutlet weak var item3ImageView: UIImageView!
    
    @IBOutlet weak var item3QuantityTF: UITextField!
    @IBOutlet weak var item3TaxLabel: UILabel!
    
    
    func setItem1(){
        let image1 = UIImage(named: "airforce")
        item1ImageView.image = image1
        item1ImageView.contentMode = .scaleAspectFill
        item1ImageView.clipsToBounds = true
        item1QuantityTF.text = String(0)
        item1TaxLabel.text = String(item1Tax)
        
        if let item1Price = item1Price {
            item1PriceLabel.text = String(item1Price)
        } else {
            item1PriceLabel.text = ""
        }
        
    }
    
    func setItem2(){
        let image2 = UIImage(named: "jordan")
        item2ImageView.image = image2
        item2ImageView.contentMode = .scaleAspectFill
        item2ImageView.clipsToBounds = true
        item2QuantityTF.text = String(0)
        item2TaxLabel.text = String(item2Tax)
        
        if let item2Price = item2Price {
            item2PriceLabel.text = String(item2Price)
        } else {
            item2PriceLabel.text = ""
        }

        
    }
    
    func setItem3(){
        let image3 = UIImage(named: "yeezy")
        item3ImageView.image = image3
        item3ImageView.contentMode = .scaleAspectFill
        item3ImageView.clipsToBounds = true
        item3QuantityTF.text = String(0)
        item3TaxLabel.text = String(item3Tax)
        
        if let item3Price = item3Price {
            item3PriceLabel.text = String(item3Price)
        } else {
            item3PriceLabel.text = ""
        }

    }
    
    
    func showAlert(_ title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default){ _ in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        navigationItem.leftBarButtonItem = nil
        navigationItem.hidesBackButton = true
        
        // Do any additional setup after loading the view.
        usernameLabel.text =  "Hello " + username!
        if let balance = walletBalance {
                walletLabel.text = String(balance)
            }
        
        setItem1()
        setItem2()
        setItem3()
        
    }
    
    
    @IBAction func topupSubmit(_ sender: Any) {
        
        var inputtedBalance = Double(topupTF.text!)
        
        if((inputtedBalance == nil) || inputtedBalance!<=0){
            showAlert("Invalid Balance", message: "Inputted balance must be more than 0 !")
        }else{
            walletBalance!+=inputtedBalance!
            showAlert("Success", message: "Balance Successfully Topped Up !")
            if let balance = walletBalance {
                    walletLabel.text = String(balance)
                }
            topupTF.text = ""
            
        }
    }
    
    
    @IBAction func checkoutSubmit(_ sender: Any) {
        var item1Quantity =      Int(item1QuantityTF.text!)
        var item2Quantity = Int(item2QuantityTF.text!)
        var item3Quantity = Int(item3QuantityTF.text!)
        
        if(item1Quantity == nil || item2Quantity == nil || item3Quantity == nil){
            showAlert("Invalid Quantity", message: "Quantity field must be filled !")
        }else if(item2Quantity! < 0 || item1Quantity! < 0 || item3Quantity! < 0){
            showAlert("Invalid Quantity", message: "Quantity field must be filled more than equals to zero")
        }else if(item1Quantity == 0 && item2Quantity == 0 && item3Quantity == 0){
            showAlert("Invalid Quantity", message: "Quantity must be filled more than 0 for at least 1 product")
        }else{
            performSegue(withIdentifier: "HomeCheckoutSegue", sender: self)
        }
        
    }
    
    @IBAction func profileSubmit(_ sender: Any) {
        performSegue(withIdentifier: "HomeProfileSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeCheckoutSegue"{
            if let destinationVC = segue.destination as? CheckoutViewController{
                destinationVC.delegate = self
                if sender is HomeViewController {
                    if let item1Quantity = Int(item1QuantityTF.text ?? ""), let item1Price = item1Price {
                        let item1TaxPercent = item1Tax / 100.0
                        let item1SubTotal = Double(item1Quantity) * item1Price + Double(item1Quantity) * item1Price * item1TaxPercent
                        destinationVC.item1SubTotal = item1SubTotal
                    }
                    
                    if let item2Quantity = Int(item2QuantityTF.text ?? ""), let item2Price = item2Price {
                        let item2TaxPercent = item2Tax / 100.0
                        let item2SubTotal = Double(item2Quantity) * item2Price + Double(item2Quantity) * item2Price * item2TaxPercent
                        destinationVC.item2SubTotal = item2SubTotal
                    }
                    
                    if let item3Quantity = Int(item3QuantityTF.text ?? ""), let item3Price = item3Price {
                        let item3TaxPercent = item3Tax / 100.0
                        let item3SubTotal = Double(item3Quantity) * item3Price + Double(item3Quantity) * item3Price * item3TaxPercent
                        destinationVC.item3SubTotal = item3SubTotal
                    }
                    
                    destinationVC.walletBalance = walletBalance
                    
                    
                    
                  
                }
            }
        }
        
        if segue.identifier == "HomeProfileSegue"{
            if let destinationVC = segue.destination as? ProfileViewController{
                if sender is HomeViewController{
                    destinationVC.email = email
                    destinationVC.idCardNumber = idCardNumber
                    destinationVC.username = username
                    
                }
            }
        }
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

extension HomeViewController: CheckoutViewControllerDelegate {
    func updateAttribute(withValue value: Double) {
        walletBalance = value
        
        walletLabel.text = String(value)
        // Perform any additional actions or updates in the source view controller
    }
}
