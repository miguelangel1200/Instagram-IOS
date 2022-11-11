//
//  SettingViewController.swift
//  instagram-Tecsup
//
//  Created by MAC43 on 14/10/22.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let options: [SettingOption] = [
            SettingOption(name: "Archive", image: "archivebox"),
            SettingOption(name: "Your active", image: "clock"),
            SettingOption(name: "Nametag", image: "tag"),
            SettingOption(name: "Saved", image: "square.and.arrow.down"),
            SettingOption(name: "Close friends", image: "person"),
            SettingOption(name: "Discover people", image: "person.3"),
            SettingOption(name: "Open facebook", image: "shippingbox")
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        
    }
    
    func setUpTable(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
  
    
    
    @IBAction func onTapBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var contentListConfig = UIListContentConfiguration.cell()
        contentListConfig.text = options[indexPath.row].name
        contentListConfig.image = UIImage(systemName: options[indexPath.row].image)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        
        cell.contentConfiguration = contentListConfig
        return cell
    }
    
}
