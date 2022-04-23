//
//  Helper.swift
//  FlightLinfo
//
//  Created by Uresha Lakshani on 2022-04-23.
//

import Foundation

class Helpers {
    
    enum DateFormats: String{
        case dateformatLong = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        case dateformatLong2 = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        case dateformatLong3 = "yyyy-MM-dd'T'HH:mm:SSS'Z'"
        case dateformatBig = "yyyy-MM-dd'T'HH:mm:ssZ"
        case dateformatBig2 = "yyyy-MM-dd'T'HH:mm:ss"
        case dateformatYMD = "yyyy-MM-dd"
        case dateformatYMDHMS = "yyyy-MM-dd HH:mm:ss"
        case dateformatYMDHM = "yyyy-MM-dd HH:mm"
        case dateformatDMY = "dd MMM yyyy"
        case dateformatDMYHMA = "dd-MMM-yyyy '|' hh:mm a"
        case dateformatEDMMM = "E, d MMM"
        case dateformateMMMDD = "MMM dd"
        case dateformateHHMM = "HH:mm"
        case dateformateHHMMA = "HH:mm a"
        case dateformatehmma = "hh:mm a"
        case dateformateMMMDDYYY = "MMM dd, yyyy"
        case dateformatDMY2 = "dd MM yyyy"
        case dateformatD = "dd"
        case dateformatM = "MM"
        case dateformatY = "yyyy"
        case dateformatHH = "HH"
        case dateformathh = "hh"
        case dateformatMM = "mm"
        case dateformatA = "a"
        case dateformatDD_MM_YY = "MM/dd/yyyy H:mm:ss"
        case dateformateHMSZ = "HH:mm:ss.SSS"
        case dateformatYDMHMA = "yyyy-MMM-dd '|' hh:mm a"
        case dateformatYDMHMA2 = "yyyy-MMM-dd hh:mm a"
        case dateformatMDYHMA2 = "MMM dd yyyy hh:mm a"
    }
    
    static func getDateFormater(format: DateFormats) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format.rawValue
        return formatter
    }
    
    static func getDateFormater(format: DateFormats, locale: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: locale)
        formatter.dateFormat = format.rawValue
        return formatter
    }
    
    static func parseApiDateString(_ dateString: String, format: DateFormats) -> String {
        if let date1 = Helpers.getDateFormater(format: .dateformatBig).date(from: dateString) {
            return Helpers.getDateFormater(format: format).string(from: date1)
        } else if let date2 = Helpers.getDateFormater(format: .dateformatLong2).date(from: dateString) {
            return Helpers.getDateFormater(format: format).string(from: date2)
        } else if let date3 = Helpers.getDateFormater(format: .dateformatLong3).date(from: dateString) {
            return Helpers.getDateFormater(format: format).string(from: date3)
        }else if let date4 = Helpers.getDateFormater(format: .dateformatYMDHMS).date(from: dateString) {
            return Helpers.getDateFormater(format: format).string(from: date4)
        }else if let date5 = Helpers.getDateFormater(format: .dateformatDD_MM_YY).date(from: dateString) {
            return Helpers.getDateFormater(format: format).string(from: date5)
        } else {
            return ""
        }
    }
    
}
