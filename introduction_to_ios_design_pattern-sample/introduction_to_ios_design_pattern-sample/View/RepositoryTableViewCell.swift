//
//  RepositoryTableViewCell.swift
//  introduction_to_ios_design_pattern-sample
//
//  Created by kazunori.aoki on 2021/10/08.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var languageLabel: UILabel!
    @IBOutlet var starLabel: UILabel!
    @IBOutlet var falkLabel: UILabel!
    
    func configure(repository: Repository) {
        nameLabel.text = repository.name
        descriptionLabel.text = repository.description
        languageLabel.text = repository.language
        starLabel.text = "star: \(repository.stargazersCount)"
        falkLabel.text = "falk: \(repository.forksCount)"
    }
}
