//
//  CommentViewController.swift
//  Instagram
//
//  Created by 家城苑佳 on 2020/11/15.
//  Copyright © 2020 sonoka.yashiro. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {
    var postData : PostData!
   
    
    @IBOutlet weak var commentTextField: UITextField!
    // 背景をタップしたらキーボードを閉じる
    
    //コメント投稿ボタンを押したときに呼ばれるメソッド
    @IBAction func CommentPostButton(_ sender: Any) {
        var comment : String
        comment = commentTextField.text!
        
        // コメントを更新
        if let user = Auth.auth().currentUser{
            // 更新データを作成する
            var updateValue: FieldValue
            //要素の追加 arrayUnion  commentsに追加
            updateValue = FieldValue.arrayUnion(["\(user.displayName!) \(comment)"])
            
            // commentsに更新データを書き込む
            let postRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
            
            postRef.updateData(["comments": updateValue])
            //配列をどの項目に追加するか
        }
        
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "コメントしました")
        // コメントしたらHome画面に戻る
        UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 背景をタップしたらキーボードを閉じる
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
    }
    @objc func dismissKeyboard(){
        // キーボードを閉じる
        view.endEditing(true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
