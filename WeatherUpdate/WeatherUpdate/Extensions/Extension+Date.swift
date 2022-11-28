//
//  Extension+Date.swift
//  WeatherUpdate
//
//  Created by Md. Faysal Ahmed on 25/11/22.
//

import Foundation

extension Date {
    func convertDateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh"
        
        let comp: DateComponents = Calendar.current.dateComponents([.hour], from: self)
        let startOfMonth = Calendar.current.date(from: comp)!
        
        return (dateFormatter.string(from: startOfMonth))
    }
}
