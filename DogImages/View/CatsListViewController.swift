//
//  ViewController.swift
//  DogImages
//
//  Created by Александр Кузьминов on 29.08.23.
//

import UIKit

class CatsListViewController: UIViewController {
    private let vm = CatsListViewModel()

    lazy var collectionViewPhotos:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        collection.layer.borderWidth = 3
        return collection
    }()
    
    lazy var switcher:UISwitch = {
        let switcH = UISwitch()
        switcH.isOn = false
        switcH.translatesAutoresizingMaskIntoConstraints = false
        switcH.addTarget(self, action:#selector(changeTheme) , for: .valueChanged)
        return switcH
    }()
    
    lazy var buttonRequest:UIButton = {
        let button = UIButton()
        button.setTitle("Refresh", for: .normal)
        button.backgroundColor = .systemPink
        button.setTitleColor(.black,for: .normal)
        button.layer.cornerRadius = 15
        button.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(fetchData), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
                return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 1.0, green: 0.9059, blue: 0.8196, alpha: 1.0)
        
        collectionViewPhotos.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "cellPhoto")
        
        collectionViewPhotos.delegate = self
        collectionViewPhotos.dataSource = self
        
        view.addSubview(collectionViewPhotos)
        view.addSubview(switcher)
        view.addSubview(buttonRequest)
        
        configLayout()
        collectionViewPhotos.collectionViewLayout = configureLayoutForGoalsBoard()
        
        fetchData()
    }

    func configLayout(){
        NSLayoutConstraint.activate([
            collectionViewPhotos.widthAnchor.constraint(equalToConstant: 312),
            collectionViewPhotos.heightAnchor.constraint(equalToConstant: 620),
            collectionViewPhotos.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //collectionViewPhotos.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 50),
            collectionViewPhotos.topAnchor.constraint(equalTo: view.topAnchor,constant: 120),
           // collectionViewPhotos.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50)
            
            
            switcher.topAnchor.constraint(equalTo: view.topAnchor,constant: 70),
            switcher.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
            
            buttonRequest.widthAnchor.constraint(equalToConstant: 100),
            buttonRequest.heightAnchor.constraint(equalToConstant: 40),
            buttonRequest.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -70),
            buttonRequest.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: 0)
            ])
    }
   @objc func changeTheme(){
       let isSwitched = switcher.isOn
       
        if isSwitched == true{
            view.backgroundColor = .black
            self.buttonRequest.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
            self.buttonRequest.layer.borderWidth = 1
            self.buttonRequest.translatesAutoresizingMaskIntoConstraints = false
            self.buttonRequest.setTitleColor(.white,for: .normal)
            for section in 0..<collectionViewPhotos.numberOfSections {
                for item in 0..<collectionViewPhotos.numberOfItems(inSection: section) {
                    let indexPath = IndexPath(item: item, section: section)
                    if let cell = collectionViewPhotos.cellForItem(at: indexPath) as? PhotosCollectionViewCell {
                        cell.changeCell(isSwitched: isSwitched)
                    }
                }
            }
        }
       if isSwitched == false{
           for section in 0..<collectionViewPhotos.numberOfSections {
               for item in 0..<collectionViewPhotos.numberOfItems(inSection: section) {
                   let indexPath = IndexPath(item: item, section: section)
                   if let cell = collectionViewPhotos.cellForItem(at: indexPath) as? PhotosCollectionViewCell {
                       cell.changeCell(isSwitched: isSwitched)
                   }
                   
                   
               }
               self.buttonRequest.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0)
               self.buttonRequest.layer.borderWidth = 1
               self.buttonRequest.translatesAutoresizingMaskIntoConstraints = false
               self.buttonRequest.setTitleColor(.black,for: .normal)
               view.backgroundColor = UIColor(red: 1.0, green: 0.9059, blue: 0.8196, alpha: 1.0)
           }
           //        collectionViewPhotos.reloadData()
       }
   }
    
    
    private func configureLayoutForGoalsBoard() -> UICollectionViewCompositionalLayout {
            let size = NSCollectionLayoutSize(
                widthDimension: .estimated(150),
                heightDimension: .absolute(210)
            )
            
            let item = NSCollectionLayoutItem(layoutSize: size)
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, repeatingSubitem: item, count: 2 )
            group.interItemSpacing = NSCollectionLayoutSpacing.fixed(2)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 25
            section.contentInsets = .init(
                top: 2,
                leading: 5,
                bottom: 25,
                trailing: 5
            )
            
            return UICollectionViewCompositionalLayout(section: section)
        }
    
    @objc func fetchData(){
        vm.fetchData { [weak self] cats in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionViewPhotos.reloadData()
            }
        }
    }
   

}

extension CatsListViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let url = URL(string: vm.getCats(index: indexPath.row).wikipediaURL) else { return }
        
        UIApplication.shared.open(url,options: [:],completionHandler: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.numberOrRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewPhotos.dequeueReusableCell(withReuseIdentifier: "cellPhoto", for: indexPath) as! PhotosCollectionViewCell
        
        cell.config(with: vm.getCats(index: indexPath.row))
        cell.checkEmptyText()
        
        return cell
    }
}


    


