//
//  HighSchoolsProtocols.swift
//  24July2019SofiaCodingChallenge
//
//  Created by sofia delgado gonzalez on 7/24/19.
//  Copyright © 2019 sofia delgado gonzalez. All rights reserved.
//

import Foundation

protocol HighSchoolsProtocol: class {
	
	func reloadTableView()
	func somethingWentWrong(message: String)
	func presentAlert(titleT : String, messageT : String )
	
}
