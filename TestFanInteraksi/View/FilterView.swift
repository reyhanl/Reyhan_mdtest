//
//  FilterView.swift
//  TestFanInteraksi
//
//  Created by reyhan muhammad on 28/05/24.
//

import Foundation
import UIKit

class FilterView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    var options: [Filter] = [.nonVerified, .verified, .none]
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Filter"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var filter: Filter{
        return options[isSelectedIndex]
    }
    var delegate: FilterViewDelegate?
    var isSelectedIndex: Int = 2{
        didSet{
            delegate?.userDidSelectFilter(filter: options[isSelectedIndex])
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .oppositePrimaryBackgroundColor.withAlphaComponent(0.2)
        isUserInteractionEnabled = true
        layer.cornerRadius = 5
        addFilterText()
        addCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func addFilterText(){
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: titleLabel, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 10)
        ])
    }
    
    func addCollectionView(){
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .leading, relatedBy: .equal, toItem: titleLabel, attribute: .trailing, multiplier: 1, constant: 10)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FilterCollectionViewCell
        cell.setupCell(text: options[indexPath.row].rawValue, isActive: indexPath.row == isSelectedIndex)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        isSelectedIndex = indexPath.row
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: options[indexPath.row].rawValue.width(withConstrainedHeight: self.frame.height - 10, font: titleLabel.font), height: self.frame.height - 10)
    }
}

protocol FilterViewDelegate{
    func userDidSelectFilter(filter: Filter)
}

enum Filter: String{
    case verified = "verified"
    case nonVerified = "not verified"
    case none = "none"
}
