//
//  DetailsViewController.swift
//  Rick&Morty
//
//  Created by Alex Ch. on 15.04.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var speciesLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var lastLocationLbl: UILabel!
    @IBOutlet weak var episodesCountLbl: UILabel!
    
    
    private var name = ""
    private var species = ""
    private var gender = ""
    private var status = ""
    private var lastLocation = ""
    private var image = ""
    private var episodesCount = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
    }
    
    func setData(model: PersonageModel) {
        name = model.name
        species = model.species.rawValue
        gender = model.gender.rawValue
        status = model.status
        lastLocation = model.location.name
        image = model.image
        episodesCount = String(model.episode.count)
        
    }
    
    func setupUI(){
        nameLbl.text = "Name: \(name)"
        speciesLbl.text = "Race: \(species)"
        genderLbl.text = "Gender: \(gender)"
        statusLbl.text = "Status: \(status)"
        lastLocationLbl.text = "Last location: \(lastLocation)"
        episodesCountLbl.text = "Episodes with character: \(episodesCount)"
        
        if let imageUrl = URL(string: image),
           let imageData = try? Data(contentsOf: imageUrl){
            detailsImageView.image = UIImage(data: imageData)
        }
    }
}
