//
//  Extension+String.swift
//  TestFanInteraksi
//
//  Created by reyhan muhammad on 27/05/24.
//

import Foundation
import UIKit

extension String {
    func getEmailName() -> String{
        guard let indexForAddress = self.enumerated().first(where: {$0.element == "@"})?.offset else{return ""}
        let name = NSString(string: self).substring(with: .init(location: 0, length: indexForAddress))
        return name
    }
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            let attrString = try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            attrString.addAttribute(.foregroundColor, value: UIColor.primaryForegroundColor, range: NSRange(location: 0, length: attrString.string.count))
            attrString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 0, length: attrString.string.count))
            return attrString
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func getDate(format: String) -> Date?{
        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = format
        
        return dateFormatter.date(from: self)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}
