//
//  Recept.swift
//  FoodHub
//
//  Created by Student on 2018. 03. 05..
//  Copyright © 2018. Student. All rights reserved.
//

import Foundation



class cookBookModel{
    class singleRecept{
        var name : String
        var shortDesc : String
        var difficulty : Int
        init(name : String, shortDesc : String, difficulty : Int) {
            self.name = name
            self.shortDesc = shortDesc
            self.difficulty = difficulty
        }
    }
    
    var container : Array<singleRecept> = Array<singleRecept>()
    init(number : Int) {
        for _ in 1..<number{
            let rec = singleRecept(name : "Porkolt", shortDesc : "ez porkolt.", difficulty : number)
            container.append(rec)
        }
        
    }
    func getItem(pos : Int)->singleRecept? {
        guard pos <= container.count else{
            return nil
        }
        return container[pos]
    }
}
