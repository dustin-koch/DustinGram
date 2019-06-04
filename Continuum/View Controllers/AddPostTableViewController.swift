//
//  AddPostTableViewController.swift
//  Continuum
//
//  Created by Dustin Koch on 6/4/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import UIKit

class AddPostTableViewController: UITableViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var selectPhotoButton: UIButton!
    @IBOutlet weak var postCaptionTextField: UITextField!
    @IBOutlet weak var postPhotoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    @IBAction func selectPhotoTapped(_ sender: UIButton) {
        //select photo, assign to image view
        DispatchQueue.main.async {
            self.selectPhotoButton.titleLabel?.text = ""
        }
    }
    
    @IBAction func addPostTapped(_ sender: UIButton) {
        guard let photo = postPhotoImageView.image,
        let caption = postCaptionTextField.text,
            postCaptionTextField.text != "" else { return }
        PostController.sharedInstance.createPostWith(image: UIImage(named: "sample")!, caption: caption) { (post) in
            if let post = post {
                PostController.sharedInstance.posts.append(post)
            }
        }
        DispatchQueue.main.async {
            self.selectPhotoButton.titleLabel?.text = "📸 Select Photo 📸"
            self.postCaptionTextField.text = ""
        }
        self.tabBarController?.selectedIndex = 0
        
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        self.tabBarController?.selectedIndex = 0
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

}//END OF TABLE view controller
