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
        
        
        for (index,obj) in tableInfo.teacher_cells.enumerated() {
            
            if(index<7){
                if let text = obj.cell_text{
                    sunday.append(text)
                }
                else{
                    sunday.append("None")
                }
            }
            
            if(index>=7 && index <= 13){
                
                if let text = obj.cell_text{
                    monday.append(text)
                }
                else{
                    monday.append("None")
                }
            }
            
            
            if(index>13 && index <= 20){
                
                if let text = obj.cell_text{
                    tuesday
                        .append(text)
                }
                else{
                    tuesday.append("None")
                }
            }
            
            
            if(index>20 && index <= 27){
                
                if let text = obj.cell_text{
                    
                    wednsday.append(text)
                }
                else{
                    wednsday.append("None")
                }
            }
            
            
            if(index>27 && index <= 34){
                
                if let text = obj.cell_text{
                    thursday.append(text)
                }
                else{
                    thursday.append("None")
                }
            }
            
        }
        
  
        var classesArray = [sunday,monday,tuesday,wednsday,thursday]
        
        
        
        return classesArray
    }
    
    
    
    
    
    
    
}
