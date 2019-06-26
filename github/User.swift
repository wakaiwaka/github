//
//  File.swift
//  github
//
//  Created by 若原昌史 on 2018/07/31.
//  Copyright © 2018年 若原昌史. All rights reserved.
//

final class User{
    let id:Int
    let name:String
    let iconURL:String
    let webURL:String
    
    init(attributes:[String:Any]){
        id = attributes["id"] as! Int
        name = attributes["login"] as! String
        iconURL = attributes["avatar_url"] as! String
        webURL = attributes["html_url"] as! String
    }
}
