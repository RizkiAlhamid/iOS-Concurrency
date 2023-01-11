//
//  UsersListViewModel.swift
//  iOS Concurrency
//
//  Created by Muhammad Rizki Miftha Alhamid on 1/8/23.
//

import Foundation

class UsersListViewModel: ObservableObject {
    @Published var usersAndPosts: [UserAndPosts] = []
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String?
    
    @MainActor
    func fetchUsers() async {
        let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users")
        let apiService2 = APIService(urlString: "https://jsonplaceholder.typicode.com/posts")
        isLoading.toggle()
        // LESSON 4 - NOW USING ASYNC AWAIT APPROACH
        defer {
            isLoading.toggle()
        }
        do {
            async let users: [User] = try await apiService.getJSON()
            async let posts: [Post] = try await apiService2.getJSON()
            let (fetchedUsers, fetchedPosts) = await (try users, try posts)
            for user in fetchedUsers {
                let userPosts = fetchedPosts.filter {$0.userId == user.id}
                let newUserAndPost = UserAndPosts(user: user, posts: userPosts)
                usersAndPosts.append(newUserAndPost)
            }
        } catch {
            showAlert = true
            errorMessage = error.localizedDescription + "\nPlease contact the developer and provide this error and the steps to reproduce"
        }
        
        
        // LESSON 1
//        apiService.getJSON { (result: Result<[User], APIError>) in
//            defer {
//                DispatchQueue.main.async {
//                    self.isLoading.toggle()
//                }
//            }
//            switch result {
//            case .success(let users):
//                DispatchQueue.main.async {
//                    self.users = users
//                }
//            case .failure(let error):
//                DispatchQueue.main.async {
//                    self.showAlert = true
//                    self.errorMessage = error.localizedDescription + "\nPlease contact the developer and provide this error and the steps to reproduce"
//                }
//            }
//        }
        
    }
}

extension UsersListViewModel {
    convenience init(forPreview: Bool = false) {
        self.init()
        if forPreview {
            self.usersAndPosts = UserAndPosts.mockUsersAndPosts
        }
    }
}
