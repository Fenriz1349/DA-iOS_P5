//
//  AuraTests.swift
//  AuraTests
//
//  Created by Julien Cotte on 28/11/2024.
//

import XCTest
@testable import Aura

class AuraTests: XCTestCase {

    // MARK: - Local Test
    func testLocal_isValid_invalidNames () {
        // Given
        let invalidCharacters = ["\"", "(", ")", "[", "]", ";", ":", ",", "@", "€", "¥", "£", "ç", "é", "è", "ê", "à", "À", "É", "È", "Ê" ]
        
        // Then
        for character in invalidCharacters {
            XCTAssertFalse(Local(name: "test"+character).isValid())
        }
        XCTAssertFalse(Local(name: "").isValid())
        XCTAssertFalse(Local(name: ".test").isValid())
        XCTAssertFalse(Local(name: "test.").isValid())
        XCTAssertFalse(Local(name: "-test").isValid())
        XCTAssertFalse(Local(name: "test-").isValid())
        XCTAssertFalse(Local(name: "ceciestunetrestreslonguestringplusde65caractereaverifiercalmement").isValid())
        XCTAssertFalse(Local(name: "test..test").isValid())
    }

    func testLocal_isValid_validNames() {
        // Given
        let validCharacters = [".", "!", "#", "$", "%", "&" ,"'", "*", "+", "-", "/", "=", "?", "^", "_", "`", "{", "|", "}", "~"]
        
        // Then
        for character in validCharacters {
            XCTAssertTrue(Local(name: "test"+character+"test").isValid())
        }
        XCTAssertTrue(Local(name: "test123").isValid())
        XCTAssertTrue(Local(name: "Test123").isValid())
        XCTAssertTrue(Local(name: "TEST").isValid())
        XCTAssertTrue(Local(name: "t").isValid())
        XCTAssertTrue(Local(name: "ceciestunetreslonguestringquifaitexactement64caracterestoutjuste").isValid())
    }
    
    // MARK: - Domain Test
    func testDomainName_isValidName_invalidNames () {
        // Given
        let invalidCharacters = ["!", "#", "$", "%", "&" ,"'", "*", "+", "/", "=", "?", "^", "_", "`", "{", "|", "}", "~", "\"", "(", ")", "[", "]", ";", ":", ",", "@", "€", "¥", "£", "ç", "é", "è", "ê", "à", "À", "É", "È", "Ê" ]
        
        // Then
        for character in invalidCharacters {
            XCTAssertFalse(Domain(name:"test"+character, domExtension: "").isValidName())
        }
        XCTAssertFalse(Domain(name: "", domExtension: "").isValidName())
        XCTAssertFalse(Domain(name: ".test", domExtension: "").isValidName())
        XCTAssertFalse(Domain(name: "test.", domExtension: "").isValidName())
        XCTAssertFalse(Domain(name: "-test", domExtension: "").isValidName())
        XCTAssertFalse(Domain(name: "test-", domExtension: "").isValidName())
        XCTAssertFalse(Domain(name: "test..test", domExtension: "").isValidName())
    }

    func testDomainName_isValidName_validNames() {
        XCTAssertTrue(Domain(name: "test123", domExtension: "").isValidName())
        XCTAssertTrue(Domain(name: "test.test123", domExtension: "").isValidName())
        XCTAssertTrue(Domain(name: "test-test123", domExtension: "").isValidName())
    }
    
    func testDomainExtension_isValidExtenstion_invalidExtension () {
        XCTAssertFalse(Domain(name: "", domExtension: "").isValidExtension())
        XCTAssertFalse(Domain(name: "", domExtension: "t").isValidExtension())
        XCTAssertFalse(Domain(name: "", domExtension: "12").isValidExtension())
        XCTAssertFalse(Domain(name: "", domExtension: "(/").isValidExtension())
        XCTAssertFalse(Domain(name: "", domExtension: "ceciestunetrestrestreslongueextenstionquicomportecaracteresxyzxxx").isValidExtension())
    }
    
    func testDomainExtension_isValidExtenstion_validExtension () {
        XCTAssertTrue(Domain(name: "", domExtension: "fr").isValidExtension())
        // Given exstention de 63 caractères
        XCTAssertTrue(Domain(name: "", domExtension: "ceciestunetrestrestreslongueextenstionquicomportedescaracteresx").isValidExtension())
    }
    
    func testDomain_isValid_invalidDomain () {
        // Given extension de 63 caractères et name de 256 caractères
        XCTAssertFalse(Domain(name: "ceci-est-un-nom-de-domaine-incroyablement-long-mais-qui-ne-respecte-pas-toutes-les-regles-dont-celle-de-la-longueur-maximale-car-on-aime-les-defis-techniques.pourquoi-pas-mais-alors-vraiment-pourquoi-pas-avec-des-mots-supplementaires-et-des-points-pour-etre-sur"
,  domExtension: "ceciestunetrestrestreslongueextenstionquicomportedescaracteresx").isValidDomain())
        XCTAssertFalse(Domain(name: "", domExtension: "fr").isValidDomain())
        XCTAssertFalse(Domain(name: "test", domExtension: "..").isValidDomain())
    }
    
    func testDomain_isValid_validDomain () {
        // Given extension de 63 caractères et name de 255 caractères
        XCTAssertTrue(Domain(name: "ceci-est-un-nom-de-domaine-incroyablement-long-mais-qui-respecte-toutes-les-regles-dont-celle-de-la-longueur-maximale-car-on-aime-les-defis-techniques.pourquoi-pas", domExtension: "ceciestunetrestrestreslongueextenstionquicomportedescaracteresx").isValidDomain())
    }
    
    func testDomain_from_returnNil () {
        // Given
        let testStrings = ["test@avec@trop@de@test.com",
                           "test.12",
                           "",
                           "test.c",
                           "com.com.c",
                           "test.ceciestunetrestrestreslongueextenstionquicomporte64caracteresxyz",  "ceci-est-un-nom-de-domaine-incroyablement-long-mais-qui-ne-respecte-pas-toutes-les-regles-dont-celle-de-la-longueur-maximale-car-on-aime-les-defis-techniques.pourquoi-pas-mais-alors-vraiment-pourquoi-pas-avec-des-mots-supplementaires-et-des-points-pour-etre-sur.ceciestunetrestrestreslongueextenstionquicomportedescaracteresx"
                          ]
        
        // Then
        for testString in testStrings {
            XCTAssertNil(Domain.from(testString))
        }
    }
    func testDomain_from_returnDomain () {
        if let domain1 = Domain.from("test.fr") {
            XCTAssertEqual(domain1.name, "test")
            XCTAssertEqual(domain1.domExtension, "fr")
        }
        if let domain2 = Domain.from("AZERT123.com") {
            XCTAssertEqual(domain2.name, "AZERT123")
            XCTAssertEqual(domain2.domExtension, "com")
        }
        if let domain3 = Domain.from("TEST.FR") {
            XCTAssertEqual(domain3.name, "TEST")
            XCTAssertEqual(domain3.domExtension, "FR")
        }
        if let domain4 = Domain.from("test.test.test.FR") {
            XCTAssertEqual(domain4.name, "test.test.test")
            XCTAssertEqual(domain4.domExtension, "FR")
        }
    }
    
    func testEmail_from_returnNil () {
        // Given
        let testStrings = ["test@avec@trop@de@test.com",
                           ".test@test.fr",
                           "test.@test.fr",
                           "test@.test.fr",
                           "test&test..fr",
                           "test.12",
                           "",
                           "test@test.c",
                           "com.com.c",
                           "test@test.ceciestunetrestrestreslongueextenstionquicomporte64caracteresxyz",  "ceci-est-un-nom-de-domaine-incroyablement-long-mais-qui-ne-respecte-pas-toutes-les-regles-dont-celle-de-la-longueur-maximale-car-on-aime-les-defis-techniques.pourquoi-pas-mais-alors-vraiment-pourquoi-pas-avec-des-mots-supplementaires-et-des-points-pour-etre-sur.ceciestunetrestrestreslongueextenstionquicomportedescaracteresx",
                           "ceciestunetrestreslonguestringplusde65caractereaverifiercalmement@test.fr",
                           "§çèçè§@fr&é;com"
                          ]
        
        // Then
        for testString in testStrings {
            XCTAssertNil(Email.from(testString))
        }
    }
    
    func testEmail_from_returnEmail () {
        if let email1 = Email.from("test@test.fr") {
            XCTAssertEqual(email1.local.name, "test")
            XCTAssertEqual(email1.domain.name, "test")
            XCTAssertEqual(email1.domain.domExtension, "fr")
        }
        if let email2 = Email.from("Jean.Jacques!Chirac@AZERT123.com") {
            XCTAssertEqual(email2.local.name, "Jean.Jacques!Chirac")
            XCTAssertEqual(email2.domain.name, "AZERT123")
            XCTAssertEqual(email2.domain.domExtension, "com")
        }
        if let email3 = Email.from("TEST@TEST.FR") {
            XCTAssertEqual(email3.local.name, "TEST")
            XCTAssertEqual(email3.domain.name, "TEST")
            XCTAssertEqual(email3.domain.domExtension, "FR")
        }
        if let email4 = Email.from("test@test.test.test.FR") {
            XCTAssertEqual(email4.local.name, "test")
            XCTAssertEqual(email4.domain.name, "test.test.test")
            XCTAssertEqual(email4.domain.domExtension, "FR")
        }
    }
    
    func testisEmail_isValidEmail_returnFalse () {
        // Given
        let testStrings = ["test@avec@trop@de@test.com",
                           ".test@test.fr",
                           "test.@test.fr",
                           "test@.test.fr",
                           "test&test..fr",
                           "test.12",
                           "",
                           "test@test.c",
                           "com.com.c",
                           "test@test.ceciestunetrestrestreslongueextenstionquicomporte64caracteresxyz",  "ceci-est-un-nom-de-domaine-incroyablement-long-mais-qui-ne-respecte-pas-toutes-les-regles-dont-celle-de-la-longueur-maximale-car-on-aime-les-defis-techniques.pourquoi-pas-mais-alors-vraiment-pourquoi-pas-avec-des-mots-supplementaires-et-des-points-pour-etre-sur.ceciestunetrestrestreslongueextenstionquicomportedescaracteresx",
                           "ceciestunetrestreslonguestringplusde65caractereaverifiercalmement@test.fr",
                           "§çèçè§@fr&é;com"
                          ]
        
        // Then
        for testString in testStrings {
            XCTAssertFalse(Email.isValidEmail(testString))
        }
    }
    
    func testisEmail_isValidEmail_returnTrue () {
        XCTAssertTrue(Email.isValidEmail("test@test.fr"))
        XCTAssertTrue(Email.isValidEmail("Jean.Jacques!Chirac@AZERT123.com"))
        XCTAssertTrue(Email.isValidEmail("TEST@TEST.FR"))
        XCTAssertTrue(Email.isValidEmail("test@test.test.test.FR"))
    }
}
