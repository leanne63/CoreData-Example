//
//  ViewController.swift
//  _TEST_CoreData
//
//  Created by leanne on 10/10/16.
//  Copyright © 2016 leanne63. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		// set up model parts for request
		let app = AppDelegate()
		let container = app.persistentContainer
		let mainContext = container.viewContext
		let model = container.managedObjectModel
		
		// FETCH REQUEST TEMPLATE
		
		// create fetch request from template (duplicate type declaration just to show myself
		//	that this is a parameterized generics typed request
		let cheapProductsFromCountryRequest: NSFetchRequest<Product> =
			model.fetchRequestFromTemplate(withName: "CheapProductsFromCountry",
			                               substitutionVariables: ["PRICE": 20.00, "COUNTRY_CD": "CN"])
		as! NSFetchRequest<Product>
		
		// perform fetch based on template request
		guard let cheapProductsFromCountry: [Product] = try? mainContext.fetch(cheapProductsFromCountryRequest) else {
			print("***** Unable to retrieve Products From Country list *****")
			return
		}
		
		// print results of fetch
		var formattedString = ""
		print("***** PRODUCTS FROM CHINA COSTING LESS THAN $20 *****")
		for (idx, product) in cheapProductsFromCountry.enumerated() {
			if let productName = product.name, let mfrName = product.manufacturer?.name, let countryName = product.manufacturer?.country?.name {
			
				print("Product \(idx + 1): ", terminator: "")
				
				let nameString = "\(productName)\n"
				let mfrString = "Mfr:\t\t\(mfrName)\n"
				let countryString = "Country:\t\(countryName)\n"
				let priceString = "Price:\t%.2f\n"
				
				let fullString = nameString + mfrString + countryString + priceString
				
				formattedString = String(format: fullString, product.price)
				
				print(formattedString)
			}
		}
		
		
		// FETCHED PROPERTIES
		
		let cheapProducts = (cheapProductsFromCountry[0]).value(forKey: "cheapProduct") as! [Product]
		print("***** ALL PRODUCTS COSTING LESS THAN $1.00 *****")
		for (idx, product) in cheapProducts.enumerated() {
			if let productName = product.name, let mfrName = product.manufacturer?.name, let countryName = product.manufacturer?.country?.name {
				
				print("Product \(idx + 1): ", terminator: "")
				
				let nameString = "\(productName)\n"
				let mfrString = "Mfr:\t\t\(mfrName)\n"
				let countryString = "Country:\t\(countryName)\n"
				let priceString = "Price:\t%.2f\n"
				
				let fullString = nameString + mfrString + countryString + priceString
				
				formattedString = String(format: fullString, product.price)
				
				print(formattedString)
			}
		}
	}


}

