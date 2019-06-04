//
//  PostDetailTableViewController.swift
//  Continuum
//
//  Created by Dustin Koch on 6/4/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import UIKit

class PostDetailTableViewController: UITableViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var photoImageView: UIImageView!
    
    //MARK: - Landing pad
    var post: Post? {
        didSet {
            loadViewIfNeeded()
            updateView()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - Actions
    @IBAction func commentButtonTapped(_ sender: UIButton) {
        presentAlertController()
    }
    @IBAction func shareButtonTapped(_ sender: UIButton) {
    }
    @IBAction func followButtonTapped(_ sender: UIButton) {
    }
    
    //MARK: - Helper functions
    func updateView() {
        if let post = post {
            //TESTING PURPOSES
            photoImageView.image = post.photo
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post?.comments.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
        if let post = post {
            cell.textLabel?.text = post.comments[indexPath.row].text
            cell.detailTextLabel?.text = DateFormatter.localizedString(from: post.comments[indexPath.row].timestamp, dateStyle: .medium, timeStyle: .short)
        }
        return cell
    }

    //LEAVING IN CASE I WANT TO DELETE COMMENTS HERE?
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    //MARK: - Alert Controller
    func presentAlertController(){
        let alertController = UIAlertController(title: "Photo Comments", message: "Add your comment here 👇🏽", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Write comment here..."
        }
        let dismissAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        let addAction = UIAlertAction.init(title: "Add Comment", style: .default) { (_) in
            guard let commentText = alertController.textFields?.first?.text,
                alertController.textFields?.first?.text != "",
                let post = self.post else { return }
            PostController.sharedInstance.addComment(text: commentText, post: post, completion: { (comment) in
            })
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        alertController.addAction(dismissAction)
        alertController.addAction(addAction)
        self.present(alertController, animated: true, completion: nil)
    }

}//END OF Table VIew Controller
