//
//  JayaDescriptionViewModelSpecs.swift
//  Desafio iOS JayaTests
//
//  Created by Ezequias Santos on 08/11/22.
//

import Alamofire
import Quick
import Nimble
@testable import Desafio_iOS_Jaya

class JayaDescriptionViewModelSpecs: QuickSpec {
    override func spec() {
        describe("JayaDescriptionViewModel") {
            
            var sut: JayaDescriptionViewModel!
            
            context("JayaDescriptionViewModelProtocol") {
                it("Verify JayaDescriptionViewModelProtocol") {
                    let jayaModelResponse = JayaModelResponse(url: "", title: "", state: "", user: User(avatar: ""), date: "", body: "")
                    sut = JayaDescriptionViewModel(object: jayaModelResponse)
                    expect(sut).to(beAKindOf(JayaDescriptionViewModelProtocol.self))
                }
            }
        }
    }
}
