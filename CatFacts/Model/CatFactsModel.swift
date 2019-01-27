//
//  CommentModel.swift
//  CatFacts
//
//  Created by  William on 1/23/19.
//  Copyright © 2019 Vasiliy Lada. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

/**
 Downloads data from remote server and executes required action if response result is successful.
 
 - Parameters:
   - completion: an action to be executed if response result is sucessful
   - response: server response data in JSON format
*/
func getServerData(_ completion: @escaping (_ response: JSON) -> ()) {
    Alamofire.request("https://cat-fact.herokuapp.com/facts").responseJSON { (response) in
        guard response.result.error == nil else {
            print(response.result.error!)
            return
        }
        
        let json = JSON(response.result.value!)
        completion(json)
    }
}

class Comment {
    var firstName: String?
    var lastName: String?
    var text: String?
}

extension Comment {
    
    /**
     Parses JSON data to form array of loaded comments.
     
     - Parameters:
       - json: expected server response data in JSON format
     
     - Returns:
     Array of extracted comments from JSON data.
     The array may be empty if there is no comments in the response data
     or the structure of the JSON is in unknown format.
    */
    static func parse(_ json: JSON) -> [Comment] {
        var comments = [Comment]()
        
        guard let commentsJSONArray = json["all"].array else {
            return comments
        }
        
        for commentJSON in commentsJSONArray {
            let comment = Comment()
            comment.firstName = commentJSON["user"]["name"]["first"].string
            comment.lastName = commentJSON["user"]["name"]["last"].string
            comment.text = commentJSON["text"].string
            
            comments.append(comment)
        }
        
        return comments
    }
}
