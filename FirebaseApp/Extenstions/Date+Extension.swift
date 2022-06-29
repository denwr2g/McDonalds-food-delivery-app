//
//  Date+Extension.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 26/05/2022.
//

import Foundation

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
