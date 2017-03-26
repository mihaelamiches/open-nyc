//
//  BenefitsViewController.swift
//  OpenNY
//
//  Created by Mihaela Miches on 3/25/17.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit

let ageGroups = ["Youth (14+)", "Seniors", "Pregnant & new parents", "Children (0-13)", "Everyone"]

class BenefitsTableViewController: UITableViewController {
    var benefits: [SocialBenefit] = []
    var filteredBenefits: [SocialBenefit] = []
    
    var population: [String] = []
    var categories: [String] = []
    
    var selectedPopulation: [String] {
        return UserDefaults.standard.string(forKey: "selectedPopulation")?.components(separatedBy: ",") ?? ["Everyone"]
    }
    
    var selectedCategories: [String] {
        return UserDefaults.standard.string(forKey: "selectedCategories")?.components(separatedBy: ",") ?? []
    }
    
    var filterHeadline: String {
        let interestedIn = (selectedCategories.count > 0 && filteredBenefits.count > 0 && selectedCategories != categories) ?
            "\(filteredBenefits.count) \(selectedCategories.joined(separator: ",")) services" :
            "NYC Open Services"
        let population = selectedPopulation.joined(separator: ",") 
        
        return "<h2><a target=\"_blank\" href=\"javascript(void);\">" +
                interestedIn +
                "</a> for <a target=\"_blank\" href=\"javascript(void);\">" +
                population + "</a></h2>"
    }
    
    //MARK: - IBOutlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func didSelectFilter(_ sender: UIBarButtonItem) {
        showFilterOptions()
    }
    
    //MARK: - ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150

        activityIndicator.color = UINavigationBar.appearance().tintColor
        refreshControl?.tintColor = UINavigationBar.appearance().tintColor
        
        activityIndicator.startAnimating()
        loadData {
            self.refresh()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if benefits.count > 0 {
            refresh()
        }
    }
    
    //MARK: - Filtering
    func showFilterOptions() {
        guard let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FilterTableViewController") as? FilterTableViewController else { return }
        
        detailViewController.allCategories = categories
        detailViewController.aboutPopulation = Array(Set(population).subtracting(Set(ageGroups)))
        detailViewController.populationAge = ageGroups
        
        
        detailViewController.selectedCategories = selectedCategories.count > 0 ? selectedCategories : categories
        detailViewController.selectedPopulationAge = selectedPopulation
        detailViewController.selectedPopulation = Array(Set(selectedPopulation).subtracting(Set(ageGroups)))
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func applyFilter() {
        let prefrerredCategories = selectedCategories.count > 0 ? Set(selectedCategories) : Set(categories)
        
        let filtered = benefits.filter { benefit in
            let isServed = Set(benefit.populationServed.components(separatedBy: ",")).intersection(Set(selectedPopulation)).count > 0
            let isInterested = Set(benefit.programCategory.components(separatedBy: ",")).intersection(Set(prefrerredCategories)).count > 0
            
            return isServed || isInterested
        }
        
        
        let filteredSet = Set(filtered)
        
        filteredBenefits = Array(filteredSet).sorted {_ in arc4random() % 2 == 0}
    }
    
    //MARK: - Data

    func loadData(onCompleted: @escaping ((Void) -> Void)) {
        Scraper.scrape(socialBenefitsUrl, ofType: SocialBenefit([:])) { (results) in
            let benefits = results.flatMap{$0 as? SocialBenefit }
            
            let population = benefits.map{$0.populationServed.components(separatedBy: ", ")}.reduce([], { $0 + $1 })
            let screening = Set(population).sorted { $0.localizedCaseInsensitiveCompare($1) == .orderedDescending }
            let categories = Set(benefits.map{$0.programCategory}).sorted { $0.localizedCaseInsensitiveCompare($1) == .orderedAscending }
            
            self.benefits = benefits
            self.population = screening
            self.categories = categories
            
            self.applyFilter()
            
            onCompleted()
        }
    }
    
    @IBAction func refresh(_ sender: Any) {
        refresh()
    }
    
    func refresh() {
        applyFilter()

        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
            self.activityIndicator.stopAnimating()
        }
    }
    
    // MARK: - UITableViewControllerDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : filteredBenefits.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "benefitCell") as? BenefitTableViewCell else { fatalError("can't dequeue table view cell") }
        
        if indexPath.section == 1 {
            cell.textView.attributedText = filteredBenefits[indexPath.row].plainLanguageEligibility.attributedString
            cell.plainProgramNameLabel.text = filteredBenefits[indexPath.row].programName
            cell.accessoryView?.backgroundColor = UINavigationBar.appearance().tintColor
            cell.selectionStyle = .none
            cell.accessoryType = .detailButton
        } else {
            cell.plainProgramNameLabel.text = ""
            cell.textView.attributedText = filterHeadline.attributedString
            cell.textView.isUserInteractionEnabled = false
            cell.selectionStyle = .default
            cell.accessoryType = .none
        }
        
        cell.resizeButton?.isHidden = true
        
        return cell
    }

    // MARK: - UITableViewControllerDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            showFilterOptions()
        }
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if indexPath.section == 1 {
            guard let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BenefitViewController") as? BenefitViewController else { return }
            
            detailViewController.benefit = filteredBenefits[indexPath.row]
            navigationController?.pushViewController(detailViewController, animated: true)
        } else {
            (tableView.cellForRow(at: indexPath) as? BenefitTableViewCell)?.didTapToResize(self)
            tableView.reloadSections([indexPath.section], with: .automatic)
        }
    }
    
}
