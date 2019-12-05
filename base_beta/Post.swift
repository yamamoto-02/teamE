//
//  Post.swift
//  base_beta
//
//  Created by 後藤壱成 on 2019/12/04.
//  Copyright © 2019 kaito. All rights reserved.
//

import Foundation
import Firebase

struct Post {
    let content: String
    let postID: String
    //let orderCnt: Int
    //let senderID: String
    let createdAt: Timestamp
    let updatedAt: Timestamp

    init(data: [String: Any]) {
        content = data["content"] as! String
        postID = data["postID"] as! String
        //orderCnt = data["orderCnt"] as! Int
        //senderID = data["senderID"] as! String
        createdAt = data["createdAt"] as! Timestamp
        updatedAt = data["updatedAt"] as! Timestamp
    }
}
