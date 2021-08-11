//
//  Result.swift
//  Swift Co-Pilot
//
//  Created by Prabaljit Walia on 05/08/21.
//

import Foundation
struct Result:Decodable {
    let ip_address:[ResultBody]
}
struct ResultBody:Decodable{
    let code:String
    let title:String
}


struct RawServerResponse:Decodable{
    enum RootKeys:String,CodingKey{
        case ip_address
    }
//    enum IPKey:String,CodingKey{
//        case code,title
//    }
    let code:String
    let title:String
    
    init(from decoder: Decoder) throws {
        let outerContainer = try decoder.container(keyedBy: RootKeys.self)
        let ipContainer = try outerContainer.decode(ResultBody.self, forKey: .ip_address)
        self.code = ipContainer.code
        self.title = ipContainer.title
        }
}

