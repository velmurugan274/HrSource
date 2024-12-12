//
//  QueryReplies.swift
//  zpeople
//
//  Created by vel-pt2332 on 14/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class QueryReplies {
    private var replyId : String
    private var reply : String
    private var repliedBy : String
    
    init(replyId : String, reply : String, repliedBy : String){
        self.reply = reply
        self.replyId = replyId
        self.repliedBy = repliedBy
    }
    
    func getReplyId() -> String{
        return replyId
    }
    
    func getReply() -> String{
        return reply
    }
    
    func getRepliedBy() -> String{
        return repliedBy
    }
}
