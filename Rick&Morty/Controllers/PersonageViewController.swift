//
//  PersonageViewController.swift
//  Rick&Morty
//
//  Created by Alex Ch. on 14.04.2022.
//

import UIKit

class PersonageViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var table: UITableView!
    
    // MARK: - Private properties
    
    private let reuseID = "Cell"
    private let networkManager = NetworkManager()
    let customCell = CustomTableViewCell()
    private var personages: [PersonageModel] = []
    
    // MARK: - Life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        imageInNavBar()
        getData()
    }
}

// MARK: - Extension

extension PersonageViewController {
    
    private func imageInNavBar(){
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
    
    private func getData(){
        networkManager.fetchData { (result) in
            switch result {
            case .success(let personage):
                DispatchQueue.main.async {
                    self.personages = personage?.results ?? []
                    self.table.reloadData()
                }
            case .failure(_):
                self.showAlertError(text: "Пожалуйста, проверьте соединение.")
            }
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension PersonageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.rowHeight = 160
        return personages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! CustomTableViewCell
        let personage = personages[indexPath.row]
        cell.setupCell(model: personage)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = UIStoryboard(name: "DetailsViewController", bundle: nil).instantiateInitialViewController() as? DetailsViewController {
            vc.setData(model: personages[indexPath.row])
            present(vc, animated: true, completion: nil)
        }
    }
}