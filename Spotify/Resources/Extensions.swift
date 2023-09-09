//
//  Extension.swift
//  Spotify
//
//  Created by LE BA TRONG on 28/01/2022.
//

import Foundation
import UIKit

extension UIView {
    var width: CGFloat {
        return frame.size.width
    }

    var height: CGFloat {
        return frame.size.height
    }

    var left: CGFloat {
        return frame.origin.x
    }

    var right: CGFloat {
        return left + width
    }

    var top: CGFloat {
        return frame.origin.y
    }

    var bottom: CGFloat {
        return top + height
    }
}

extension DateFormatter {
    static let dateFomatter:DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter
    }()
    //display datefomatter
    static let displayDateFomatter:DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
}

extension String {
    static func formattedDate(string:String) -> String {
        guard let date = DateFormatter.dateFomatter.date(from: string) else {
            return string
        }
        return DateFormatter.displayDateFomatter.string(from: date)
    }
}


