//
//  CategoryViewController.swift
//  starwars-app
//
//  Created by ShahJee on 18/10/2023.
//

import UIKit

class CategoryViewController: UITableViewController {

    var selectedCategory: Root? {
        didSet {
            switch selectedCategory?.name {
            case "People":
                loadPeople()
                break
            case "Films":
                loadFilms()
                break
            default:
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = selectedCategory?.name
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return peopleList.count
        case 1:
            return filmsList.count
        default:
            return 0
        }
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryCell

        var safeName: String = ""
        
        switch indexPath.section {
        case 0:
            safeName = peopleList[indexPath.row].name!
            break
        case 1:
            safeName = filmsList[indexPath.row].title!
            break
        default:
            safeName = "nil"
        }
        
        cell?.titleLabel.text = safeName

        return cell ?? UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GotoDetail", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            var title = ""
            var desc = ""
            
            switch indexPath.section {
                case 0:
                    if let safeValue = peopleList[indexPath.row].name {
                        title = safeValue
                    }
                    
                    if let safeValue = peopleList[indexPath.row].height {
                        desc.append(" Height: \(safeValue)")
                    }
                    if let safeValue = peopleList[indexPath.row].gender {
                        desc.append(" Gender: \(safeValue)")
                    }
                    
                    break
                case 1:
                    if let safeValue = filmsList[indexPath.row].title {
                        title = safeValue
                    }
                    
                if let safeValue = filmsList[indexPath.row].opening_crawl {
                        desc.append("\(safeValue)")
                    }
                    
                    break
                
            default:
                title = "No title"
                desc = "No description"
            }
            
            destinationVC.setupView(withTitle: title, desc: desc)
        }
    }
    

    // MARK: - Fetch result from SWAPI
    var peopleList = Array<People>()
    
    func loadPeople() {
        NetworkManager.instance.getPeopleList { peopleResult in
            DispatchQueue.main.async {
                if peopleResult.count > 0 {
                    if let pList = peopleResult.results {
                        self.peopleList = pList
                        self.tableView.reloadData()
                    }
                }
            }
        } onError: { error in
            debugPrint(error)
        }
    }
    
    var filmsList = [Film]()
    
    func loadFilms() {
        NetworkManager.instance.getFilmsList { filmsResult in
            DispatchQueue.main.async {
                if filmsResult.count > 0 {
                    if let pList = filmsResult.results {
                        self.filmsList = pList
                        self.tableView.reloadData()
                    }
                }
            }
        } onError: { error in
            debugPrint(error)
        }
    }
}
