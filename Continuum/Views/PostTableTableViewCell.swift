//
//  PostTableTableViewCell.swift
//  Continuum
//
//  Created by Dustin Koch on 6/4/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import UIKit

class PostTableTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    
    //MARK: - Properties
    var post: Post? {
        didSet {
            updateCell()
        }
    }
    
    //MARK: - Helper functions
    func updateCell() {
        if let post = post {
            photoImageView.image = post.photo
            captionLabel.text = post.caption
            commentCountLabel.text = "\(post.comments.count)"
        }
    }

}//END OF CLASS
