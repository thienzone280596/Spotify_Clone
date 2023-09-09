//
//  FeaturePlaylistCollectionViewCell.swift
//  Spotify
//
//  Created by LE BA TRONG on 08/02/2022.
//

import UIKit

class FeaturePlaylistCollectionViewCell: UICollectionViewCell {
    static let identifier = "FeaturePlaylistCollectionViewCell"
        //Feature playlist cover Image View
        private let playlistCoverImageView:UIImageView = {
           let imageView = UIImageView()
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = 4
            imageView.image = UIImage(systemName: "photo")
            imageView.contentMode = .scaleAspectFill
            return imageView
        }()
        //album label
        private let playlistNameLabel:UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 18, weight: .regular)
            label.textAlignment = .center
            label.numberOfLines = 0
            return label
        }()
     
        //artirt name
        private let creatorNameLabel:UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 15, weight: .thin)
            return label
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
           
            contentView.addSubview(playlistCoverImageView)
            contentView.addSubview(playlistNameLabel)
            contentView.addSubview(creatorNameLabel)
            contentView.clipsToBounds = true
        }
        
        required init?(coder: NSCoder) {
            fatalError()
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            creatorNameLabel.frame = CGRect(x: 3,
                                            y: contentView.height-30,
                                            width: contentView.width-6,
                                            height: 30)
            
            playlistNameLabel.frame = CGRect(x: 3,
                                            y: contentView.height-60,
                                            width: contentView.width-6,
                                            height: 30)
            
            let imageSize = contentView.height - 70
            
            playlistCoverImageView.frame = CGRect (x: (contentView.width-imageSize)/2,
                                                   y: 3,
                                                   width: imageSize,
                                                   height: imageSize)
            
            
        }
        
        override func prepareForReuse() {
            super.prepareForReuse()
            playlistNameLabel.text = nil
            playlistCoverImageView.image = nil
            creatorNameLabel.text = nil
        }
        //configure
        func configure(with viewModel: FeaturedPlaylistCellViewModel) {
            //Hien thi noi dung trong cell
            playlistNameLabel.text = viewModel.name
            playlistCoverImageView.sd_setImage(with: viewModel.artworkULR, completed: nil)
            creatorNameLabel.text = viewModel.creatorName
            
        }
}
