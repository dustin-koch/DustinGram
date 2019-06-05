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
    
    //MARK: - Properties
    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    //MARK: - Actions
    @IBAction func selectPhotoTapped(_ sender: UIButton) {
        //select photo, assign to image view
        self.imagePicker.present(from: sender)
            DispatchQueue.main.async {
                self.selectPhotoButton.titleLabel?.text = ""
        }
    }
    
    @IBAction func addPostTapped(_ sender: UIButton) {
        guard let photo = postPhotoImageView.image,
        let caption = postCaptionTextField.text,
            postCaptionTextField.text != "" else { return }
        PostController.sharedInstance.createPostWith(image: photo, caption: caption) { (post) in
            if let post = post {
                PostController.sharedInstance.posts.append(post)
            }
        }
        DispatchQueue.main.async {
            self.selectPhotoButton.titleLabel?.text = "📸 Select Photo 📸"
            self.postCaptionTextField.text = ""
            self.postPhotoImageView.image = nil
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

    //
    
    
    
    
    
}//END OF TABLE view controller

extension AddPostTableViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        DispatchQueue.main.async {
            self.selectPhotoButton.titleLabel?.text = ""
            self.postPhotoImageView.image = image
        }
    }
}
