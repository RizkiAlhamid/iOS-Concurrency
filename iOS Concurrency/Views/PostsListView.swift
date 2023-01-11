//
//  PostsListView.swift
//  iOS Concurrency
//
//  Created by Muhammad Rizki Miftha Alhamid on 1/8/23.
//

import SwiftUI

struct PostsListView: View {
    var posts: [Post]
    
    var body: some View {
        List {
            ForEach(posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("Posts")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.plain)
    }
}

struct PostsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostsListView(posts: Post.mockSingleUserPostsArray)
        }
    }
}
