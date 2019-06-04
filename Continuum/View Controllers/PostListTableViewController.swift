//
//  PostListTableViewController.swift
//  Continuum
//
//  Created by Dustin Koch on 6/4/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostController.sharedInstance.posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableTableViewCell else { return UITableViewCell() }
        let post = PostController.sharedInstance.posts[indexPath.row]
        cell.post = post

        return cell
    }

    //LEAVING IN CASE I WANT TO DELETE POSTS LATER HERE?
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "postDetailView" {
            guard let index = tableView.indexPathForSelectedRow?.row else { return }
            let destinationVC = segue.destination as? PostDetailTableViewController
            let post = PostController.sharedInstance.posts[index]
            destinationVC?.post = post
        }
    }

}//END OF VIEW CONTROLLER
