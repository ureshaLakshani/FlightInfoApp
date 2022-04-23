//
//  ValidationPatterns.swift
//  FlightLinfo
//
//  Created by Uresha Lakshani on 2022-04-23.
//

import Foundation

class ValidationPatterns{
    
    static let shared = ValidationPatterns()
    
    let emailPattern = #"^\S+@\S+\.\S+$"#
    let passwordPattern =
        // At least 8 characters
        #"(?=.{8,})"# 
  
}
