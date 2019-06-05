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
        guard let post = self.post else { return }
        presentShareControllerFor(post: post)
        
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
    
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let post = post else { return }
            post.comments.remove(at: indexPath.row)
     // Delete the row from the data source
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
     }

    
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
    
    func presentShareControllerFor(post: Post) {
        guard let photo = post.photo else { return }
        let shareController = UIActivityViewController(activityItems: [photo], applicationActivities: nil)
       present(shareController, animated: true)
    }

}//END OF Table VIew Controller
