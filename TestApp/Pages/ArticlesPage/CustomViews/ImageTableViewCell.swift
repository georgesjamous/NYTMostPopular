//
//  ArticleTableViewCell.swift
//  TestApp
//
//  Created by Georges Jamous on X/X/X.
//  Copyright © 2020 Georges Jamous. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    private let articleIcon : URLImageView = {
        let imageView = URLImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildCellOnInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // buildCellOnInit should be called only once when the cell is initialized
    // this generates all cell components.
    private func buildCellOnInit() {        
        // All cell components should go inside the content view.
        self.contentView.clipsToBounds = true
        self.contentView.isUserInteractionEnabled = true
        self.contentView.addSubview(articleIcon)
        
        articleIcon.anchor(
            top: self.contentView.topAnchor,
            left: self.contentView.leftAnchor,
            bottom: self.contentView.bottomAnchor,
            right: self.contentView.rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0,
            width: 0,
            height: 0,
            enableInsets: false
        )
    }
    
    
    var article : Article? {
        didSet {
            if let url = article?.getArticleMediaIconURL() {
                articleIcon.loadFromURL(url: url)
            }
        }
    }
}

