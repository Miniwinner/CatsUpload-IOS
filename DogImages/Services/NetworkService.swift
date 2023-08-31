//
//  PhotoViewModel.swift
//  DogImages
//
//  Created by Александр Кузьминов on 29.08.23.
//


import Foundation

class NetworkService {
    func fetchCats(complitions: @escaping ([WelcomeElement]) -> Void) {
       guard let url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=10&breed&api_key=live_PPCvhWLuuBxTcLGGWlN0vRXq7bF7r5R9UdrzQuHLhOj8jbseL8yOGlSOb4Yj4KGR"
       ) else {
           return
       }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let cats = try self.parseJson(type: [WelcomeElement].self, data: data)
                complitions(cats)
            } catch {
                //print("Error decoding JSON: \(error.localizedDescription)")
                print(String(describing: error))
            }
        }.resume()
    }
    
    private func parseJson<T: Decodable>(type: T.Type, data: Data) throws -> T {
        let decoder = JSONDecoder()
        let model = try decoder.decode(T.self, from: data)
        return model
    }
    
}
