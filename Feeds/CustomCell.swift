//
//  CustomCell.swift
//  Feeds
//
//  Created by Sarathi M on 9/15/21.
//

import UIKit

class CustomCell: UITableViewCell {
    
    var data: ChildData? {
        didSet {
            if let obj = data {
                
                //render data in all fields
                titleLabel.text = obj.title
                commentLabel.text = "Comments: \(obj.numComments!)"
                scoreLabel.text = "Score: \(obj.score!)"
                
                //update imageview constraints based on height, width, image url exists or not exists
                if let width = data?.thumbnailWidth, let height = data?.thumbnailHeight, let _ = URL(string: obj.thumbnail ?? "")  {
                    //if url, height and width is found in data then set
                    imagView.widthAnchor.constraint(equalToConstant:CGFloat(width)).isActive = true
                    imagView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
                } else {
                    //if url, height and width is not found in data then set to 0 for height and width of the imageview
                    imagView.widthAnchor.constraint(equalToConstant:CGFloat(0)).isActive = true
                    imagView.heightAnchor.constraint(equalToConstant: CGFloat(0)).isActive = true
                }
                
                //download image
                imagView.downloadImage(url: data?.thumbnail)
            }
        }
    }
    
    //properties declared as closure aka function
    var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.numberOfLines = 0         //enable multi line label text
        lbl.lineBreakMode = .byWordWrapping
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var imagView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    var commentLabel : UILabel =  {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 9)
        return lbl
    }()
    
    var scoreLabel : UILabel =  {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 9)
        return lbl
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        //cell seperator line
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        stackView.addArrangedSubview(commentLabel)
        stackView.addArrangedSubview(scoreLabel)

        addSubview(titleLabel)
        addSubview(imagView)
        addSubview(stackView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        //enable autolayouts
        stackView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        imagView.translatesAutoresizingMaskIntoConstraints = false

        //set constraints for title label
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 10).isActive = true
        
        //set constraints for image view
        imagView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        imagView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true

        //set constraints for stack view
        stackView.topAnchor.constraint(equalTo: imagView.bottomAnchor, constant: 10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
    }
    
    //no xib/storyboard has been implemented
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
