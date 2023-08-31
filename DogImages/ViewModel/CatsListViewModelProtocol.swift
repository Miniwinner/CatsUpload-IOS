//
//  CatsListViewModelProtocol.swift
//  DogImages
//
//  Created by Oleg on 31.08.2023.
//

import Foundation

protocol CatsListViewModelProtocol {
    var dataModel: [CatsListModel] { get set }
    
    func fetchData(complition: @escaping ([WelcomeElement]) -> Void)
    
    func numberOrRows() -> Int
    
    func getCats(index: Int) -> CatsListModel
}
