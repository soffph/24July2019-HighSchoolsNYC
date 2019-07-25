//
//  DetailViewController.swift
//  24July2019SofiaCodingChallenge
//
//  Created by sofia delgado gonzalez on 7/24/19.
//  Copyright © 2019 sofia delgado gonzalez. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController {
	@IBOutlet weak var labelSchoolName: UILabel?
	@IBOutlet weak var labelOverview: UILabel?
	@IBOutlet weak var tableView : UITableView?
	
	var presenter = DetailPresenter()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		tableViewSetUp()
		setUpInfo()
		presenter.attach(view: self)
		presenter.getSatScores()
		
    }
	
	func tableViewSetUp(){
		
		guard let tableView = tableView else {return}
		tableView.delegate = self
		tableView.dataSource = self
		tableView.estimatedRowHeight = 90.0
	}
	
	func setUpInfo(){
		guard let schoolName = labelSchoolName else{return}
		guard let overview = labelOverview else{return}
		schoolName.text = presenter.schools?.school_name
		overview.text = presenter.schools?.overview_paragraph
	}
	
	@IBAction func dismissView(_ sender: UIButton) {
		self.navigationController?.popViewController(animated: false)
			self.dismiss(animated: true, completion: nil)
		
	}
	
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == 0 {
		let cell = tableView.dequeueReusableCell(withIdentifier: "location", for: indexPath) as! LocationTableViewCell
		cell.labelLocation.text = presenter.schools?.location
		return cell
		}else{
		let cell = tableView.dequeueReusableCell(withIdentifier: "SAT", for: indexPath) as! SaTTableViewCell
		cell.labelMathSat.text = presenter.getSatMath()
		cell.labelReadingSat.text = presenter.getSatReading()
		cell.labelWritingSat.text = presenter.getSatWriting()
		return cell
		}
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.row == 0{
			return 90.0
		}
		return 150.0
	}
	
}

extension DetailViewController: DetailProtocol{
	func reloadTableView() {
		DispatchQueue.main.async {
			self.tableView?.reloadData()
		}
	}
	
	func somethingWentWrong(message: String) {
		
	}
	
	func presentAlert(titleT: String, messageT: String) {
		
	}
	
	
}
