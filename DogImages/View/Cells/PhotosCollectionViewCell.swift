//
//  PhotosCollectionViewCell.swift
//  DogImages
//
//  Created by Александр Кузьминов on 29.08.23.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    lazy var numberOfPhoto: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textAlignment = .center
        label.textColor = .black
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imagePhoto: CustomImageView = {
        let image = CustomImageView()
        image.backgroundColor = .systemPink
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var labelBreed:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func checkEmptyText() {
        if labelBreed.text?.isEmpty == true {
            labelBreed.backgroundColor = .clear
        } else {
            labelBreed.backgroundColor = .white
        }
    }
    
    func config(with model: CatsListModel) {
        numberOfPhoto.text = model.numberOfCats
        imagePhoto.load(urlString: model.image)
        labelBreed.text = model.breed
    }
    
    func configUI(){
        self.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.borderWidth = 3
        self.backgroundColor = .green
        self.addSubview(imagePhoto)
        self.addSubview(labelBreed)
        self.addSubview(numberOfPhoto)
        configLayout()
    }
    
    func configLayout(){
        NSLayoutConstraint.activate([
        imagePhoto.widthAnchor.constraint(equalToConstant: self.bounds.size.width),
        imagePhoto.heightAnchor.constraint(equalToConstant: self.bounds.size.height),
        imagePhoto.topAnchor.constraint(equalTo: self.topAnchor,constant: 0),
        imagePhoto.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 0),
        
        labelBreed.widthAnchor.constraint(equalToConstant: self.bounds.width - 16),
        labelBreed.heightAnchor.constraint(equalToConstant: 15),
        labelBreed.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: 18),
        labelBreed.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        
        numberOfPhoto.widthAnchor.constraint(equalToConstant: 20),
        numberOfPhoto.heightAnchor.constraint(equalToConstant: 20),
        numberOfPhoto.topAnchor.constraint(equalTo: self.topAnchor,constant: 5),
        numberOfPhoto.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -5)
        ])
    }
    
    func changeCell(isSwitched:Bool){
        if isSwitched{
            self.imagePhoto.backgroundColor = .purple
            self.imagePhoto.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
            
            self.labelBreed.textColor = .white
        }else{
            self.imagePhoto.backgroundColor = .systemPink
            self.imagePhoto.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
            
            self.labelBreed.textColor = .black

        }
    }
}
