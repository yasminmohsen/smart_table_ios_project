//
//  Mapping.swift
//  smartble
//
//  Created by Yasmin Mohsen on 19/03/2021.
//

import Foundation


class MappedModel {
    
     func converTableModelToClasses(_ tableInfo:TableInfoModel) -> [[String]] {
        var nameArray = [[String]]()
     
            let numbers = tableInfo.teacher_cells
            let chunkSize = 7
            let chunks = stride(from: 0, to: numbers.count, by: chunkSize).map {
                Array(numbers[$0..<min($0 + chunkSize, numbers.count)])
            }
  
        nameArray = chunks.map({$0.map({$0.cell_text!})})
        
        return nameArray
    }
    
    
    
    
    
    
        
        
        
    
}
