//
//  Servoce.swift
//  Nutee
//
//  Created by Junhyeon on 2020/01/06.
//  Copyright © 2020 Junhyeon. All rights reserved.
//

struct APIConstants {

    static let BaseURL = "http://15.164.50.161:9425"
        
    static let User = BaseURL + "/api/user"                                     // GET
    static let UserPost = BaseURL + "/api/user"                                 // POST { userId : asdf123, password : 123123, nickname : 테스트닉네임, schoolEmail : 1234567@office.skhu.ac.kr }
    static let OTPsend = BaseURL + "/api/user/otpsend"                          // POST { "schoolEmail":"1234567@office.skhu.ac.kr"}
    static let OTPcheck = BaseURL + "/api/user/otpcheck"                        // POST { "otpcheck" : "123456"}

    static let FindId = BaseURL + "/api/user/findid"                            // POST { "schoolEmail":"1234567@office.skhu.ac.kr"}
    static let Reissuance = BaseURL + "/api/user/reissuance"                    // POST { "userId":"abc", "schoolEmail":"1234567@office.skhu.ac.kr"}

    static let PostPost = BaseURL + "/api/post"                                 // POST formData : image filename , content : content
    static let PostGET = BaseURL + "/api/post/:id"                              // GET 뒤에 아이디 값을 넣어야 함                 // 아이디가 게시물의 id?
    static let PostDelete = BaseURL + "/api/post/:id"                           // DELETE 뒤에 아이디 값을 넣어줘야함              // "
    static let Posts = BaseURL + "/api/posts"                                   // GET +++"?offset=0&limit=10" <-- limit는 가져올 posts의 개수(10)
    static let UserPostsGET = BaseURL + "/api/user/:id/posts/"                  // GET
    
    
    static let Hashtag = BaseURL + "/api/hashtag"                               // GET
    static let Notice = BaseURL + "/api/notice"                                 // GET
    static let image = BaseURL + "/api/post/images"                             // POST formData : image : binary
    static let CommentsGet = BaseURL + "/api/post/:id/comments"                 // GET
    static let CommentsPost = BaseURL + "/api/post/:id/comments"                // POST requestPayload     {postId : postId ,  content: content}

    
    static let LikePost = BaseURL + "/api/post/:id/like"                        // POST
    static let LikeDelete = BaseURL + "/api/post/:id/like"                      // DELETE           {postId : postID}

    static let ReportPost = BaseURL + "/api/post"// /:id/report"                    // POST {"content":"신고 사유", "PostId":"123"}
    
    static let Retweet = BaseURL + "/api/post/:id/retweet"                      // POST {postId : postId}
    static let UserId = BaseURL + "/api/user/:id"                               // GET
    
    
    static let Logout = BaseURL + "/api/user/logout"                            // POST
    static let Login = BaseURL + "/api/user/login"                              // POST { userId : id , password: pw }
    
    
    static let FollowingGET = BaseURL + "/api/user/:id/followings"              // GET
   
    
    static let FollowDELETE = BaseURL + "/api/user/:id/follow"                  // DELETE  { userId : id }
    static let FollowPOST = BaseURL + "/api/user/:id/follow"                    // POST    { userId : id }
    
    
    static let FollowerGET = BaseURL + "/api/user/:id/followers?offset=0&limit=10" // GET <-- limit는 가져올 followers의 개수(10)
    static let FollowerDELETE = BaseURL + "/api/user/:id/followers"             // DELETE  { userId : id }
    static let FollowerPOST = BaseURL + "/api/user/:id/followers"               // POST    { userId : id }

    
    static let NickNamePatch = BaseURL + "/api/user/nickname"                   // PATCH
    static let ProfileImagePost = BaseURL + "/api/user/profile"                 // POST
    
}
