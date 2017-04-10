

import UIKit

class TableViewController: UITableViewController {
    var didFetch: Bool = false {
        didSet {
            if didFetch {
                print("didFetch")
                refresh()
            }
        }
    }
    
    var permittedEvents: [PermitedEvent] = []
    var serviceRequests: [ServiceRequest] = []
    var literacyPrograms: [LiteracyProgram] = []
    var afterSchoolPrograms: [AfterSchoolProgram] = []
 
    //MARK: - IBOutlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        
        activityIndicator.color = UINavigationBar.appearance().tintColor
        refreshControl?.tintColor = UINavigationBar.appearance().tintColor
        activityIndicator.startAnimating()
        loadData {
            self.didFetch = true
        }
    }
    
    //MARK: - Data

    func loadData(onRefresh: @escaping ((Void) -> Void)) {
       // fetchServiceRequests { onRefresh() }
       // fetchPermittedEvents { onRefresh() }
       // fetchLiteracyPrograms { onRefresh() }
        
        fetchAfterSchoolPrograms { onRefresh() }
    }

    //MARK: - Fetch
    func fetchLiteracyPrograms(onCompleted: @escaping ((Void) -> Void)) {
        Scraper.scrape(.literacyPrograms) { (results) in
            let literacyPrograms = results.flatMap{ LiteracyProgram($0) }
            self.literacyPrograms = literacyPrograms
            
            literacyPrograms.forEach { print($0.program, $0.gradeLevelAgeGroup,"-----", $0.programType) }
        }
    }
    
    func fetchAfterSchoolPrograms(onCompleted: @escaping ((Void) -> Void)) {
        Scraper.scrape(.afterSchool) { (results) in
            let afterSchoolPrograms = results.flatMap{ AfterSchoolProgram($0) }
            self.afterSchoolPrograms = afterSchoolPrograms
            
            afterSchoolPrograms.forEach { print($0) }
        }
    }
    
    func fetchPermittedEvents(onCompleted: @escaping ((Void) -> Void)) {
        Scraper.scrape(.permittedEvents) { (results) in
            let permittedEvents = results.flatMap{ PermitedEvent($0) }
            self.permittedEvents = permittedEvents
            
            permittedEvents.forEach { print($0) }
        }
    }

    func fetchServiceRequests(onCompleted: @escaping ((Void) -> Void)) {
        Scraper.scrape(.serviceRequests) { (results) in
            let requests311 = results.flatMap{ ServiceRequest($0) }
            self.serviceRequests = requests311
            
            let complaintTypes = Set(requests311.map{$0.complaintType}).sorted { $0.localizedCaseInsensitiveCompare($1) == .orderedDescending }
            let report = complaintTypes.map { type in
                (type, requests311.filter { $0.complaintType == type }.count)
                }.sorted { $0.1 > $1.1 }
            
            
            let noiseCount = requests311.filter {$0.complaintType.contains("Noise")}.count
            let typesCount = complaintTypes.filter {$0.contains("Noise")}.count
            let noise = (noiseCount * 1000)/(requests311.count * 10)
            
            print(requests311.count, " requests ", complaintTypes.count - typesCount, " types")
            print("\(typesCount) kinds and \(noise)% noise related")
            
            report.forEach { print($0.0, $0.1, "\(Double($0.1 * 1000)/Double(requests311.count * 10))%") }
            
            onCompleted()
        }
    }
    
    //MARK: - refresh
    
    @IBAction func refresh(_ sender: Any) {
        refresh(scrollToTop: true)
    }
    
    func refresh(scrollToTop: Bool = false) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            if scrollToTop {
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
            self.refreshControl?.endRefreshing()
            self.activityIndicator.stopAnimating()
        }
    }
    
    // MARK: - UITableViewControllerDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "benefitCell") as? BenefitTableViewCell else { fatalError("can't dequeue table view cell") }
        
//        let backgroundView = UIView()
//        if indexPath.section == 1 {
//            cell.textView.attributedText = filteredBenefits[indexPath.row].plainLanguageEligibility.attributedString
//            cell.plainProgramNameLabel.text = filteredBenefits[indexPath.row].programName
//            cell.accessoryType = .detailButton
//            backgroundView.backgroundColor = .white
//        } else {
//            cell.plainProgramNameLabel.text = ""
//            cell.textView.attributedText = filterHeadline.attributedString
//            cell.textView.isUserInteractionEnabled = false
//            cell.accessoryType = .none
//            backgroundView.backgroundColor = UINavigationBar.appearance().tintColor.withAlphaComponent(0.1)
//        }
//        
//        cell.backgroundView = backgroundView
//        cell.applyStyle()
        return cell
    }

}

