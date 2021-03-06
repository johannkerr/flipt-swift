//
//  BookViewController.swift
//  Flipt
//
//  Created by Johann Kerr on 11/24/16.
//  Copyright © 2016 Johann Kerr. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher


class BookDetailView: UIView{
    lazy var coverImageView = UIImageView()
    lazy var bookTitleLabel = UILabel()
    lazy var authorLabel = UILabel()
    //lazy var segmentController = UISegmentedControl()
    lazy var divider = UIView()
    
    lazy var bookDescriptionLabel = UILabel()
    lazy var bookDescriptionTextView = UITextView()
    lazy var bookOwnedByLabel = UILabel()
    lazy var profileImageView = UIImageView()
    lazy var profileLabel = UILabel()
    lazy var middleDivider = UIView()
    lazy var bottomDivider = UIView()
    lazy var messageOwnerBtn = UIButton()
    
    
    
    
    func createViews(){
        let viewArray = [coverImageView, bookTitleLabel, authorLabel, divider, bookDescriptionLabel, bookDescriptionTextView, bookOwnedByLabel, profileImageView, profileLabel, middleDivider, bottomDivider, messageOwnerBtn]
        viewArray.forEach { (view) in
            self.addSubview(view)
            //view.backgroundColor = UIColor.random
        }
        self.bookDescriptionLabel.text = "Book Description"
        self.bookOwnedByLabel.text = "This Book is Owned By"
        
        
        //self.coverImageView.backgroundColor = UIColor.random
        
        
        createConstraints()
        
    }
    
    init(){
        super.init(frame: CGRect.zero)
        createViews()
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        createViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createConstraints(){
        self.coverImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.top.equalTo(self).offset(75)
            make.width.equalTo(60)
            make.height.equalTo(90)
        }
        
        self.bookTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.coverImageView.snp.right).offset(25)
            make.top.equalTo(self.coverImageView)
            make.width.equalTo(210)
            make.height.equalTo(35)
            
        }
        self.authorLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.bookTitleLabel)
            make.top.equalTo(self.bookTitleLabel.snp.bottom)
            make.width.equalTo(bookTitleLabel)
            make.height.equalTo(self.bookTitleLabel)
            
        }
        //        self.segmentController.snp.makeConstraints { (make) in
        //
        //
        //        }
        self.divider.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(1)
            make.left.equalTo(self)
            make.top.equalTo(self.coverImageView.snp.bottom).offset(20)
        }
        
        self.bookDescriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.divider.snp.bottom).offset(20)
            make.left.equalTo(self).offset(20)
            make.width.equalTo(self.authorLabel)
            make.height.equalTo(self.authorLabel)
        }
        
        self.bookDescriptionTextView.snp.makeConstraints { (make) in
            make.top.equalTo(self.bookDescriptionLabel.snp.bottom)
            make.left.equalTo(self).offset(20)
            make.width.equalTo(self).offset(-20)
            make.height.equalTo(200)
            
        }
        self.bookOwnedByLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.bookDescriptionTextView.snp.bottom).offset(20)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            //make.width.equalTo(200)
            make.height.equalTo(20)
        }
        
        self.middleDivider.snp.makeConstraints { (make) in
            make.top.equalTo(self.bookOwnedByLabel.snp.bottom).offset(10)
            make.width.equalTo(self)
            make.height.equalTo(1)
            make.left.equalTo(self)
        }
        
        
        self.profileImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.middleDivider.snp.bottom).offset(10)
            make.left.equalTo(self).offset(20)
            make.width.equalTo(45)
            make.height.equalTo(45)
        }
        
        self.profileLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.profileImageView)
            make.left.equalTo(self.profileImageView.snp.right).offset(20)
            make.width.equalTo(self.authorLabel)
            make.height.equalTo(self.authorLabel)
        }
        
        self.bottomDivider.snp.makeConstraints { (make) in
            make.top.equalTo(self.profileLabel.snp.bottom).offset(10)
            make.left.equalTo(self)
            make.width.equalTo(self)
            make.height.equalTo(1)
        }

        self.messageOwnerBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.bookOwnedByLabel.snp.bottom).offset(20)
            make.width.equalTo(150)
            make.height.equalTo(50)
            make.centerX.equalTo(self)
        }
        
        
        
        
        
        
        
        
        
        
        
    }
    
}


class SavedBookDetailViewController: BookDetailViewController{
    
    var bookItem: BookItem!
    
    override func loadBook(){
        self.bookDetailView.bookTitleLabel.text = self.bookItem.title
        self.bookDetailView.authorLabel.text = self.bookItem.author
        self.bookDetailView.bookDescriptionTextView.text = self.bookItem.descriptionText
        
        
        //Hiding fields for current user
        self.bookDetailView.messageOwnerBtn.isHidden = true
        self.bookDetailView.bookOwnedByLabel.isHidden = true
        self.bookDetailView.profileImageView.isHidden = true
        self.bookDetailView.profileLabel.isHidden = true
        
        if let img = self.bookItem.imgUrl{
            Alamofire.request(img).responseData { (response) in
                if let data = response.data{
                    let image = UIImage(data: data)
                    
                    OperationQueue.main.addOperation {
                        self.bookDetailView.coverImageView.image = image
                    }
                }
                
            }
        }
        
        
        //if let userId = self.bookItem
        
        
       // self.bookItem.
        

    }
}


class BookDetailViewController: UIViewController {
    
    var book: Book!
    var owner: User!
    lazy var ownerBtn = UIButton()
    
    lazy var bookDetailView = BookDetailView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.view.backgroundColor = UIColor.white
        loadBook()
        
    }
    
    override func loadView(){
        super.loadView()
        self.view = bookDetailView
        
    }
    
    
    func loadBook(){
        //ownerBtn.backgroundColor = UIColor.black
        self.bookDetailView.addSubview(ownerBtn)
        self.ownerBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-30)
            
        }
        self.ownerBtn.tintColor = UIColor.orange
        self.ownerBtn.setTitleColor(UIColor.orange, for: .normal)
        self.ownerBtn.setTitle("Contact", for: .normal)
        self.ownerBtn.addTarget(self, action: #selector(contactOwner), for: .touchUpInside)
        
        self.bookDetailView.bookTitleLabel.text = self.book.title
        self.bookDetailView.authorLabel.text = self.book.author
        self.bookDetailView.bookDescriptionTextView.text = self.book.description
        if let url = URL(string: self.book.coverImgUrl) {
            self.bookDetailView.coverImageView.kf.setImage(with: url)
        }
        

        
        
        if let ownerId = self.book.ownerId {
            
            //configure button
            print("running")
            print(ownerId)
            FliptAPIClient.getUserFrom(ownerId, completion: { (user) in
                print("running")
                self.owner = user
               // OperationQueue.main.addOperation {
                    
                    if let userid = user.userid {
                        print(userid)
                        FirebaseApi.checkIfBlocked(userID: userid, completion: { (isBlocked) in
                            if isBlocked {
                                OperationQueue.main.addOperation {
                                    self.bookDetailView.bookOwnedByLabel.text = "This user is blocked"
                                    self.bookDetailView.messageOwnerBtn.isEnabled = false
                                    self.bookDetailView.messageOwnerBtn.isUserInteractionEnabled = false
                                }
                            } else {
                                if let firstname = user.firstname, let lastname = user.lastname {
                                    
                                    
                                    self.bookDetailView.bookOwnedByLabel.text = "This book is owned by \(firstname) \(lastname.characters.first!)"
                                    dump(user)
                                    
                                    // .substring(to: name.index(before: name.endIndex))
                                }
                            }
                            

                        })
                        
                    }
                    
               // }
                //
                
            })
        
        }
        
        
     
        
    }
    
    
    func contactOwner() {
        print("Opening chat")
        //open chat
        let msgViewController = MessagesViewController()
        msgViewController.book = self.book
        //print(self.owner)
        if let firstname = self.owner.firstname, let lastname = self.owner.lastname {
            let lname = self.owner.lastname.characters.first!
        
            msgViewController.recipient = "\(firstname) \(lname)"
        }
        msgViewController.recipientId = self.owner.userid
        self.present(msgViewController, animated: true, completion: nil)
        //self.navigationController?.pushViewController(msgViewController, animated: true)
    }
    
    
}
