//
//  PostData.swift
//  Instagram
//
//  Created by 家城苑佳 on 2020/11/11.
//  Copyright © 2020 sonoka.yashiro. All rights reserved.
//

import UIKit
import Firebase

class PostData: NSObject {
    var id: String
    var name: String?
    var caption: String?
    var date: Date?
    var likes: [String] = [] //いいねをした人の配列
    var isLiked: Bool = false// いいねしたかどうかを判断
    var comments: [String] = []
    
    var labelcomments : String?

    
    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID

        let postDic = document.data()

        self.name = postDic["name"] as? String

        self.caption = postDic["caption"] as? String

        let timestamp = postDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()

        if let likes = postDic["likes"] as? [String] {
            self.likes = likes
        }
        if let myid = Auth.auth().currentUser?.uid {
            // likesの配列の中にmyidが含まれているかチェックすることで、自分がいいねを押しているかを判断
            if self.likes.firstIndex(of: myid) != nil {
                // myidがあれば、いいねを押していると認識する。
                self.isLiked = true
            }
            
        }
        
        // firestoreのdocumentdataの項目(field)の"comments"を取り出しcommentsを入れる
        if let comments = postDic["comments"] as? [String]{
            //PostDataクラスのcommentsに改行したcommentsを入れる
            var commentStr : String? = "コメント欄"
            for i in 0..<comments.count {
            
                commentStr! += "\n\(comments[i])\n"
                print("comments[i]\n")
                // "コメント１"\n"コメント２"
                self.labelcomments = commentStr
                print("commentStr")
            }
            
        }
        
    
    }

}
