//
//  User.swift
//  Loic&Flo
//
//  Created by Florian Cartier on 16/05/2017.
//  Copyright © 2017 Florian Cartier. All rights reserved.
//

import Foundation

class User {
    private var id: String
    private var login: String
    
    init() {
        id = ""
        login = ""
    }
    
    func getId() -> String {
        return self.id
    }
    
    func getLogin() -> String {
        return login
    }
    
    func setId(id: String) {
        self.id = id
    }
    
    func setLogin(l: String){
        self.login = l
    }
}
