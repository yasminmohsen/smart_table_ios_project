//
//  Mapping.swift
//  smartble
//
//  Created by Yasmin Mohsen on 19/03/2021.
//

import Foundation


class MappedModel {
    
   static func converTestModel(_ tableInfo:TableInfoModel) -> [[String]] {
        
        var sunday = [String]()
        var monday = [String]()
        var tuesday = [String]()
        var wednsday = [String]()
        var thursday = [String]()
        
        
        for (index,obj) in tableInfo.teacher_cellModels.enumerated() {
            
            if(index<7){
                
                sunday.append(obj.cell_text)
            }
            
            if(index>=7 && index <= 13){
                
                monday.append(obj.cell_text)
            }
            
            
            if(index>13 && index <= 20){
                
                tuesday.append(obj.cell_text)
            }
            
            
            if(index>20 && index <= 27){
                
                wednsday.append(obj.cell_text)
            }
            
            
            if(index>27 && index <= 34){
                
                thursday.append(obj.cell_text)
            }
            
        }
        
  
        var classesArray = [sunday,monday,tuesday,wednsday,thursday]
        
        
        
        return classesArray
    }
    
    
    
    
    
    
    
}
