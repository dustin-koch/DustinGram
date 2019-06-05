//
//  PostListTableViewController.swift
//  Continuum
//
//  Created by Dustin Koch on 6/4/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Properties
    var resultsArray: [Post] = []
    var isSearching: Bool = false
    var dataSource: [Post] {
        return isSearching ? resultsArray : PostController.sharedInstance.posts
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        resultsArray = PostController.sharedInstance.posts
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableTableViewCell else { return UITableViewCell() }
        let post = dataSource[indexPath.row]
        cell.post = post

        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "postDetailView" {
            guard let index = tableView.indexPathForSelectedRow?.row else { return }
            let destinationVC = segue.destination as? PostDetailTableViewController
            let post = PostController.sharedInstance.posts[index]
            destinationVC?.post = post
        }
    }

}//END OF VIEW CONTROLLER

extension PostListTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var tempArray: [Post] = []
        guard let searchText = searchBar.text,
            searchBar.text != "" else { return }
        for post in dataSource {
            if post.matches(searchTerm: searchText) {
                tempArray.append(post)
            }
        }
        self.resultsArray = tempArray
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resultsArray = PostController.sharedInstance.posts
        self.tableView.reloadData()
        self.searchBar.text = ""
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.isSearching = false
    }
 
}//END OF EXTENSION
