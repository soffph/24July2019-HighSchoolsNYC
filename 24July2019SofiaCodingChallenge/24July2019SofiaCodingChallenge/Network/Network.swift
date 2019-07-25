//
//  Network.swift
//  24July2019SofiaCodingChallenge
//
//  Created by sofia delgado gonzalez on 7/24/19.
//  Copyright © 2019 sofia delgado gonzalez. All rights reserved.
//

import Foundation

protocol Network{}

struct GeneralError : Codable{
	let message : String
}

extension Network{
	
	//: Completion handler for ws requests
	typealias RequestHandler = (Data?, String?, Int?) -> Void
	
	//: Get information from ws, create request and pass information in completion
	func getHighSchoolsInfoFromWS(completion: @escaping RequestHandler){
		
		var urlComponents = URLComponents()
		urlComponents.scheme = Endpoint.scheme
		urlComponents.host = Endpoint.host
		urlComponents.path = Endpoint.highSchoolsPath
		
		if let url = urlComponents.url {
			var request = URLRequest(url: url)
			request.httpMethod = "GET"
			URLSession.shared.dataTask(with: request) { (dat, response, err) in
				if let httpResponse = response as? HTTPURLResponse, let data = dat{
					switch httpResponse.statusCode{
					case 200:
						completion(data, nil, 200)
					case 400:
						completion(nil, nil, 400)
					default:
						completion(nil, self.parseError(from: data), httpResponse.statusCode)
					}
				} else {
					completion(nil, "Servicio no disponible por el momento", nil)
				}
				}.resume()
		} else {
			completion(nil, "no se puede construir el url", nil)
		}
	}
	
	
	func parseError(from data : Data?) -> String {
		do{
			guard let data = data else { return "" }
			let generalError = try JSONDecoder().decode(GeneralError.self, from: data)
			return generalError.message
		}catch{
			print("Error al parsear error")
			return "Servicio no disponible"
		}
	}
	
	func getSatScoresFromWS(completion: @escaping RequestHandler){
		
		var urlComponents = URLComponents()
		urlComponents.scheme = Endpoint.scheme
		urlComponents.host = Endpoint.host
		urlComponents.path = Endpoint.satScoresPath
		
		if let url = urlComponents.url {
			var request = URLRequest(url: url)
			request.httpMethod = "GET"
			URLSession.shared.dataTask(with: request) { (dat, response, err) in
				if let httpResponse = response as? HTTPURLResponse, let data = dat{
					switch httpResponse.statusCode{
					case 200:
						completion(data, nil, 200)
					case 400:
						completion(nil, nil, 400)
					default:
						completion(nil, self.parseError(from: data), httpResponse.statusCode)
					}
				} else {
					completion(nil, "Servicio no disponible por el momento", nil)
				}
				}.resume()
		} else {
			completion(nil, "no se puede construir el url", nil)
		}
	}
	
}



