//
//  TimelineViewController.swift
//  base_beta
//
//  Created by 後藤壱成 on 2019/11/28.
//  Copyright © 2019 kaito. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore


class TimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!

    var me: AppUser!
    var database: Firestore! // 宣言
    
//    var ref: DatabaseReference!
//    ref = Database.database().reference()
    
    //Post型の空の配列postArrayを定義
    var postArray: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        database = Firestore.firestore() // 初期値代入
        //delegateとdataSourceを設定
        tableView.delegate = self  
        tableView.dataSource = self
        
//        let press = UILongPressGestureRecognizer(target: self, action: #selector(pressScreen))
//        press.minimumPressDuration = 1.5
//        view.isUserInteractionEnabled = true
//        view.addGestureRecognizer(press)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        database.collection("posts").order(by: "updatedAt").getDocuments { (snapshot, error) in
            if error == nil, let snapshot = snapshot {
                self.postArray = []
                for document in snapshot.documents {
                    let data = document.data()
                    let post = Post(data: data)
                    self.postArray.append(post)
                }
                //print(self.postArray)
                self.tableView.reloadData()
            }
        }
        
//        database.collection("users").document(me.userID).setData([
//            "userID": me.userID as Any
//            ], merge: true)
//
//        database.collection("users").document(me.userID).getDocument { (snapshot, error) in
//            if error == nil, let snapshot = snapshot, let data = snapshot.data() {
//                self.me = AppUser(data: data)
//            }
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "Add" {
//            let destination = segue.destination as! AddViewController
//            destination.me = sender as? AppUser
//        } else if segue.identifier == "Settings" {
//            let destination = segue.destination as! SettingsViewController
//            destination.me = me
//        }
        let destination = segue.destination as! AddViewController // segue.destinationで遷移先のViewControllerが取得可能。
        //destination.me = sender as! AppUser
        destination.me = sender as? AppUser
    }
    
//    @objc
//    func pressScreen() {
//        performSegue(withIdentifier: "Settings", sender: me)
//    }
    
    // 投稿追加画面に遷移するボタンを押したときの動作を記述。
//    @IBAction func toAddViewController(_ sender: Any) {
//        performSegue(withIdentifier: "Add", sender: me)
//    }
    @IBAction func toAddViewController(_ sender: Any) {
        performSegue(withIdentifier: "Add", sender: me)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //セクションの数
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = postArray[indexPath.row].content
//        database.collection("users").document(postArray[indexPath.row].senderID).getDocument { (snapshot, error) in
//                    if error == nil, let snapshot = snapshot, let data = snapshot.data() {
//                        let appUser = AppUser(data: data)
//                        cell.detailTextLabel?.text = appUser.userName
//                    }
//                }
        return cell
    }
}
