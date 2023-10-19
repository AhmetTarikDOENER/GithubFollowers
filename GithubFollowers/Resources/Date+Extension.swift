//
//  Date+Extension.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 19.10.2023.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
}
