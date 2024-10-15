//
//  Comment.swift
//  project-bereal-clone-p2
//
//  Created by Administrator on 10/15/24.
//

import Foundation

import ParseSwift



struct Comment: ParseObject {
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    var originalData: Data?



    var user: User?
    var text: String?
    var post: Post?
}
