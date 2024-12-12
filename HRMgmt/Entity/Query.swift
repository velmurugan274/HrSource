//
//  Query.swift
//  zpeople
//
//  Created by vel-pt2332 on 14/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class Query {
    private var queryId : String
    private var senderId : String
    private var recieverId : String
    private var question : String
    private var questionSubject : String
    private var date : Int
    
    init(queryId : String, senderId : String, recieverId : String, question: String, questionSubject: String, date : Int){
        self.queryId = queryId
        self.senderId = senderId
        self.recieverId = recieverId
        self.question = question
        self.questionSubject = questionSubject
        self.date = date
    }
    
    func getQueryId() -> String{
        return queryId
    }
    
    func getRecieverId() -> String{
        return recieverId
    }
    
    func getSenderId() -> String{
        return senderId
    }
    func getQuestion() -> String{
        return question
    }
    
    func getDate() -> Int{
        return date
    }
    
    func getQuestionSubject() -> String{
        return questionSubject
    }
}
