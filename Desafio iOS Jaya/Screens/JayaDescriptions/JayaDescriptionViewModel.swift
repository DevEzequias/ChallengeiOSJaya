//
//  JayaDescriptionViewModel.swift
//  Desafio iOS Jaya
//
//  Created by Ezequias Santos on 06/11/22.
//

import Foundation
import UIKit

// MARK: - JayaDescriptionViewModelProtocol

protocol JayaDescriptionViewModelProtocol {
    var issueArray: Observable<JayaModelResponse?> { get }
}

final class JayaDescriptionViewModel: JayaDescriptionViewModelProtocol {
    
    // MARK: - Properties
    
    var issueArray: Observable<JayaModelResponse?>
    
    // MARK: - Initialization
    
    init (object: JayaModelResponse) {
        self.issueArray = Observable(nil)
        self.issueArray.value = object
    }
}
