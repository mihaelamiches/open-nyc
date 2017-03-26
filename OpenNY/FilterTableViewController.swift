//
//  FilterTableViewController.swift
//  OpenNY
//
//  Created by Mihaela Miches on 3/26/17.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit

protocol FilterTableViewControllerDelegate {
    func didChangeFilterOptions()
}

class FilterTableViewController: UITableViewController {
    var populationAge: [String] = []
    var aboutPopulation: [String] = []
    var allCategories: [String] = []
    
    var selectedPopulationAge: [String] = []
    var selectedPopulation: [String] = []
    var selectedCategories: [String] = []
    
    var delegate: FilterTableViewControllerDelegate?
    
    func applyFilter(options: [String], selectedOption: String) -> [String] {
        var newOptions = options
        if options.contains(selectedOption) {
            newOptions.remove(at: options.index(of: selectedOption) ?? 0)
        } else {
            newOptions.append(selectedOption)
        }
        newOptions = Array(Set(newOptions))
        return newOptions
    }
    
    func saveOptionsToUserDefaults() {
        let populationAge = Array(Set(selectedPopulationAge).intersection(Set(ageGroups)))
        let prefferedPopulation = (populationAge + selectedPopulation).joined(separator: ",")
        let prefrerredCategories = selectedCategories.joined(separator: ",")
        
        if (UserDefaults.standard.string(forKey: "selectedPopulation") != prefferedPopulation ||
            UserDefaults.standard.string(forKey: "selectedCategories") != prefrerredCategories) {
            delegate?.didChangeFilterOptions()
        }
        
        UserDefaults.standard.set(prefferedPopulation, forKey: "selectedPopulation")
        UserDefaults.standard.set(prefrerredCategories, forKey: "selectedCategories")
    
    }
    
    //MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return populationAge.count
        case 1:
            return aboutPopulation.count
        case 2:
            return allCategories.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Services for"
        case 1:
            return "Select all which apply"
        case 2:
            return "Interested in"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = populationAge[indexPath.row]
            cell.accessoryType = selectedPopulationAge.contains(cell.textLabel?.text ?? "") ? .checkmark : .none
        case 1:
            cell.textLabel?.text = aboutPopulation[indexPath.row]
            cell.accessoryType = selectedPopulation.contains(cell.textLabel?.text ?? "") ? .checkmark : .none
        case 2:
            cell.textLabel?.text = allCategories[indexPath.row]
            cell.accessoryType = selectedCategories.contains(cell.textLabel?.text ?? "") ? .checkmark : .none
        default:
            break
        }
        
        cell.tintColor = UINavigationBar.appearance().tintColor
        
        return cell
    }
    
    //MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let option = populationAge[indexPath.row]
            selectedPopulationAge.removeAll()
            selectedPopulationAge = applyFilter(options: selectedPopulationAge, selectedOption: option)
        case 1:
            let option = aboutPopulation[indexPath.row]
            selectedPopulation = applyFilter(options: selectedPopulation, selectedOption: option)
        case 2:
            if selectedCategories == allCategories {
                selectedCategories.removeAll()
            }
            
            let option = allCategories[indexPath.row]
            selectedCategories = applyFilter(options: selectedCategories, selectedOption: option)
        default:
            break
        }
        
        saveOptionsToUserDefaults()
        tableView.reloadData()
    }
    
}
