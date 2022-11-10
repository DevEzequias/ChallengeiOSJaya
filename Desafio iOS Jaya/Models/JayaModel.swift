//
//  JayaModel.swift
//  Desafio iOS Jaya
//
//  Created by Ezequias Santos on 06/11/22.
//

import Foundation

//MARK: - JayaModelResponse

struct JayaModelResponse: Codable {
    let url: String?
    let title: String?
    let state: String?
    let user: User?
    let date: String?
    let body: String?
    
    enum CodingKeys: String, CodingKey {
        case date = "created_at"
        case url = "html_url"
        case title, state, user, body
    }
}

//MARK: - User

struct User: Codable {
    let avatar: String?
    
    enum CodingKeys: String, CodingKey {
        case avatar = "avatar_url"
    }
}
