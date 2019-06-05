//
//  PostController.swift
//  Continuum
//
//  Created by Dustin Koch on 6/4/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import Foundation
import UIKit

class PostController {
    
    //MARK: - Singleton
    static let sharedInstance = PostController()
    
    //MARK: - Source of truth
    var posts: [Post] = []
    
    //MARK: - CRUD Functions
    func addComment(text: String, post: Post, completion: @escaping (Comment) -> Void) {
        let comment = Comment(text: text, post: post)
        post.comments.append(comment)
        //do completion with CloudKit
    }
    
    func createPostWith(image: UIImage, caption: String, completion: @escaping (Post?) -> Void) {
        let post = Post(caption: caption, photo: image)
        PostController.sharedInstance.posts.append(post)
        //do completion with CloudKit
    }
 
}//END OF CLASS
