//
//  DetailPresenter.swift
//  24July2019SofiaCodingChallenge
//
//  Created by sofia delgado gonzalez on 7/24/19.
//  Copyright © 2019 sofia delgado gonzalez. All rights reserved.
//

import Foundation

class DetailPresenter :Network{
	
	weak var view: DetailProtocol?
	var  schools: HighSchoolNYC?
	var  satScores: [SatScores]?
	var  sat : SatScores?
	
	func attach(view: DetailProtocol) {
		self.view = view
	}
	
	
	//:Get data from ws
	func getSatScores(){
		getSatScoresFromWS{ data, message, statusCode in
			
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
				self.parseSatScores(from: data)
				self.sat = self.getSatScoresFromArray()
			} else {
				self.view?.somethingWentWrong(message: "Error desconocido")
			}
		}
	}
	
	func parseSatScores(from data: Data) -> (status: Bool, message: String?) {
		do {
			let response = try JSONDecoder().decode([SatScores].self, from: data)
			//print("RESPONSE", response)
			self.satScores = response
			view?.reloadTableView()
			return (status: true, message: nil)
		} catch {
			print("Error al parsear high shcools")
			return (status: false, message: "Error al parsear high shcools")
		}
	}
	func updateHighSchools(with data: Data){
		
	}
	
	
	
	func getSatScoresFromArray()->SatScores?{
		if let satScores = satScores, let dbn = schools?.dbn{
			print("dbn",dbn)
			for i in satScores{
				if i.dbn == dbn{
					print("found->",i)
					return i
				}
			}
		}
		return nil
	}
	
	func getSatMath()->String{
		if let sat = sat?.sat_math_avg_score{
			return sat
		}
		return "not Registered"
	}
	func getSatReading()->String{
		if let sat = sat?.sat_critical_reading_avg_score{
			return sat
		}
		return "not Registered"
	}
	func getSatWriting()->String{
		if let sat = sat?.sat_writing_avg_score{
			return sat
		}
		return "not Registered"
	}
}

