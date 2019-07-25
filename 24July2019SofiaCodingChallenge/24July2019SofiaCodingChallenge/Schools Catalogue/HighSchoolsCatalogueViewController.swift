//
//  HighSchoolsCatalogueViewController.swift
//  24July2019SofiaCodingChallenge
//
//  Created by sofia delgado gonzalez on 7/24/19.
//  Copyright © 2019 sofia delgado gonzalez. All rights reserved.
//

import UIKit

class HighSchoolsCatalogueViewController: UIViewController{
	
	@IBOutlet weak var tableView: UITableView?
	@IBOutlet weak var activity: UIActivityIndicatorView!
	//weak var delegate : receiveDataProtocol?
	var presenter = HighSchoolsCataloguePresenter()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableViewSetUp()
		presenter.attach(view: self)
		self.tableView?.alpha = 0.0
		activity.startAnimating()
		presenter.getHighSchools()
	}
	
	func tableViewSetUp(){
		guard let tableView = tableView else {return}
		tableView.delegate = self
		tableView.dataSource = self
		let bundle = Bundle(for: TableViewCell.self)
		let nib = UINib(nibName: "TableViewCell", bundle: bundle)
		tableView.register(nib, forCellReuseIdentifier: "School")
		tableView.estimatedRowHeight = 210.0
	}
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let destination = segue.destination as? DetailViewController{
			if let school = presenter.schoolSelected{
			destination.presenter.schools = school
			}
		}
	}
}

extension HighSchoolsCatalogueViewController : UITableViewDelegate, UITableViewDataSource{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 30
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "School", for: indexPath) as! TableViewCell
		if let schoolInfo = presenter.getSchool(index : indexPath.row){
			cell.LabelSchoolName.text = schoolInfo.school_name
			cell.Labelphone.text = schoolInfo.phone_number
			cell.LabelEmail.text = schoolInfo.school_email
			cell.LabelWebsite.text = schoolInfo.website
		}
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		presenter.index = indexPath.row
		performSegue(withIdentifier: "detail", sender: nil)
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 210.0
	}
	
	
	
}

extension HighSchoolsCatalogueViewController : HighSchoolsProtocol{
	func reloadTableView() {
		DispatchQueue.main.async {
			self.tableView?.reloadData()
			self.tableView?.alpha = 1.0
			self.activity.stopAnimating()
		}
	}
	
	func somethingWentWrong(message: String) {
		print(message)
	}
	
	func presentAlert(titleT: String, messageT: String) {
		print(messageT)
	}
}
