//
//  ViewModel.swift
//  Feeds
//
//  Created by Sarathi M on 9/14/21.
//

import UIKit

class LoadingCell: UITableViewCell {
    var activityIndicator: UIActivityIndicatorView = {
        let activity =  UIActivityIndicatorView()
        activity.backgroundColor = UIColor.clear
        activity.color = UIColor.darkGray
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        addSubview(activityIndicator)
        
        activityIndicator.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 30).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
