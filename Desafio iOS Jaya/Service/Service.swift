//
//  Service.swift
//  Desafio iOS Jaya
//
//  Created by Ezequias Santos on 06/11/22.
//

import Foundation
import Alamofire

class Service {
    
    static let sharedInstance = Service()
    
    func fetchIssue( _ completion: @escaping(_ apiData: [JayaModelResponse]?) -> Void) {
        let url: String
        url = "https://api.github.com/repos/apple/swift/issues"
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { response in
            switch response.result {
            case .success(let data):
                do {
                    let jsondata = try JSONDecoder().decode([JayaModelResponse].self, from: data!)
                    completion(jsondata)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
