//
//  JayaViewModelSpecs.swift
//  Desafio iOS JayaTests
//
//  Created by Ezequias Santos on 07/11/22.
//

import Alamofire
import Quick
import Nimble
@testable import Desafio_iOS_Jaya

class JayaViewModelSpecs: QuickSpec {
    override func spec() {
        describe("JayaViewModel") {
            
            var sut: JayaViewModel!
            
            context("Get Issue") {
                it("Verify Data") {
                    sut = JayaViewModel()
                    expect(sut.getIssue()).to(beVoid())
                }
            }
            context("JayaViewModelProtocol") {
                it("Verify JayaViewModelProtocol") {
                    sut = JayaViewModel()
                    expect(sut).to(beAKindOf(JayaViewModelProtocol.self))
                }
            }
        }
    }
}
