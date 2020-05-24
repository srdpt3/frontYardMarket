//
//  BasketViewController.swift
//  FrontYardMarket
//
//  Created by Dustin yang on 5/22/20.
//  Copyright © 2020 Dustin yang. All rights reserved.
//

import UIKit
import JGProgressHUD

class BasketViewController: UIViewController {
    //MARK: - IBOutlets
    
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var checkOutButtonOutlet: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalItemsLabel: UILabel!
    @IBOutlet weak var basketTotalPriceLabel: UILabel!
    
    //MARK: - Vars
    var basket: Basket?
    var allItems: [Item] = []
    var purchasedItemIds : [String] = []
    
    let hud = JGProgressHUD(style: .dark)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = footerView
        // Do any additional setup after loading the view.
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //TODO: Check if user is logged in
        print("asdfasdf")
        
        // update some UI
        self.loadBasketFromFirestore()
        
        
        
    }
    
    
    //MARK: - IBActions
    
    @IBAction func checkoutButtonPressed(_ sender: Any) {
        
        
    }
    
    //MARK: - Download basket
    private func loadBasketFromFirestore() {
        
        downloadBasketFromFirestore("1234") { (basket) in
            
            self.basket = basket
            self.getBasketItems()
        }
        
        
    }
    
    //MARK: - Helper functions
    
    private func updateTotalLabels(_ isEmpty: Bool) {
        
        if isEmpty {
            totalItemsLabel.text = "0"
            basketTotalPriceLabel.text = returnBasketTotalPrice()
        } else {
            totalItemsLabel.text = "\(allItems.count)"
            basketTotalPriceLabel.text = returnBasketTotalPrice()
        }
        
        
        //TODO: Update the button status
        checkoutButtonUpdate()
        self.tableView.reloadData()
        
    }
    
    private func returnBasketTotalPrice() -> String {
        
        var totalPrice = 0.0
        
        for item in allItems {
            totalPrice += item.price
        }
        
        return "Total price: " + convertToCurrency(totalPrice)
    }
    
    
    private func getBasketItems() {
        
        if self.basket != nil {
            
            downloadItems(basket!.itemIds) { (allItems) in
                
                self.allItems = allItems
                self.updateTotalLabels(false)
                self.tableView.reloadData()
            }
        }
        
        if self.allItems.count == 0 {
            self.updateTotalLabels(true)
        }
        
    }
    
    private func checkoutButtonUpdate(){
        checkOutButtonOutlet.isEnabled  = allItems.count > 0
        
        if checkOutButtonOutlet.isEnabled {
            checkOutButtonOutlet.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        } else {
            disableCheckoutbuton()
        }
    }
    
    private func disableCheckoutbuton(){
        checkOutButtonOutlet.isEnabled  = false
        checkOutButtonOutlet.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        
        
    }
    
    
    func convertToCurrency(_ number: Double) -> String {
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        
        return currencyFormatter.string(from: NSNumber(value: number))!
    }
    private func removeFromBasket(itemId: String){
        for i in 0..<basket!.itemIds.count {
            if itemId == basket!.itemIds[i]{
                basket!.itemIds.remove(at: i)
                return
            }
        }
        
        
        
        
    }
    
    private func showItemView(_ item: Item) {
        
        let itemVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "itemView") as! ItemViewController
        
        itemVC.item = item
        
        self.navigationController?.pushViewController(itemVC, animated: true)
    }
    
}



extension BasketViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(allItems.count)
        return allItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemTableViewCell
        
        cell.generateCell(allItems[indexPath.row])
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let itemToDelete = allItems[indexPath.row]
            
            allItems.remove(at: indexPath.row)
            tableView.reloadData()
            
            // update backend
            removeFromBasket(itemId: itemToDelete.id)
            
            updateBasketInFirestore(basket!, withValues: [kITEMIDS: basket!.itemIds]) { (err) in
                if err != nil {
                    print("error updateing the basket", err!.localizedDescription)
                }
                
                
                self.getBasketItems()
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showItemView(allItems[indexPath.row])
    }
    
    
}



