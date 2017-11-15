//
//  AppDelegate.swift
//  CoreData-Example
//
//  Created by leanne on 10/10/16.
//  Copyright © 2016 leanne63. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		dropAllData()
		preloadData()
		
		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
		// Saves changes in the application's managed object context before the application terminates.
		self.saveContext()
	}

	// MARK: - Core Data stack

	lazy var persistentContainer: NSPersistentContainer = {
	    /*
	     The persistent container for the application. This implementation
	     creates and returns a container, having loaded the store for the
	     application to it. This property is optional since there are legitimate
	     error conditions that could cause the creation of the store to fail.
	    */
	    let container = NSPersistentContainer(name: "CoreData-Example")
	    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
	        if let error = error as NSError? {
	            // Replace this implementation with code to handle the error appropriately.
	            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	             
	            /*
	             Typical reasons for an error here include:
	             * The parent directory does not exist, cannot be created, or disallows writing.
	             * The persistent store is not accessible, due to permissions or data protection when the device is locked.
	             * The device is out of space.
	             * The store could not be migrated to the current model version.
	             Check the error message to determine what the actual problem was.
	             */
	            fatalError("Unresolved error \(error), \(error.userInfo)")
	        }
	    })
	    return container
	}()

	// MARK: - Core Data Saving support

	func saveContext () {
	    let context = persistentContainer.viewContext
	    if context.hasChanges {
	        do {
	            try context.save()
	        } catch {
	            // Replace this implementation with code to handle the error appropriately.
	            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	            let nserror = error as NSError
	            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
	        }
	    }
	}
	
	// MARK: - Custom Funcs
	
	func preloadData() {
		// preload some managed objects (country.code, manufacturer.name, product.name, price, weight)
		let backgroundContext = persistentContainer.newBackgroundContext()
		
		// COUNTRIES
		guard let countryEntity = NSEntityDescription.entity(forEntityName: "Country", in: backgroundContext) else {
			print("countryEntity creation failed!")
			return
		}
		let china = Country(entity: countryEntity, insertInto: backgroundContext)
		let usa = Country(entity: countryEntity, insertInto: backgroundContext)
		let mexico = Country(entity: countryEntity, insertInto: backgroundContext)
		
		china.code = "CN"
		china.name = "China"
		usa.code = "US"
		usa.name = "United States of America"
		mexico.code = "MX"
		mexico.name = "Mexico"
		
		// MANUFACTURERS
		guard let mfrEntity = NSEntityDescription.entity(forEntityName: "Manufacturer", in: backgroundContext) else {
			print("mfrEntity creation failed!")
			return
		}
		let nike = Manufacturer(entity: mfrEntity, insertInto: backgroundContext)
		let blackndecker = Manufacturer(entity: mfrEntity, insertInto: backgroundContext)
		let kenmore = Manufacturer(entity: mfrEntity, insertInto: backgroundContext)
		
		nike.name = "Nike"
		nike.country = china
		
		blackndecker.name = "Black and Decker"
		blackndecker.country = usa
		
		kenmore.name = "Kenmore"
		kenmore.country = mexico
		
		// PRODUCTS
		guard let productEntity = NSEntityDescription.entity(forEntityName: "Product", in: backgroundContext) else {
			print("productEntity creation failed!")
			return
		}
		let gymshoe = Product(entity: productEntity, insertInto: backgroundContext)
		let tshirt = Product(entity: productEntity, insertInto: backgroundContext)
		let headband = Product(entity: productEntity, insertInto: backgroundContext)
		
		let hammer = Product(entity: productEntity, insertInto: backgroundContext)
		let drill = Product(entity: productEntity, insertInto: backgroundContext)
		let screwdriver = Product(entity: productEntity, insertInto: backgroundContext)
		
		let washingmachine = Product(entity: productEntity, insertInto: backgroundContext)
		let dryer = Product(entity: productEntity, insertInto: backgroundContext)
		let repairpart = Product(entity: productEntity, insertInto: backgroundContext)
		
		gymshoe.manufacturer = nike
		gymshoe.name = "Gym Shoes, Pair"
		gymshoe.price = 120.00
		gymshoe.weight = 3.5
		
		tshirt.manufacturer = nike
		tshirt.name = "T-Shirt"
		tshirt.price = 15.00
		tshirt.weight = 1.00
		
		headband.manufacturer = nike
		headband.name = "Headband"
		headband.price = 0.50
		headband.weight = 0.25
		
		hammer.manufacturer = blackndecker
		hammer.name = "Hammer"
		hammer.price = 1.25
		hammer.weight = 2.5
		
		drill.manufacturer = blackndecker
		drill.name = "Drill"
		drill.price = 35.00
		drill.weight = 10.00
		
		screwdriver.manufacturer = blackndecker
		screwdriver.name = "Screw, Hex, Pack of 50"
		screwdriver.price = 0.75
		screwdriver.weight = 0.75
		
		washingmachine.manufacturer = kenmore
		washingmachine.name = "Washing Machine"
		washingmachine.price = 200.00
		washingmachine.weight = 100.00
		
		dryer.manufacturer = kenmore
		dryer.name = "Dryer"
		dryer.price = 200.00
		dryer.weight = 100.00
		
		repairpart.manufacturer = kenmore
		repairpart.name = "Belt, Washer Motor"
		repairpart.price = 1.75
		repairpart.weight = 0.5
		
		// PRODUCT DESCRIPTIONS
		guard let productDescriptionEntity = NSEntityDescription.entity(forEntityName: "ProductDescription", in: backgroundContext) else {
			print("productEntity creation failed!")
			return
		}
		let gymshoeDescription1 = ProductDescription(entity: productDescriptionEntity, insertInto: backgroundContext)
		let tshirtDescription1 = ProductDescription(entity: productDescriptionEntity, insertInto: backgroundContext)
		let headbandDescription1 = ProductDescription(entity: productDescriptionEntity, insertInto: backgroundContext)
		
		let hammerDescription1 = ProductDescription(entity: productDescriptionEntity, insertInto: backgroundContext)
		let drillDescription1 = ProductDescription(entity: productDescriptionEntity, insertInto: backgroundContext)
		let screwdriverDescription1 = ProductDescription(entity: productDescriptionEntity, insertInto: backgroundContext)
		
		let washingmachineDescription1 = ProductDescription(entity: productDescriptionEntity, insertInto: backgroundContext)
		let dryerDescription1 = ProductDescription(entity: productDescriptionEntity, insertInto: backgroundContext)
		let repairpartDescription1 = ProductDescription(entity: productDescriptionEntity, insertInto: backgroundContext)

		let gymshoeDescription2 = ProductDescription(entity: productDescriptionEntity, insertInto: backgroundContext)
		let tshirtDescription2 = ProductDescription(entity: productDescriptionEntity, insertInto: backgroundContext)
		let headbandDescription2 = ProductDescription(entity: productDescriptionEntity, insertInto: backgroundContext)
		
		let hammerDescription2 = ProductDescription(entity: productDescriptionEntity, insertInto: backgroundContext)
		let drillDescription2 = ProductDescription(entity: productDescriptionEntity, insertInto: backgroundContext)
		let screwdriverDescription2 = ProductDescription(entity: productDescriptionEntity, insertInto: backgroundContext)
		
		let washingmachineDescription2 = ProductDescription(entity: productDescriptionEntity, insertInto: backgroundContext)
		let dryerDescription2 = ProductDescription(entity: productDescriptionEntity, insertInto: backgroundContext)
		let repairpartDescription2 = ProductDescription(entity: productDescriptionEntity, insertInto: backgroundContext)
		
		gymshoeDescription1.name = gymshoe.name
		gymshoeDescription1.associatedOutlet = "Amazon Shoes"
		gymshoeDescription1.product = gymshoe
		gymshoeDescription2.name = gymshoe.name
		gymshoeDescription2.associatedOutlet = "Walmart Shoes"
		gymshoeDescription2.product = gymshoe
		
		tshirtDescription1.name = tshirt.name
		tshirtDescription1.associatedOutlet = "Amazon T-Shirt"
		tshirtDescription1.product = tshirt
		tshirtDescription2.name = tshirt.name
		tshirtDescription2.associatedOutlet = "Walmart T-Shirt"
		tshirtDescription2.product = tshirt
		
		headbandDescription1.name = headband.name
		headbandDescription1.associatedOutlet = "Amazon Headband"
		headbandDescription1.product = headband
		headbandDescription2.name = headband.name
		headbandDescription2.associatedOutlet = "Walmart Headband"
		headbandDescription2.product = headband
		
		hammerDescription1.name = hammer.name
		hammerDescription1.associatedOutlet = "Amazon Hammer"
		hammerDescription1.product = hammer
		hammerDescription2.name = hammer.name
		hammerDescription2.associatedOutlet = "Walmart Hammer"
		hammerDescription2.product = hammer
		
		drillDescription1.name = drill.name
		drillDescription1.associatedOutlet = "Amazon"
		drillDescription1.product = drill
		drillDescription2.name = drill.name
		drillDescription2.associatedOutlet = "Walmart"
		drillDescription2.product = drill
		
		screwdriverDescription1.name = screwdriver.name
		screwdriverDescription1.associatedOutlet = "Amazon Screwdriver"
		screwdriverDescription1.product = screwdriver
		screwdriverDescription2.name = screwdriver.name
		screwdriverDescription2.associatedOutlet = "Walmart Screwdriver"
		screwdriverDescription2.product = screwdriver
		
		washingmachineDescription1.name = washingmachine.name
		washingmachineDescription1.associatedOutlet = "Amazon Washing Machine"
		washingmachineDescription1.product = washingmachine
		washingmachineDescription2.name = washingmachine.name
		washingmachineDescription2.associatedOutlet = "Walmart Washing Machine"
		washingmachineDescription2.product = washingmachine
		
		dryerDescription1.name = dryer.name
		dryerDescription1.associatedOutlet = "Amazon Dryer"
		dryerDescription1.product = dryer
		dryerDescription2.name = dryer.name
		dryerDescription2.associatedOutlet = "Walmart Dryer"
		dryerDescription2.product = dryer
		
		repairpartDescription1.name = repairpart.name
		repairpartDescription1.associatedOutlet = "Amazon Repair Part"
		repairpartDescription1.product = repairpart
		repairpartDescription2.name = repairpart.name
		repairpartDescription2.associatedOutlet = "Walmart Repair Part"
		repairpartDescription2.product = repairpart
		
		do {
			try backgroundContext.save()
			
		} catch {
			print("***** UNABLE TO SAVE BACKGROUND CONTEXT: \(error)\n*****")
		}

		saveContext()
	}
	
	func dropAllData() {
		
		let storeCoordinator = persistentContainer.persistentStoreCoordinator
		let storeDescription = persistentContainer.persistentStoreDescriptions[0]
		guard let storeURL = storeDescription.url else {
			print("***** Unable to retrieve store URL! *****")
			return
		}
		
		print("***** STORE URL:\n\(storeURL)\n*****")
		
		do {
			try storeCoordinator.destroyPersistentStore(at: storeURL, ofType: NSSQLiteStoreType, options: nil)
		}
		catch {
			print("***** Drop all data failed! *****")
			return
		}
		
		storeCoordinator.addPersistentStore(with: storeDescription) {
			(persistentStoreCoordinator, error) in
			
			// what to do if an error occurs???
			if let error = error {
				print("***** An error occurred re-adding the persistent store:\n\(error)\n*****")
			}
		}
	}

}

