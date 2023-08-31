//
//  CatsListViewModel.swift
//  DogImages
//
//  Created by Oleg on 31.08.2023.
//

import Foundation


class CatsListViewModel: CatsListViewModelProtocol {
    private let networkService = NetworkService()
    
    var dataModel: [CatsListModel] = []
    
    let num = ["1","2","3","4","5","6","7","8","9","10"]
    
    func fetchData(complition: @escaping ([WelcomeElement]) -> Void) {
        networkService.fetchCats { [weak self] models in
            guard let self = self else { return }
            for (index, model) in models.enumerated() {
                self.dataModel.append(
                    CatsListModel(
                        breed: model.breeds.first?.name ?? "",
                        image: model.url,
                        numberOfCats: self.num[index],
                        wikipediaURL: model.breeds.first?.wikipediaURL ?? "")
                )
            }
            complition(models)
        }
    }
    
    func numberOrRows() -> Int {
        return dataModel.count
    }
    
    func getCats(index: Int) -> CatsListModel {
        return dataModel[index]
    }
}
