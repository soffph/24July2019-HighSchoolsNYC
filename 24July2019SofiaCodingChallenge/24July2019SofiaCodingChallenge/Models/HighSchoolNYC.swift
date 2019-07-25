//
//  HighSchoolNYC.swift
//  24July2019SofiaCodingChallenge
//
//  Created by sofia delgado gonzalez on 7/24/19.
//  Copyright © 2019 sofia delgado gonzalez. All rights reserved.
//

import Foundation

struct HighSchoolNYC : Codable {
	
	var dbn: String?
	var school_name: String?
	var overview_paragraph: String?
	var academicopportunities1: String?
	var academicopportunities2: String?
	var ell_programs: String?
	var neighborhood: String?
	var building_code: String?
	var location: String?
	var phone_number: String?
	var school_email: String?
	var website: String?
	
}

struct SatScores: Codable{
	
	var dbn: String?
	var school_name: String?
	var num_of_sat_test_takers: String?
	var sat_critical_reading_avg_score: String?
	var sat_math_avg_score: String?
	var sat_writing_avg_score: String?
	
}
