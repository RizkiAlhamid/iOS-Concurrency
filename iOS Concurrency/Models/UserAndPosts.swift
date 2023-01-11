//
//  UserAndPosts.swift
//  iOS Concurrency
//
//  Created by Muhammad Rizki Miftha Alhamid on 1/10/23.
//

import Foundation

struct UserAndPosts: Identifiable {
    var id = UUID()
    let user: User
    let posts: [Post]
    var numOfPosts: Int {
        posts.count
    }
}
