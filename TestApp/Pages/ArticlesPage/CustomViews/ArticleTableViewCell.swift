//
//  ArticleTableViewCell.swift
//  TestApp
//
//  Created by Georges Jamous on X/X/X.
//  Copyright © 2020 Georges Jamous. All rights reserved.
//

import UIKit

// Quick impl of the cell in code
// this can be replaced by a swiftui view for cleaner maintenance

class ArticleTableViewCell: UITableViewCell {
    
    static let identifier = "ArticleTableViewCell"
    
    // Chnaging any of these may require re-calculation of cell components
    public enum Dimension {
        static let Height: CGFloat = 150.00
        static let IconSize: CGFloat = 50.00
    }
    
    // Chnaging any of these may require re-calculation of cell components
    private enum Spacing {
        static let Normal: CGFloat = 10.00
        static let Small: CGFloat = 6.00
    }

    private let articleTitleLabel : UILabel = {
        let label = UILabel()
        label.textColor = AppTheme.Colors.TextPrimary
        label.font = UIFont.boldSystemFont(ofSize: AppTheme.FontSize.Headline)
        label.textAlignment = .left
        label.numberOfLines = 3
        return label
    }()
    
    private let articleDescriptionLabel : UILabel = {
        let label = UILabel()
        label.textColor = AppTheme.Colors.TextSecondary
        label.font = UIFont.systemFont(ofSize: AppTheme.FontSize.Body)
        label.textAlignment = .left
        label.numberOfLines = 4
        return label
    }()
    
    private let articleIcon : URLImageView = {
        let imageView = URLImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.white
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Dimension.IconSize/2
        return imageView
    }()
    
    private let articleDate : DateView = {
        let dateView = DateView()
        return dateView
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
        self.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        // All cell components should go inside the content view.
        self.contentView.clipsToBounds = true
        self.contentView.isUserInteractionEnabled = true
        self.contentView.addSubview(articleIcon)
        self.contentView.addSubview(articleTitleLabel)
        self.contentView.addSubview(articleDescriptionLabel)
        self.contentView.addSubview(articleDate)

        // place icon component
        // we will keep it vertically centered
        let iconTopBottomPadding = (Dimension.Height - Dimension.IconSize)/2
        articleIcon.anchor(
            top: self.contentView.topAnchor,
            left: self.contentView.leftAnchor,
            bottom: self.contentView.bottomAnchor,
            right: nil,
            paddingTop: iconTopBottomPadding,
            paddingLeft: Spacing.Normal,
            paddingBottom: iconTopBottomPadding,
            paddingRight: 0,
            width: Dimension.IconSize,
            height: Dimension.IconSize,
            enableInsets: false
        )

        // place title component
        articleTitleLabel.anchor(
            top: self.contentView.topAnchor,
            left: articleIcon.rightAnchor,
            bottom: nil,
            right: self.contentView.rightAnchor,
            paddingTop:  Spacing.Normal,
            paddingLeft: Spacing.Normal,
            paddingBottom: 0,
            paddingRight: 0,
            width: 0,
            height: 0,
            enableInsets: false)

        // place description component
        articleDescriptionLabel.anchor(
            top: articleTitleLabel.bottomAnchor,
            left: articleIcon.rightAnchor,
            bottom: nil,
            right: self.contentView.rightAnchor,
            paddingTop: Spacing.Small,
            paddingLeft: Spacing.Normal,
            paddingBottom: 0,
            paddingRight: 0,
            width: 0,
            height: 0,
            enableInsets: false)

        
        // place date component
        articleDate.anchor(
            top: articleDescriptionLabel.bottomAnchor,
            left: nil,
            bottom: self.contentView.bottomAnchor,
            right: self.contentView.rightAnchor,
            paddingTop: Spacing.Small,
            paddingLeft: 0,
            paddingBottom: Spacing.Normal,
            paddingRight: 0,
            width: DateView.Dimension.Width,
            height: DateView.Dimension.Height,
            enableInsets: false)
    }
    
    var article : Article? {
        didSet {
            articleTitleLabel.text = article?.title
            articleDescriptionLabel.text = article?.abstract
            articleDate.setDate(date: article?.published_date ?? "")
            if let url = article?.getArticleMediaIconURL() {
                articleIcon.loadFromURL(url: url)
            }
        }
    }
}
