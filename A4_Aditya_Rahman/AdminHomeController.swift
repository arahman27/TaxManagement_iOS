//
//  AdminHomeController.swift
//  A4_Aditya_Rahman
//

import UIKit

class CustomerTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    
}

class AdminHomeController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    private var customerArr = Array<Customer>()
    @IBOutlet weak var customerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customerArr = CoreDataHandler.shared.getAllCustomers()
        self.navigationItem.setHidesBackButton(true, animated: true)
        customerTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customerCell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath) as! CustomerTableViewCell
       
        customerCell.nameLbl?.text = customerArr[indexPath.row].name
        customerCell.phoneLbl?.text = customerArr[indexPath.row].phone
        customerCell.cityLbl?.text = customerArr[indexPath.row].city
        customerCell.statusLbl?.text = customerArr[indexPath.row].status
        
        if customerArr[indexPath.row].status == "AWAITED" {
            customerCell.backgroundColor = UIColor.yellow
            
        }
        else if customerArr[indexPath.row].status == "FAILEDTOREACH" {
            customerCell.backgroundColor = UIColor(red: 0.7, green: 0.2, blue: 0.3, alpha: 1.0)
            
        }
        else if customerArr[indexPath.row].status == "ONBOARDED" {
            customerCell.backgroundColor = UIColor(red: 0.1, green: 0.9, blue: 0.1, alpha: 1.0)
            
        }
        else if customerArr[indexPath.row].status == "INPROCESS" {
            customerCell.backgroundColor = UIColor(red: 0.1, green: 0.8, blue: 0.50, alpha: 1.0)
            
        }
        else if customerArr[indexPath.row].status == "COMPLETED" {
            customerCell.backgroundColor = UIColor(red: 0.1, green: 0.7, blue: 0.60, alpha: 1.0)
            
        }
        else {
            customerCell.backgroundColor = UIColor(red: 0.9, green: 0.1, blue: 0.1, alpha: 1.0)
            
        }
        
        return customerCell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Delete customer!", message: "Are you sure you want to delete this customer?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "No", style: .cancel)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
            CoreDataHandler.shared.deleteCustomer(for: self.customerArr[indexPath.row]) {}
            self.customerArr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        
        alert.addAction(yesAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "detail") as? DetailController {
            
            vc.customer = customerArr[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    @IBAction func logoutClick(_ sender: UIButton) {
        self.navigationItem.setHidesBackButton(false, animated: true)
        self.navigationController?.popToRootViewController(animated: false)
        
    }
}
