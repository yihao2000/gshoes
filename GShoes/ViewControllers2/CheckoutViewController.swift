//
//  CheckoutViewController.swift
//  CaseMaking
//
//  Created by Athalia Tifanny on 20/05/23.
//

import UIKit


protocol CheckoutViewControllerDelegate: AnyObject {
    func updateAttribute(withValue value: Double)
}
class CheckoutViewController: UIViewController {
    
    weak var delegate: CheckoutViewControllerDelegate?
    
    @IBOutlet weak var item3SubTotalLabel: UILabel!
    @IBOutlet weak var item2SubTotalLabel: UILabel!
    @IBOutlet weak var item1SubTotalLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var balanceLabel: UILabel!
    
    var item1SubTotal: Double!
    var item2SubTotal: Double!
    var item3SubTotal: Double!
    var total: Double!
    var walletBalance: Double!
    
   

   
    
    
    func setLogo(){
        let image = UIImage(named: "logo")
        logoImageView.image = image
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.clipsToBounds = true
    }
    
    func boldFont(){
        item1SubTotalLabel.font = UIFont.boldSystemFont(ofSize: item1SubTotalLabel.font.pointSize)
        
        item2SubTotalLabel.font = UIFont.boldSystemFont(ofSize: item2SubTotalLabel.font.pointSize)
        
        item3SubTotalLabel.font = UIFont.boldSystemFont(ofSize: item3SubTotalLabel.font.pointSize)
        
        totalLabel.font = UIFont.boldSystemFont(ofSize: totalLabel.font.pointSize)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setLogo()
        item1SubTotalLabel.text = String(item1SubTotal)
        item2SubTotalLabel.text = String(item2SubTotal)
        item3SubTotalLabel.text = String(item3SubTotal)
        
        total = item1SubTotal+item2SubTotal+item3SubTotal
        
        totalLabel.text = String(total)
        
        balanceLabel.text = String(walletBalance)
        
        boldFont()
       
    }
    
    @IBAction func cancelSubmit(_ sender: Any) {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
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
    
    @IBAction func checkoutSubmit(_ sender: Any) {
        if(total > walletBalance){
            showAlert("Invalid Balance", message: "You don't have sufficient balance to do the following purchase !")
        }else{
            walletBalance-=total
     
            delegate?.updateAttribute(withValue: walletBalance)
            navigationController?.popViewController(animated: true)
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
