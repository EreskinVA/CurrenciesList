//
//  ViewController.swift
//  CurrenciesList
//
//  Created by Vladimir Ereskin on 18.07.2018.
//  Copyright © 2018 Vladimir Ereskin. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var currency = [CurrencyStruct]()   // массив структур JSON
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        update()   // Получение данных и обновление TableView
        
        //tableView.rowHeight = 50
        
        var timer = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    }
    
    @IBAction func refreshAction(_ sender: UIBarButtonItem) {
        update()
    }
    
    // метод получения данных
    @objc func update() {
        let urlString = "http://phisix-api3.appspot.com/stocks.json"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            guard error == nil else { return }
            
            do {
                let json = try JSONDecoder().decode(Currency.self, from: data)
                DispatchQueue.main.async {
                    self.currency = json.stock
                    self.tableView.reloadData()
                }
                
                
            } catch let error {
                print(error)
            }
            
            }.resume()
    }
}

extension CurrencyViewController: UITableViewDelegate {}

extension CurrencyViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: CurrencyCell!
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "title", for: indexPath) as! CurrencyCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrencyCell
            let currenci = currency[indexPath.row-1]
            
            let amount = currenci.price.amount
            let roundedAmount = roundf(Float(amount) * 100) / 100
            // Заполнение ячейки
            cell.numberArray.text = String(indexPath.row)
            cell.name.text = currenci.name
            cell.volume.text = String(currenci.volume)
            cell.amount.text = String(roundedAmount)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currency.count+1
    }
    
}
