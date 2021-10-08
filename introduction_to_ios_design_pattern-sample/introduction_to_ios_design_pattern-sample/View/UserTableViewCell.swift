//
//  UserTableViewCell.swift
//  introduction_to_ios_design_pattern-sample
//
//  Created by kazunori.aoki on 2021/10/08.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet var iconImgeView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    private var task: URLSessionTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        task?.cancel()
        task = nil
        imageView?.image = nil
    }

    func configure(user: User) {
        task = {
            let url = user.avatarURL
            let task = URLSessionTask.shared.dataTask(with: url) { data, response, error in
                guard let imageData = data else { return }
                
                DispatchQueue.global().async { [weak self] in
                    guard let image = UIImage(data: imageData) else { return }
                    
                    DispatchQueue.main.async {
                        self?.iconImgeView.image = image
                        self?.setNeedsLayout()
                    }
                }
            }
            task.resume()
            return task
        }()
        
        nameLabel.text = user.login
    }
}
