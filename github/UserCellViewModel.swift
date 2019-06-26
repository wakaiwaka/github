//
//  UserCellViewModel.swift
//  github
//
//  Created by 若原昌史 on 2018/08/01.
//  Copyright © 2018年 若原昌史. All rights reserved.
//

import Foundation
import UIKit

extension UIImage{
    convenience init?(color:UIColor,size:CGSize){
        let rect = CGRect(origin:.zero,size:size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else{
            return  nil
        }
        self.init(cgImage:cgImage)
    }
}


enum ImageDownloadProgress{
    case loading(UIImage)
    case finish(UIImage)
    case error
}

final class UserCellViewModel{
    
    private var user:User
    
    private let imageDownloader = ImageDownloader()
    
    private var isLoading = false
    
    var nichName:String{
        return user.name
    }
    
    var webURL:URL{
        return URL(string: user.webURL)!
    }
    init(user:User) {
        self.user = user
    }
    
    func downloadImage(progress:@escaping(ImageDownloadProgress)->Void){
        if isLoading == true{
            return
        }
        isLoading = true
        
        let loadingImage = UIImage(color:.gray,size:CGSize(width: 45, height: 45))!
        progress(.loading(loadingImage))
        
        imageDownloader.downloadImage(imageURL:user.iconURL,success:{
         (image) in
            progress(.finish(image))
            self.isLoading = false
        }){
            (error) in
            progress(.error)
            self.isLoading = false
        }
        
    }
    
}




