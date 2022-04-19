//
//  CustomTableViewCell.swift
//  Rick&Morty
//
//  Created by Alex Ch. on 14.04.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageOfPersonage: UIImageView!
    
    var cellImage: UIImage? {
        get {
            return imageOfPersonage.image
        } set {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            imageOfPersonage.image = newValue
        }
    }
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageOfPersonage.image = nil
        nameOfPersonage.text = nil
        genderOfPersonage.text = nil
        speciesOfPersonage.text = nil
    }
    
}

// MARK: - Setup UI & Cell

extension CustomTableViewCell {
    
    private func setupUI(){
        imageOfPersonage.layer.cornerRadius = imageOfPersonage.frame.height / 15
        contentView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setupCell(model: PersonageModel) {
        nameOfPersonage.text = model.name
        genderOfPersonage.text = model.gender
        speciesOfPersonage.text = model.species
        cellImage = UIImage()
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: model.image) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.cellImage = UIImage(data: imageData)
            }
        }
    }
}
