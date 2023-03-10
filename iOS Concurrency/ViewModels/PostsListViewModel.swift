//
//  PostsListViewModel.swift
//  iOS Concurrency
//
//  Created by Muhammad Rizki Miftha Alhamid on 1/8/23.
//

import Foundation

class PostsListViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String?
    var userId: Int?
    
    func fetchPosts() {
        if let userId = userId {
            let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users/\(userId)/posts")
            isLoading.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                apiService.getJSON { (result: Result<[Post], APIError>) in
                    defer {
                        DispatchQueue.main.async {
                            self.isLoading.toggle()
                        }
                    }
                    switch result {
                    case .success(let posts):
                        DispatchQueue.main.async {
                            self.posts = posts
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self.showAlert = true
                            self.errorMessage = error.localizedDescription + "\nPlease contact the developer and provide this error and the steps to reproduce"
                        }
                    }
                }
            }
        }
    }
}

extension PostsListViewModel {
    convenience init(forPreview: Bool = false) {
        self.init()
        if forPreview {
            self.posts = Post.mockSingleUserPostsArray
        }
    }
}
