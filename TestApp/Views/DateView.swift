//
//  DateView.swift
//  TestApp
//
//  Created by Georges Jamous on X/X/X.
//  Copyright © 2020 Georges Jamous. All rights reserved.
//

import UIKit

class DateView: UIView {
    
    enum Dimension {
        static let Width: CGFloat = 100.00
        static let Height: CGFloat = 25.00
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViewOnInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let dateLabel : UILabel = {
        let label = UILabel()
        label.textColor = AppTheme.Colors.TextPrimary
        label.font = UIFont.systemFont(ofSize: AppTheme.FontSize.Footnote)
        label.textAlignment = .right
        label.numberOfLines = 1
        label.backgroundColor = UIColor.clear
        return label
    }()

    private let calendarIcon : UIImageView = {
        var calendarIcon = UIImage(named: "IconCalendar")
        let imageView = UIImageView.init(image: calendarIcon)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    func buildViewOnInit(){
        self.backgroundColor = UIColor.clear
        self.addSubview(calendarIcon)
        self.addSubview(dateLabel)
        
        // place icon component
        // we will keep it vertically centered
        calendarIcon.anchor(
            top: self.topAnchor,
            left: self.leftAnchor,
            bottom: self.bottomAnchor,
            right: nil,
            paddingTop: 5,
            paddingLeft: 0,
            paddingBottom: 5,
            paddingRight: 0,
            width: 0,
            height: 0,
            enableInsets: false
        )
        
        // place title component
        dateLabel.anchor(
            top: self.topAnchor,
            left: nil,
            bottom: self.bottomAnchor,
            right: self.rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0,
            width: 75,
            height: 0,
            enableInsets: false)
    }

    
    public func setDate(date: String) {
        dateLabel.text = date
    }
}
