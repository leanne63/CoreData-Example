//
//  ViewController.swift
//  CoreData-Example
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
		
		//** FETCH REQUEST TEMPLATE **//
		
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
		// initialize a temporary Product to hold most expensive product found
		guard let productEntityDescription = NSEntityDescription.entity(forEntityName: "Product", in: mainContext) else {
			print("Unable to create Product entity description!")
			return
		}
		var mostExpensiveProduct: Product = NSManagedObject(entity: productEntityDescription, insertInto: nil) as! Product
		mostExpensiveProduct.name = "Test Product"
		// price defaults to 0 in model graph
		
		print("***** PRODUCTS FROM CHINA COSTING LESS THAN $20 *****")
		for (idx, product) in cheapProductsFromCountry.enumerated() {
			if mostExpensiveProduct.price < product.price {
				mostExpensiveProduct = product
			}
			// note: in model, we could set these as not optional if we want to ensure they're there!
			//	(hmm, that may not work - after changing some items in the model to be not optional, they still show up here as optional)
			// (these values will be present in our test model)
			if let productName = product.name, let mfrName = product.manufacturer?.name, let countryName = product.manufacturer?.country?.name {
			
				print("Product \(idx + 1): ", terminator: "")
				
				let nameString = "\(productName)\n"
				let mfrString = "Mfr:\t\t\(mfrName)\n"
				let countryString = "Country:\t\(countryName)\n"
				let priceString = "Price:\t%.2f\n"
				
				let fullString = nameString + mfrString + countryString + priceString
				let formattedString = String(format: fullString, product.price)
				
				print(formattedString)
			}
		}
		
		
		//** FETCHED PROPERTIES **//
		
		/* fetched property with replaceable parameter (using $FETCH_SOURCE, so comparing based on selected product) */
		let cheaperProducts = mostExpensiveProduct.value(forKey: "cheaperProducts") as! [Product]
		
		var stringToFormat = "***** ALL PRODUCTS COSTING LESS THAN \(mostExpensiveProduct.name!) @ $%.2f *****"
		var formattedString = String(format: stringToFormat, mostExpensiveProduct.price)
		print(formattedString)
		
		for (idx, product) in cheaperProducts.enumerated() {
			if let productName = product.name, let mfrName = product.manufacturer?.name, let countryName = product.manufacturer?.country?.name {
				
				print("Product \(idx + 1): ", terminator: "")
				
				let nameString = "\(productName)\n"
				let mfrString = "Mfr:\t\t\(mfrName)\n"
				let countryString = "Country:\t\(countryName)\n"
				let priceString = "Price:\t%.2f\n"
				
				stringToFormat = nameString + mfrString + countryString + priceString
				formattedString = String(format: stringToFormat, product.price)
				
				print(formattedString)
			}
		}
		
		/* fetched property without replaceable parameter (not using $FETCH_SOURCE, so any product would return same result) */
		var cheapProducts = cheapProductsFromCountry[1].value(forKey: "cheapProducts") as! [Product]
		
		// and sort by price (descending)
		cheapProducts.sort { $0.price > $1.price }
		
		print("***** ALL PRODUCTS COSTING LESS THAN $1.00 (sorted by price, high to low) *****")
		
		for (idx, product) in cheapProducts.enumerated() {
			if let productName = product.name, let mfrName = product.manufacturer?.name, let countryName = product.manufacturer?.country?.name {
				
				print("Product \(idx + 1): ", terminator: "")
				
				let nameString = "\(productName)\n"
				let mfrString = "Mfr:\t\t\(mfrName)\n"
				let countryString = "Country:\t\(countryName)\n"
				let priceString = "Price:\t%.2f\n"
				
				let fullString = nameString + mfrString + countryString + priceString
				let formattedString = String(format: fullString, product.price)
				
				print(formattedString)
			}
		}
		
		
		/* fetched property based on relationship (allProductsFromManufacturer: manufacturer == $FETCH_SOURCE.manufacturer) */
		// fetched property with replaceable parameter (using $FETCH_SOURCE, so comparing based on selected product)
		var productsFromMfr = mostExpensiveProduct.value(forKey: "allProductsFromManufacturer") as! [Product]
		
		// and sort by name (ascending, in-place sort)
		productsFromMfr.sort { $0.name! < $1.name! }
		
		stringToFormat = "***** ALL PRODUCTS MANUFACTURED BY \(mostExpensiveProduct.manufacturer!.name!) (sorted by product name, A-Z) *****"
		formattedString = String(format: stringToFormat, mostExpensiveProduct.price)
		print(formattedString)
		
		for (idx, product) in productsFromMfr.enumerated() {
			if let productName = product.name, let mfrName = product.manufacturer?.name, let countryName = product.manufacturer?.country?.name {
				
				print("Product \(idx + 1): ", terminator: "")
				
				let nameString = "\(productName)\n"
				let mfrString = "Mfr:\t\t\(mfrName)\n"
				let countryString = "Country:\t\(countryName)\n"
				let priceString = "Price:\t%.2f\n"
				
				let fullString = nameString + mfrString + countryString + priceString
				let formattedString = String(format: fullString, product.price)
				
				print(formattedString)
			}
		}
		
		print("+++++\nproductsFromMfr - sorted:\n\(productsFromMfr)\n+++++")
		
		
		//** PULLING RESULTS BASED ON AN ENTITY RELATIONSHIP - retrieving product descriptions by using relationship in product **//
		
		// 'productDescriptions' is a relationship within the Product entity, so use it
		// we'll need to convert the NSSet results from Core Data to a Swift Set; then convert that result to an array
		let prodDescriptionsSet: Set<ProductDescription> = mostExpensiveProduct.productDescriptions as! Set<ProductDescription>
		let prodDescriptionsArray: [ProductDescription] = Array(prodDescriptionsSet)
		
		print("+++++\nProduct description outlets for expensive product '\(mostExpensiveProduct.name!)' via relationship:")
		for (idx, productDescription) in prodDescriptionsArray.enumerated() {
			print("\(productDescription.name!) Retail Outlet \(idx + 1): \(productDescription.associatedOutlet!)")
		}
		print("+++++")
		
		
		// whereas, using a fetched property would require that we have a product description already handy...
		//	one way to do that would seem to be to instantiate an entity, give it a value, then pull the fetched property via that entity:
		
		// initialize a temporary Product to hold most t-shirt product, and assign it a name (so we know it's a t-shirt!)
		guard let productDescriptionEntity = NSEntityDescription.entity(forEntityName: "ProductDescription", in: mainContext) else {
			print("Unable to create Product entity description!")
			return
		}
		let tShirtProductDescription: ProductDescription =
			NSManagedObject(entity: productDescriptionEntity, insertInto: nil) as! ProductDescription
		tShirtProductDescription.name = "T-Shirt"
		
		// call the fetched property...
		let tShirtProductDescriptionArray = tShirtProductDescription.value(forKey: "allDescriptionsForProduct") as! [ProductDescription]
		
		// BUT!!!! This doesn't work! We have to use an actual existing entity, so our results come out empty.
		//	Use fetched properties, then, when we already have an entity that we'd like to use to retrieve some refined set
		print("+++++\nProduct description outlets for product '\(tShirtProductDescription.name!)' via fetched query:")
		for (idx, productDescription) in tShirtProductDescriptionArray.enumerated() {
			print("\(productDescription.name!) Retail Outlet \(idx + 1): \(productDescription.associatedOutlet!)")
		}
		print("+++++")
	}


}

