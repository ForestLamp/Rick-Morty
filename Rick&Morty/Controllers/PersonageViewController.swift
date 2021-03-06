//
//  PersonageViewController.swift
//  Rick&Morty
//
//  Created by Alex Ch. on 14.04.2022.
//

import UIKit

final class PersonageViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let reuseID = "Cell"
    private let networkManager = NetworkManager()
    private let api = Api()
    private let customCell = CustomTableViewCell()
    private var personages: [PersonageModel] = []
    private var pageNumber = 1
    
    // MARK: - Outlets
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var backBarButtonLbl: UIBarButtonItem!
    @IBOutlet weak var forwardButtonLbl: UIBarButtonItem!
    
    // MARK: - Buttons
    
    @IBAction func nextPageButtonTapped(_ sender: UIBarButtonItem) {
        pageNumber += 1
        helperForUI()
        getData()
    }
    @IBAction func backBarButtonTapped(_ sender: UIBarButtonItem) {
        if pageNumber > 1 {
            pageNumber -= 1
            getData()
            helperForUI()
        }
    }
    
    // MARK: - Life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setupUI()
    }
}

    // MARK: - UITableViewDataSource, UITableViewDelegate

extension PersonageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.rowHeight = 160
        return personages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as? CustomTableViewCell {
        let personage = personages[indexPath.row]
        cell.setupCell(model: personage)
        return cell
    }
        return UITableViewCell()
}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = UIStoryboard(name: "DetailsViewController", bundle: nil).instantiateInitialViewController() as? DetailsViewController {
            vc.setData(model: personages[indexPath.row])
            present(vc, animated: true, completion: nil)
        }
    }
}

    // MARK: - Extension

extension PersonageViewController {
    
    private func setupUI() {
        setupTable()
        setupImageInNavBar()
        backBarButtonLbl.isEnabled = false
    }
    
    private func setupImageInNavBar(){
        if let navController = navigationController {
            let imageLogo = UIImage(named: "ram.png")
            let widthNavBar = navController.navigationBar.frame.width
            let heightNavBar = navController.navigationBar.frame.height
            let widthForView = widthNavBar * 0.4
            let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: widthForView, height: heightNavBar))
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: widthForView, height: heightNavBar))
            imageView.image = imageLogo
            imageView.contentMode = .scaleAspectFit
            logoContainer.addSubview(imageView)
            navigationItem.titleView = logoContainer
        }
    }
    
    private func setupTable(){
        table.dataSource = self
        table.delegate = self
    }
    
    private func helperForUI(){
        table.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        backBarButtonLbl.isEnabled = pageNumber != 1
        forwardButtonLbl.isEnabled = pageNumber != 42
    }
    
    private func getData(){
        let baseURL = api.baseURL
        let pageURL = "?page=\(pageNumber)"
        networkManager.fetchData(url: baseURL + pageURL)
        networkManager.delegate = self
    }
}

extension PersonageViewController: NetworkManagerDelegate {
    func showData(results: [PersonageModel]) {
        personages = results
        table.reloadData()
    }
    
    func showError() {
        let alert = AlertManager.showAlertError(text: "????????????????????, ?????????????????? ????????????????????.")
        present(alert, animated: true, completion: nil)
    }
}
