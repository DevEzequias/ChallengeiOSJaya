//
//  JayaViewModel.swift
//  Desafio iOS Jaya
//
//  Created by Ezequias Santos on 06/11/22.
//

import Foundation
import UIKit

// MARK: - JayaViewModelProtocol

protocol JayaViewModelProtocol {
    var issueArray: Observable<[JayaModelResponse]> { get }
}

final class JayaViewModel: JayaViewModelProtocol {
 
    // MARK: - Properties
    
    var issueArray: Observable<[JayaModelResponse]>
       
    // MARK: - Initialization
    
    init () {
        self.issueArray = Observable([])
        self.getIssue()
    }
    
    // MARK: Helpers
    
    func getIssue() {
        Service.sharedInstance.fetchIssue { apiData in
            if let apiData = apiData {
                self.issueArray.value.append(contentsOf: apiData)
            } else {
                print("erro, API instável")
            }
        }
    }
}
