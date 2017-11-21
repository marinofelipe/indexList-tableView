//
//  AnimalTableViewController.swift
//  IndexedTableDemo
//
//  Created by Simon Ng on 3/10/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class AnimalTableViewController: UITableViewController {
    fileprivate let animals = ["Bear", "Black Swan", "Buffalo", "Camel", "Cockatoo", "Dog", "Donkey", "Emu", "Giraffe", "Greater Rhea", "Hippopotamus", "Horse", "Koala", "Lion", "Llama", "Manatus", "Meerkat", "Panda", "Peacock", "Pig", "Platypus", "Polar Bear", "Rhinoceros", "Seagull", "Tasmania Devil", "Whale", "Whale Shark", "Wombat"]
    
    fileprivate var animalsDict = [String: [String]]()
    fileprivate var animalSectionTitles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defineSectionTitles()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Animal data
    fileprivate func defineSectionTitles() {
        var setOfSectionTitles = Set<String>()
        for animal in animals where animal.count > 0 {
            if let animalFirstLetter = animal.first {
                let animalKey = String(animalFirstLetter)
                setOfSectionTitles.insert(animalKey)
                
                if var animalValues = animalsDict[animalKey] {
                    animalValues.append(animal)
                    animalsDict[animalKey] = animalValues
                } else {
                    animalsDict[animalKey] = [animal]
                }
            }
        }
        animalSectionTitles = setOfSectionTitles.sorted(by: { $0 < $1 })
    }
}

// MARK: - Table view data source
extension AnimalTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return animalSectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let animalKey = animalSectionTitles[section]
        guard let animalValues = animalsDict[animalKey] else {
            return 0
        }
        
        return animalValues.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = animals[indexPath.row]
        
        // Convert the animal name to lower case and
        // then replace all occurences of a space with an underscore
        let imageFileName = animals[indexPath.row].lowercased().replacingOccurrences(of: " ", with: "_")
        cell.imageView?.image = UIImage(named: imageFileName)
        
        return cell
    }
}

// MARK: - Table view delegate
extension AnimalTableViewController {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return animalSectionTitles[section]
    }
}
