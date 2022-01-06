//
//  Mapping.swift
//  smartble
//
//  Created by Yasmin Mohsen on 19/03/2021.
//

import Foundation


class MappedModel {
    
    func converTableModelToClasses(_ tableInfo:TableInfoModel) -> [[(String,Bool)]] {
        var nameArray = [[(String,Bool)]]()
     
            let numbers = tableInfo.teacher_cells
        let classNumbers = tableInfo.classes.count
        /***/
        let chunkSize = classNumbers
        /***/
            let chunks = stride(from: 0, to: numbers.count, by: chunkSize).map {
                Array(numbers[$0..<min($0 + chunkSize, numbers.count)])
            }
  
        nameArray = chunks.map({$0.map({($0.cell_text!,$0.isWaiting)})})
        
        return nameArray
    }
    
   
}
