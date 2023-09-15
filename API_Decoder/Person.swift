//
//  Person.swift
//  API_Decoder
//
//  Created by apple on 10/08/23.
//

import Foundation
struct APIResponse : Decodable {
    var page : Int
    var per_page : Int
    var total : Int
    var total_pages : Int
    var data2 : [Person]
    var support : Support
}
struct Person : Decodable{
    var id : Int
    var email : String
    var first_name : String
    var last_name : String
    var avatar : String
}
struct Support : Decodable{
    var url : String
    var text : String
}
