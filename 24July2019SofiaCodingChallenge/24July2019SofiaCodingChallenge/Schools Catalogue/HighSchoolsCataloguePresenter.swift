//
//  HighSchoolsCataloguePresenter.swift
//  24July2019SofiaCodingChallenge
//
//  Created by sofia delgado gonzalez on 7/24/19.
//  Copyright © 2019 sofia delgado gonzalez. All rights reserved.
//

import Foundation

class HighSchoolsCataloguePresenter : Network{
	
	weak var view: HighSchoolsProtocol?
	var  schools: [HighSchoolNYC]?
	var index: Int?
	var  schoolSelected : HighSchoolNYC?{
		return schools?[index!]
	}
	
	func attach(view: HighSchoolsProtocol) {
		self.view = view
	}
	
	
	//:Get data from ws
	func getHighSchools(){
		getHighSchoolsInfoFromWS { data, message, statusCode in
			
			if let errorMessage = message {
				self.view?.somethingWentWrong(message: errorMessage)
				print("statusCode: ", statusCode)
				return
			}
			
			if let code = statusCode, code == 400 {
				//failed getting data from ws
				self.view?.somethingWentWrong(message: message!)
				print("data", data, "message", message, "statusCode", statusCode)
			}
			
			if let data = data, let code = statusCode, code == 200 {
				print("data", data, "message", message, "statusCode", statusCode)
				self.parseHighSchoolsData(from: data)
				
			} else {
				self.view?.somethingWentWrong(message: "Error desconocido")
			}
		}
	}
	
	func parseHighSchoolsData(from data: Data) -> (status: Bool, message: String?) {
		do {
			let response = try JSONDecoder().decode([HighSchoolNYC].self, from: data)
			//print("RESPONSE", response)
			self.schools = response
			view?.reloadTableView()
			return (status: true, message: nil)
		} catch {
			print("Error al parsear high shcools")
			return (status: false, message: "Error al parsear high shcools")
			
		}
	}
	func updateHighSchools(with data: Data){
		
	}
	
	func getSchool(index : Int)-> HighSchoolNYC?{
		return schools?[index]
	}
}
