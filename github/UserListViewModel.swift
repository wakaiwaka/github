//
//  UserListViewModel.swift
//  github
//
//  Created by 若原昌史 on 2018/08/01.
//  Copyright © 2018年 若原昌史. All rights reserved.
//

import Foundation
import UIKit

enum ViewModelState{
    case loading
    case finish
    case error(Error)
}

final class UserListViewModel{
    
    var stateDidUpdate:((ViewModelState)->Void)?
    
    private var users = [User]()
    
    var cellViewModels = [UserCellViewModel]()
    
    let api = API()
    
    func getUsers(){
        stateDidUpdate?(.loading)
        users.removeAll()
        
        api.getUsers(success:{
            (users) in
            self.users.append(contentsOf: users)
            for user in users{
                let cellViewModel = UserCellViewModel(user:user)
                self.cellViewModels.append(cellViewModel)
                self.stateDidUpdate?(.finish)
            }
        }){(error) in
            self.stateDidUpdate?(.error(error))
        }
    }
    
    func usersCount() -> Int{
        return users.count
    }
    
}

