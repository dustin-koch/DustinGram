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
    @IBOutlet weak var followPostButtonLabel: UIButton!
    
    //MARK: - Landing pad
    var post: Post? {
        didSet {
            updateView()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - Actions
    @IBAction func commentButtonTapped(_ sender: UIButton) {
    }
    @IBAction func shareButtonTapped(_ sender: UIButton) {
    }
    @IBAction func followButtonTapped(_ sender: UIButton) {
    }
    
    //MARK: - Helper functions
    func updateView() {
        if let post = post {
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

}//END OF Table VIew Controller
