//
//  FilterCollectionViewCell.swift
//  TestFanInteraksi
//
//  Created by reyhan muhammad on 28/05/24.
//

import Foundation
import UIKit

class FilterCollectionViewCell: UICollectionViewCell{
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addTitleLabel()
    }
    
    func setupUI(){
        addTitleLabel()
    }
    
    func addTitleLabel(){
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        ])
    }
    
    func setupCell(text: String, isActive: Bool){
        titleLabel.text = text
        titleLabel.font = .systemFont(ofSize: 12)
        backgroundColor = isActive ? .oppositeSecondaryBackgroundColor:.secondaryBackgroundColor
        titleLabel.textColor = isActive ? .oppositePrimaryForegroundColor:.primaryForegroundColor
        titleLabel.textAlignment = .center
        layer.cornerRadius = frame.height / 2
    }
}
