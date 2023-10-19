//
//  RootTableViewController.swift
//  starwars-app
//
//  Created by ShahJee on 18/10/2023.
//

import UIKit

class RootViewController: UITableViewController {

    @IBOutlet var rootTable: UITableView!
    
    let categories = [Root(name: "People", url: "\(NetworkManager.instance.BASE_URL)\(NetworkManager.instance.PEOPLE_URL)"),
                    Root(name: "Films", url: "\(NetworkManager.instance.BASE_URL)\(NetworkManager.instance.FILMS_URL)"),
                    Root(name: "Starships", url: "\(NetworkManager.instance.BASE_URL)\(NetworkManager.instance.STARSHIPS_URL)"),
                    Root(name: "Vehicles", url: "\(NetworkManager.instance.BASE_URL)\(NetworkManager.instance.VEHICLES_URL)"),
                    Root(name: "Species", url: "\(NetworkManager.instance.BASE_URL)\(NetworkManager.instance.SPECIES_URL)"),
                    Root(name: "Planets", url: "\(NetworkManager.instance.BASE_URL)\(NetworkManager.instance.PLANETS_URL)")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = tableView.dequeueReusableCell(withIdentifier: "RootCell", for: indexPath) as? RootCell

        cell?.titleLabel.text = categories[indexPath.row].name
        
        return cell ?? UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GotoCategory", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! CategoryViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    

}
