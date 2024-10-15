//
//  CharactersListViewCell.swift
//  RiMo
//
//  Created by Javier Calartrava on 9/6/24.
//

import UIKit

@MainActor
final class CharactersListViewCell: UITableViewCell {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterIcon: UIImageView!

    // MARK: - Lifecycle/Overridden
    override func awakeFromNib() {
        super.awakeFromNib()
        MainActor.assumeIsolated {
            self.accessoryType = .disclosureIndicator
        }
    }
    
    // MARK: - Public/Helper
    func set(character: Character) {
        guard nameLabel != nil else { return }
        self.nameLabel.text = character.name
        if let url = URL(string: character.imageUrl) {
            Task {
                await characterIcon.setImage(from: url)
            }
        }
    }
}
