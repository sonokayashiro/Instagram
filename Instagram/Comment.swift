//
//  Comment.swift
//  Instagram
//
//  Created by 家城苑佳 on 2020/11/17.
//  Copyright © 2020 sonoka.yashiro. All rights reserved.
//

import Foundation
import Firebase

class CommentData: NSObject {
    var id: String
    var name: String?
    var comment: String?
    
    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID
        
        let commentDic = document.data()
        self.name = commentDic["name"] as? String
        
    }
}
