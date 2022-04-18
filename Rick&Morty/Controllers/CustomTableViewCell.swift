//
//  CustomTableViewCell.swift
//  Rick&Morty
//
//  Created by Alex Ch. on 14.04.2022.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageOfPersonage: UIImageView!
    @IBOutlet weak var nameOfPersonage: UILabel!
    @IBOutlet weak var speciesOfPersonage: UILabel!
    @IBOutlet weak var genderOfPersonage: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        clipsToBounds = true
        gradient.frame = contentView.bounds
        gradient.cornerRadius = 0
        gradient.colors = [UIColor.yellow.cgColor, UIColor.green.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        return gradient
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

// MARK: - Setup UI & Cell

extension CustomTableViewCell {
    
    private func setupUI(){
        imageOfPersonage.layer.cornerRadius = imageOfPersonage.frame.height / 15
        contentView.layer.insertSublayer(gradientLayer, at: 0)
        activityIndicator.startAnimating()
    }
    
    func setupCell(model: PersonageModel) {
        nameOfPersonage.text = model.name
        genderOfPersonage.text = model.gender
        speciesOfPersonage.text = model.species
        imageOfPersonage.image = UIImage()
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: model.image) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            
            DispatchQueue.main.async {
                self.imageOfPersonage.image = UIImage(data: imageData)
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            }
        }
    }
}
